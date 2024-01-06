from celery import shared_task
from keywordresearch.helpers.search_results import analyze_google_search, get_keyword_questions, get_organic_search_results, get_search_query_html
from keywordresearch.models import Search, Suggestion
from keywordresearch.serializers import SearchGetSerializer, SearchSerializer
import json

@shared_task
def embed_keywords(suggestion_id):
    try:
      print("========== STARTED ==========")
      print("========== NEW ANALYSIS 2 ==========")
      suggestion = Suggestion.objects.get(_id=suggestion_id)
      # ... do analysis work here ...
      """ html_unescaped = get_search_query_html(suggestion.search_query)
      search_content = get_organic_search_results(html_unescaped, True) """
      questions = get_keyword_questions(suggestion.search_query)

      print("========== BEFORE ANALYSIS ==========")
      analyzed_search = analyze_google_search(suggestion.search_query)
      print("========== AFTER ANALYSIS ==========")

      serializer = SearchSerializer(data={
        "related_suggestion_id": suggestion_id,
        "serps": analyzed_search,
        "questions": json.dumps(questions)
      })

      print("========== AFTER SERIALIZER ==========")

      if (serializer.is_valid()):
        serializer.save()

      print("========== BEFORE ANALYSIS ==========")
      suggestion.status = "ANALYZED"
      suggestion.save()  
    except Exception as e: # work on python 3.x
      print('An error during search results analysis: '+ str(e))
      suggestion.status = "ERROR"
      suggestion.save()  



@shared_task
def analyze_search_results(suggestion_id):
    try:
      print("========== STARTED ==========")
      print("========== NEW ANALYSIS 2 ==========")
      suggestion = Suggestion.objects.get(_id=suggestion_id)
      # ... do analysis work here ...
      """ html_unescaped = get_search_query_html(suggestion.search_query)
      search_content = get_organic_search_results(html_unescaped, True) """
      questions = get_keyword_questions(suggestion.search_query)

      print("========== BEFORE ANALYSIS ==========")
      analyzed_search = analyze_google_search(suggestion.search_query)
      print("========== AFTER ANALYSIS ==========")

      serializer = SearchSerializer(data={
        "related_suggestion_id": suggestion_id,
        "serps": analyzed_search,
        "questions": json.dumps(questions)
      })

      print("========== AFTER SERIALIZER ==========")

      if (serializer.is_valid()):
        serializer.save()

      print("========== BEFORE ANALYSIS ==========")
      suggestion.status = "ANALYZED"
      suggestion.save()  
    except Exception as e: # work on python 3.x
      print('An error during search results analysis: '+ str(e))
      suggestion.status = "ERROR"
      suggestion.save()  

@shared_task
def reanalyze_questions(suggestion_id):
    try:
      print("========== STARTED REANALYZING ==========")
      suggestion = Suggestion.objects.get(_id=suggestion_id)
      # questions = get_keyword_questions(suggestion.search_query)

      search = Search.objects.get(related_suggestion_id=suggestion)

      print(search)

    except Exception as e: # work on python 3.x
      print('Error during reanalysis: '+ str(e))
      suggestion.status = "ERROR"
      suggestion.save()  

    # ... do analysis work here ...
