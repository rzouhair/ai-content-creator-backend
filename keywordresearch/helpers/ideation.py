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

base_keyword_qualifiers = [
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
]

concept_plural_qualifiers = [
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
]

concept_singular_qualifiers = [
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
]

person_involved_qualifiers = [
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
]

action_phrase_qualifiers = [
  'How to %',
  'How do you %',
  'When to %',
  'Best way to %',
  'Should you %',
  'What if you %',
  'step by step instructions %',
]

continuous_verb_qualifiers = [
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
]

questions_modifiers = [
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
]

prepositions_modifiers = [
    "can %",
    "for %",
    "is %",
    "% near",
    "% to",
    "% with",
    "% without"
]

comparisons = [
    "% and",
    "% like",
    "% or",
    "% versus",
    "% vs"
]



def autocomplete_suggestions(data):
  country = data.get('country', 'US')

  qualifiers_map = {
    "general_niche": base_keyword_qualifiers,
    "concept_in_plural_form": concept_plural_qualifiers,
    "concept_in_singular_form": concept_singular_qualifiers,
    "person_involved_in_niche_plural": person_involved_qualifiers,
    "action_phrase": action_phrase_qualifiers,
    "verb_in_continuous_form": continuous_verb_qualifiers
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
    'questions': questions_modifiers,
    'prepositions': prepositions_modifiers,
    'comparison': comparisons,
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