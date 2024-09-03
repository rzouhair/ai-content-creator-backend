import string
from app_auth.helpers import get_user_from_token
from keywordresearch.helpers.search_results import extract_ppa_questions, extract_related_questions, get_google_suggestions
import requests
from bs4 import BeautifulSoup

from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework import status

from keywordresearch.serializers import KeywordsPostSerializer, SuggestionSerializer


def replace_placeholder(value, replacement):
  return value.replace('%', replacement)

base_keyword_qualifiers = {
  'US': [
    'What %',
    '% vs',
    'Can %',
    'Will %',
    'Which %',
    'What is the difference %',
    '% ideas',
    'Is %',
    '% alternatives',
    'What to do if %',
    'Should %',
    'When is %',
    'is %',
    'Why does %',
    '% tips',
    'Why doesn’t %',
    'When does %',
    'Best %',
    'Why can’t %',
  ],
  'ES': [
    '¿Qué %',
    '% vs',
    '¿Puede %',
    '¿Va a %',
    '¿Cuál %',
    '¿Cuál es la diferencia %',
    '% ideas',
    'Es %',
    '% alternativas',
    'Qué hacer si %',
    'Debe %',
    'Cuándo es %',
    'es %',
    '¿Por qué %',
    '% consejos',
    'Por qué no %',
    'Cuándo hace %',
    'Mejor %',
    'Por qué no puedo %',
  ],
  'FR': [
    'Quel %',
    '% vs',
    'Peut %',
    'Va %',
    'Quel %',
    'Quelle est la différence %',
    '% idées',
    'Est %',
    '% alternatives',
    'Que faire si %',
    'Devrait %',
    'Quand est %',
    'est %',
    'Pourquoi %',
    '% conseils',
    'Pourquoi ne % pas',
    'Quand fait %',
    'Meilleur %',
    'Pourquoi ne peux-tu pas %',
  ],
  'IT': [
    'Cosa %',
    '% vs',
    'Può %',
    'Andrà %',
    'Quale %',
    'Qual è la differenza %',
    '% idee',
    'È %',
    '% alternative',
    'Cosa fare se %',
    'Dovrebbe %',
    'Quando è %',
    'è %',
    'Perché %',
    '% suggerimenti',
    'Perché non %',
    'Quando fa %',
    'Migliore %',
    'Perché non posso %',
  ]
}

concept_plural_qualifiers = {
  'US': [
    'What %',
    'How much do %',
    '% vs',
    'Can %',
    'Ideas for %',
    'Will %',
    'Best % for',
    'My % are',
    'Which %',
    'How to make %',
    'How often do %',
    'Step by step instructions for %',
    'What to do if %',
    'What is the difference between %',
    'When is %',
    'Should %',
    'Pros and cons of %',
    'Ideas for improving %',
    'Why do %',
    '% alternatives',
    'How to fit %',
    'Are %',
    'Why are %',
    'What if %',
    'Why do my %',
    'When do %',
    'are %',
  ],
  'ES': [
    '¿Qué %',
    '¿Cuánto cuesta %',
    '% vs',
    '¿Puede %',
    'Ideas para %',
    '¿Va a %',
    'Mejor % para',
    'Mis % son',
    '¿Cuál %',
    'Cómo hacer %',
    '¿Con qué frecuencia %',
    'Instrucciones paso a paso para %',
    'Qué hacer si %',
    '¿Cuál es la diferencia entre %',
    'Cuándo es %',
    'Debe %',
    'Pros y contras de %',
    'Ideas para mejorar %',
    '¿Por qué %',
    '% alternativas',
    'Cómo ajustar %',
    'Son %',
    '¿Por qué son %',
    '¿Qué pasa si %',
    '¿Por qué mis %',
    'Cuándo hacen %',
    'son %',
  ],
  'FR': [
    'Quel %',
    'Combien coûtent %',
    '% vs',
    'Peut %',
    'Idées pour %',
    'Va %',
    'Meilleur % pour',
    'Mes % sont',
    'Quel %',
    'Comment faire %',
    'À quelle fréquence %',
    'Instructions étape par étape pour %',
    'Que faire si %',
    'Quelle est la différence entre %',
    'Quand est %',
    'Devrait %',
    'Les pour et les contre de %',
    'Idées pour améliorer %',
    'Pourquoi %',
    '% alternatives',
    'Comment ajuster %',
    'Sont %',
    'Pourquoi sont %',
    'Que se passe-t-il si %',
    'Pourquoi mes %',
    'Quand font %',
    'sont %',
  ],
  'IT': [
    'Cosa %',
    'Quanto costa %',
    '% vs',
    'Può %',
    'Idee per %',
    'Andrà %',
    'Migliore % per',
    'I miei % sono',
    'Quale %',
    'Come fare %',
    'Con quale frequenza %',
    'Istruzioni passo passo per %',
    'Cosa fare se %',
    'Qual è la differenza tra %',
    'Quando è %',
    'Dovrebbe %',
    'I pro e i contro di %',
    'Idee per migliorare %',
    'Perché %',
    '% alternative',
    'Come adattare %',
    'Sono %',
    'Perché sono %',
    'Cosa succede se %',
    'Perché i miei %',
    'Quando fanno %',
    'sono %',
  ]
}

# The rest of the dictionaries follow a similar pattern, but I'll provide the final ones for brevity.

concept_singular_qualifiers = {
  'US': [
    'ideas %',
    'Why is %',
    '% vs',
    'Best % for',
    'Cheapest %',
    'tips %',
    'Prevent % from',
    'How to use %',
    'My % has started to',
    '% step by step instruction',
    'Problem with %',
    'My % has a problem',
    'When is a %',
    'What to do if a %',
    'Why does my %',
    'Why doesn’t my %',
    'What if a %',
    'alternatives %',
    'My % is',
    'When does %',
    'Is a %',
  ],
  'ES': [
    'ideas %',
    '¿Por qué es %',
    '% vs',
    'Mejor % para',
    'Más barato %',
    'consejos %',
    'Prevenir % de',
    'Cómo usar %',
    'Mi % ha empezado a',
    '% instrucción paso a paso',
    'Problema con %',
    'Mi % tiene un problema',
    'Cuándo es un %',
    'Qué hacer si un %',
    '¿Por qué mi %',
    'Por qué no mi %',
    'Qué pasa si un %',
    'alternativas %',
    'Mi % es',
    'Cuando hace %',
    'Es un %',
  ],
  'FR': [
    'idées %',
    'Pourquoi est %',
    '% vs',
    'Meilleur % pour',
    'Le moins cher %',
    'conseils %',
    'Empêcher % de',
    'Comment utiliser %',
    'Mon % a commencé à',
    '% instruction étape par étape',
    'Problème avec %',
    'Mon % a un problème',
    'Quand est un %',
    'Que faire si un %',
    'Pourquoi mon %',
    'Pourquoi mon % ne',
    'Que se passe-t-il si un %',
    'alternatives %',
    'Mon % est',
    'Quand fait %',
    'Est un %',
  ],
  'IT': [
    'idee %',
    'Perché è %',
    '% vs',
    'Migliore % per',
    'Il più economico %',
    'consigli %',
    'Prevenire % da',
    'Come usare %',
    'Il mio % ha iniziato a',
    '% istruzione passo passo',
    'Problema con %',
    'Il mio % ha un problema',
    'Quando è un %',
    'Cosa fare se un %',
    'Perché il mio %',
    'Perché il mio % non',
    'Cosa succede se un %',
    '% alternative',
    'Il mio % è',
    'Quando fa %',
    'È un %',
  ]
}

person_involved_qualifiers = {
  'US': [
    'Why do %',
    'Are %',
    'How many %',
    'How much do %',
    'Tips for %',
    'How much %',
    'Best % for',
    'What to do if %',
    'ideas %',
    'alternatives %',
    'Why are %',
    'How to make %',
    '% vs',
    'Why can’t %',
    'Why don’t %',
    'Which %',
    'Should %',
    'What is the difference between %',
    'What %',
    'How do %',
    'Aren’t %',
    'What if %',
  ],
  'ES': [
    '¿Por qué %',
    'Son %',
    '¿Cuántos %',
    '¿Cuánto cuesta %',
    'Consejos para %',
    '¿Cuánto %',
    'Mejor % para',
    'Qué hacer si %',
    'ideas %',
    'alternativas %',
    '¿Por qué son %',
    'Cómo hacer %',
    '% vs',
    '¿Por qué no se puede %',
    'Por qué no %',
    'Cuál %',
    'Debe %',
    '¿Cuál es la diferencia entre %',
    '¿Qué %',
    'Cómo hacer %',
    '¿No son %',
    'Qué pasa si %',
  ],
  'FR': [
    'Pourquoi %',
    'Sont %',
    'Combien de %',
    'Combien coûtent %',
    'Conseils pour %',
    'Combien %',
    'Meilleur % pour',
    'Que faire si %',
    'idées %',
    'alternatives %',
    'Pourquoi sont %',
    'Comment faire %',
    '% vs',
    'Pourquoi ne peut-on pas %',
    'Pourquoi ne % pas',
    'Quel %',
    'Devrait %',
    'Quelle est la différence entre %',
    'Quel %',
    'Comment faire %',
    'Ne sont-ils pas %',
    'Que se passe-t-il si %',
  ],
  'IT': [
    'Perché %',
    'Sono %',
    'Quanti %',
    'Quanto costa %',
    'Consigli per %',
    'Quanto %',
    'Migliore % per',
    'Cosa fare se %',
    'idee %',
    'alternative %',
    'Perché sono %',
    'Come fare %',
    '% vs',
    'Perché non si può %',
    'Perché non %',
    'Quale %',
    'Dovrebbe %',
    'Qual è la differenza tra %',
    'Cosa %',
    'Come fare %',
    'Non sono %',
    'Cosa succede se %',
  ]
}

action_phrase_qualifiers = {
  'US': [
    'How to %',
    'How do you %',
    'When to %',
    'Best way to %',
    'Should you %',
    'What if you %',
    'step by step instructions %',
  ],
  'ES': [
    'Cómo %',
    'Cómo se hace %',
    'Cuándo %',
    'La mejor manera de %',
    '¿Deberías %',
    '¿Qué pasa si %',
    'instrucciones paso a paso %',
  ],
  'FR': [
    'Comment %',
    'Comment faites-vous %',
    'Quand %',
    'La meilleure façon de %',
    'Devriez-vous %',
    'Que se passe-t-il si vous %',
    'instructions étape par étape %',
  ],
  'IT': [
    'Come %',
    'Come si fa a %',
    'Quando %',
    'Il modo migliore per %',
    'Dovresti %',
    'Cosa succede se %',
    'istruzioni passo passo %',
  ]
}

continuous_verb_qualifiers = {
  'US': [
    'What %',
    'Can %',
    'Will %',
    'Which %',
    'What is the difference between %',
    'How to make %',
    'Pros and cons of %',
    'Tips for %',
    'Why does %',
    'What to do if %',
    '% alternatives',
    'ideas %',
    'Will %',
    'Is %',
    'Isn’t %',
    'Why is %',
    'Why doesn’t %',
    'How much %',
    'Why can’t %',
    'How does %',
  ],
  'ES': [
    '¿Qué %',
    'Puede %',
    'Va a %',
    '¿Cuál %',
    '¿Cuál es la diferencia entre %',
    'Cómo hacer %',
    'Pros y contras de %',
    'Consejos para %',
    '¿Por qué %',
    'Qué hacer si %',
    '% alternativas',
    'ideas %',
    'Va a %',
    'Es %',
    'No es %',
    '¿Por qué es %',
    '¿Por qué no %',
    '¿Cuánto %',
    '¿Por qué no puedo %',
    'Cómo %',
  ],
  'FR': [
    'Quel %',
    'Peut %',
    'Va %',
    'Quel %',
    'Quelle est la différence entre %',
    'Comment faire %',
    'Pour et contre de %',
    'Conseils pour %',
    'Pourquoi %',
    'Que faire si %',
    '% alternatives',
    'idées %',
    'Va %',
    'Est %',
    'N’est pas %',
    'Pourquoi est %',
    'Pourquoi ne % pas',
    'Combien %',
    'Pourquoi ne peut-on pas %',
    'Comment %',
  ],
  'IT': [
    'Cosa %',
    'Può %',
    'Andrà %',
    'Quale %',
    'Qual è la differenza tra %',
    'Come fare %',
    'Pro e contro di %',
    'Consigli per %',
    'Perché %',
    'Cosa fare se %',
    '% alternative',
    'idee %',
    'Andrà %',
    'È %',
    'Non è %',
    'Perché è %',
    'Perché non %',
    'Quanto %',
    'Perché non si può %',
    'Come %',
  ]
}


questions_modifiers = {
  'US': [
    "are %",
    "can %",
    "how %",
    "what %",
    "when %",
    "where %",
    "which %",
    "who %",
    "why %",
    "will %"
  ],
  'ES': [
    "¿son %",
    "¿puede %",
    "¿cómo %",
    "¿qué %",
    "¿cuándo %",
    "¿dónde %",
    "¿cuál %",
    "¿quién %",
    "¿por qué %",
    "¿va a %",
    "¿necesita %",
    "¿cuánto %",
    "¿cuál es %",
    "¿cuál será %"
  ],
  'FR': [
    "sont %",
    "peut %",
    "comment %",
    "que %",
    "quand %",
    "où %",
    "quel %",
    "qui %",
    "pourquoi %",
    "va %",
    "besoin de %",
    "combien %",
    "qu'est-ce que %",
    "quel sera %"
  ],
  'IT': [
    "sono %",
    "può %",
    "come %",
    "cosa %",
    "quando %",
    "dove %",
    "quale %",
    "chi %",
    "perché %",
    "andrà %",
    "necessita %",
    "quanto %",
    "cosa sarà %",
    "qual è %"
  ]
}

prepositions_modifiers = {
  'US': [
    "can %",
    "for %",
    "is %",
    "% near",
    "% to",
    "% with",
    "% without"
  ],
  'ES': [
    "puede %",
    "para %",
    "es %",
    "% cerca de",
    "% a",
    "% con",
    "% sin",
    "% sobre"
  ],
  'FR': [
    "peut %",
    "pour %",
    "est %",
    "% près de",
    "% à",
    "% avec",
    "% sans",
    "% sur"
  ],
  'IT': [
    "può %",
    "per %",
    "è %",
    "% vicino",
    "% a",
    "% con",
    "% senza",
    "% su"
  ]
}

comparisons = {
  'US': [
    "% and",
    "% like",
    "% or",
    "% versus",
    "% vs"
  ],
  'ES': [
    "% y",
    "% como",
    "% o",
    "% versus",
    "% vs",
    "% igual que"
  ],
  'FR': [
    "% et",
    "% comme",
    "% ou",
    "% contre",
    "% vs",
    "% similaire à"
  ],
  'IT': [
    "% e",
    "% come",
    "% o",
    "% contro",
    "% vs",
    "% simile a"
  ]
}




def autocomplete_suggestions(data):
  country = data.get('country', 'US')

  qualifiers_map = {
    "general_niche": base_keyword_qualifiers[country],
    "concept_in_plural_form": concept_plural_qualifiers[country],
    "concept_in_singular_form": concept_singular_qualifiers[country],
    "person_involved_in_niche_plural": person_involved_qualifiers[country],
    "action_phrase": action_phrase_qualifiers[country],
    "verb_in_continuous_form": continuous_verb_qualifiers[country]
  }

  qualifiers_conversion_map = {
    "general_niche": 'General Niche',
    "concept_in_plural_form": "Concept in plural form",
    "concept_in_singular_form": "Concept in singular form",
    "person_involved_in_niche_plural": "Person involved in Niche in plural form",
    "action_phrase": "Verb or Action phrase",
    "verb_in_continuous_form": "Verb in continuous form"
  }

  results = []

  for key, qualifiers in qualifiers_map.items():
    value = data.get(key, '')
    if value and len(value) > 0:
      for qualifier in qualifiers:
        query = replace_placeholder(qualifier, value)
        suggestions = get_google_suggestions(query, country)
        for suggestion in suggestions:
          # print(f'{qualifiers_conversion_map[key]}/{replace_placeholder(qualifier, "").strip()}')
          results.append({
            'suggestion': suggestion,
            'modifier': f'{qualifiers_conversion_map[key]}/{replace_placeholder(qualifier, "").strip()}',
            'search_query': query
          })

  return results

def alphabet_soup_method(partial_query, country):
  # Define the alphabet
  alphabet = string.ascii_lowercase
  
  # Initialize the result array
  
  results = []
  # Iterate over each alphabet letter
  for letter in alphabet:
    # Create a modified query by appending the letter to the partial query
    modified_query = f"{partial_query} {letter}"
    # Add the modified query to the result array
    suggestions = get_google_suggestions(modified_query, country)
    for suggestion in suggestions:
      # print(f'{qualifiers_conversion_map[key]}/{replace_placeholder(qualifier, "").strip()}')
      results.append({
        'suggestion': suggestion,
        'modifier': f'Alphabet soup/{letter}',
        'search_query': modified_query
      })
  
  return results


def query_generation_method(data):
  country = data.get('country', 'US')
  keyword = data.get('general_niche', None)

  if (not keyword):
    return None

  qualifiers_map = {
    'questions': questions_modifiers[country],
    'prepositions': prepositions_modifiers[country],
    'comparison': comparisons[country],
  }

  results = []

  for key, qualifiers in qualifiers_map.items():
    for qualifier in qualifiers:
      query = replace_placeholder(qualifier, keyword)
      suggestions = get_google_suggestions(query, country)
      for suggestion in suggestions:
        # print(f'{qualifiers_conversion_map[key]}/{replace_placeholder(qualifier, "").strip()}')
        results.append({
          'suggestion': suggestion,
          'modifier': f'{key.capitalize()}/{replace_placeholder(qualifier, "").strip()}',
          'search_query': query
        })
  

  alphabetical = alphabet_soup_method(keyword, country)
  print(alphabetical)
  results.extend(alphabetical)
  # results_map['alphabetical'] = alphabetical


  headers = {
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
      'referer':'https://www.google.com/'
  }
  url = f'https://www.google.com/search?q={keyword}&gl=us'
  try:
    response = requests.get(url, headers=headers)
  except Exception as e:
    print(str(e))
    return []

  soup = BeautifulSoup(response.text, 'html.parser')

  related_questions = extract_related_questions(soup, [])

  print("Related questions")
  print(related_questions)
  for related in related_questions:
    results.append({
      'suggestion': related.get('question', '-'),
      'modifier': f'Related',
      'search_query': keyword
    })

  ppa_questions = extract_ppa_questions(soup, [])

  print("PPA")
  print(related_questions)
  for related in ppa_questions:
    results.append({
      'suggestion': related.get('question', '-'),
      'modifier': f'People Also Ask',
      'search_query': keyword
    })

  print("Results")
  print(results)
  return results


def create_ideation_keywords_list(list_name, request, results):
  user = get_user_from_token(request)
  print("User")
  suggestions = [{
    'parent_keyword': suggestion.get('search_query', '-'),
    'search_query': suggestion.get('suggestion', None),
    'project': request.data.get("project", None),
    'user': user['id'],
    'metadata': {
      'modifier': suggestion.get('modifier', None)
    }
  } for suggestion in results]
  print("Suggestion")

  suggestionsSerializer = SuggestionSerializer(data=suggestions, many=True)
  try:
    suggestionsSerializer.is_valid(raise_exception=True)
  except Exception as e:
    print(e.detail)
  if suggestionsSerializer.is_valid():
      suggestionsSerializer.save()
  else:
      print("Suggestions are not valid")
      print(serializer.errors)
      return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
  print("Create suggestions")


  keywords_list = {
    'title': list_name,
    'user': user['id'],
    'suggestions': [sgs['_id'] for sgs in suggestionsSerializer.data],
  }

  serializer = KeywordsPostSerializer(data=keywords_list)
  try:
    serializer.is_valid(raise_exception=True)
  except Exception as e:
    print(e.detail)
  try:
    if serializer.is_valid(raise_exception=True):
        serializer.save()
        return JsonResponse({
          'keywords_count': len(suggestions),
          'list_id': serializer.data.get('_id', None)
        }, safe=False, status=status.HTTP_201_CREATED)
    print("Serializer")
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
  except Exception as e:
    return Response(e.detail, status=status.HTTP_400_BAD_REQUEST)