import uuid
from celery import shared_task
from django.shortcuts import get_object_or_404
from content_generation.helpers.aws import upload_to_s3
from content_generation.helpers.prompts import embedding_scaffold
from content_generation.helpers.text import extract_video_id, split_s3_file, split_text
from content_generation.models import Memory
from content_generation.serializers import MemorySerializer
from core.clients import create_document
from keywordresearch.helpers.search_results import analyze_google_search, get_keyword_questions, get_organic_search_results, get_search_query_html
from keywordresearch.models import Search, Suggestion
from keywordresearch.serializers import SearchGetSerializer, SearchSerializer
import json
from youtube_transcript_api import YouTubeTranscriptApi

from uuid import UUID
class UUIDEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, UUID):
            # if the obj is uuid, we simply return the value of uuid
            return str(obj)
        return json.JSONEncoder.default(self, obj)

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
def analyze_search_results(args):
    suggestion_id, user_id = args
    print(f"Suggestion: {suggestion_id} - User ID: {user_id}")
    try:
      print("========== STARTED ==========")
      print("========== NEW ANALYSIS 2 ==========")
      suggestion = Suggestion.objects.get(_id=suggestion_id)
      # ... do analysis work here ...
      """ html_unescaped = get_search_query_html(suggestion.search_query)
      search_content = get_organic_search_results(html_unescaped, True) """
      questions = get_keyword_questions(suggestion.search_query)

      print("Questions")
      print(questions)

      print("========== BEFORE ANALYSIS ==========")
      analyzed_search = analyze_google_search(suggestion.search_query)
      print("========== AFTER ANALYSIS ==========")

      serializer = SearchSerializer(data={
        "related_suggestion_id": suggestion_id,
        "serps": analyzed_search,
        "questions": json.dumps(questions),
        "user": user_id
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

@shared_task
def memory_file_analysis(args):
  try:
    print(args)
    memory_id, file, file_name = args
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data

    if serializer.data:
      if not file:
        changing_data['status'] = 'ERROR'
      else:
        changing_data['status'] = 'PROCESSING'

        serializer = MemorySerializer(memory, data=changing_data)
        if serializer.is_valid():
          serializer.save()
        # Upload file
        uploaded_file = upload_to_s3(file, 'seotoolfiles', memory_id, file_name=file_name)
        fil = split_s3_file('seotoolfiles', uploaded_file['path'])
        split = split_text(fil[0].page_content, 2500, 40)
        changing_data['metadata'] = {
          'file': uploaded_file
        }
        for t in split:
          print(f"Processing item for Memory {memory_id}")
          embedding = embedding_scaffold(t)
          create_document('memories', json.dumps({
              'id': uuid.uuid4(),
              'parent_id': memory_id,
              'text': t,
              'embedding': embedding,
              'metadata': {
                'file': uploaded_file,
              }
          }, cls=UUIDEncoder))
        changing_data['status'] = 'PROCESSED'

      serializer = MemorySerializer(memory, data=changing_data)
      if serializer.is_valid():
        serializer.save()
  except Exception as e:
    print(e)
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data
    changing_data['status'] = 'ERROR'

    serializer = MemorySerializer(memory, data=changing_data)
    if serializer.is_valid():
      serializer.save()

@shared_task
def memory_text_analysis(args):
  try:
    print(args)
    memory_id, text = args
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data
    if serializer.data:
      if not text:
        changing_data['status'] = 'ERROR'
      else:
        changing_data['status'] = 'PROCESSING'

        serializer = MemorySerializer(memory, data=changing_data)
        if serializer.is_valid():
          serializer.save()

        split = split_text(text, 2500, 40)
        for t in split:
          print(f"Processing item for Memory {memory_id}")
          embedding = embedding_scaffold(t)
          create_document('memories', json.dumps({
              'id': uuid.uuid4(),
              'parent_id': memory_id,
              'text': t,
              'embedding': embedding,
              'metadata': {
              }
          }, cls=UUIDEncoder))
        changing_data['status'] = 'PROCESSED'

    serializer = MemorySerializer(memory, data=changing_data)
    if serializer.is_valid():
      serializer.save()
  except Exception as e:
    print(e)
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data
    changing_data['status'] = 'ERROR'

    serializer = MemorySerializer(memory, data=changing_data)
    if serializer.is_valid():
      serializer.save()


@shared_task
def memory_youtube_analysis(args):
  try:
    print("---------")
    print(args)
    print("---------")
    memory_id, url = args
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data

    if serializer.data:
      if not url:
        changing_data['status'] = 'ERROR'
      else:
        changing_data['status'] = 'PROCESSING'
        serializer = MemorySerializer(memory, data=changing_data)

        if serializer.is_valid():
          serializer.save()

        video_id = extract_video_id(url)
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        transcript_texts = ' '.join([t['text'] for t in transcript])
        split = split_text(transcript_texts, 2500, 40)
        changing_data['metadata'] = {
          'url': url
        }
        for t in split:
          print(f"Processing item for Memory {memory_id}")
          embedding = embedding_scaffold(t)
          create_document('memories', json.dumps({
            'id': uuid.uuid4(),
            'parent_id': memory_id,
            'text': t,
            'embedding': embedding,
            'metadata': {
              'url': url
            }
          }, cls=UUIDEncoder))

        changing_data['status'] = 'PROCESSED'

    serializer = MemorySerializer(memory, data=changing_data)
    if serializer.is_valid():
      serializer.save()
  except Exception as e:
    print(e)
    memory = get_object_or_404(Memory, _id=memory_id)
    serializer = MemorySerializer(memory)
    changing_data = serializer.data
    changing_data['status'] = 'ERROR'

    serializer = MemorySerializer(memory, data=changing_data)
    if serializer.is_valid():
      serializer.save()
