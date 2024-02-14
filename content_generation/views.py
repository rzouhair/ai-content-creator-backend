from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from content_generation.models import MEMORY_TYPES, Document, Memory, Output, Project, Prompt, Skill, Tag, Recipe
from content_generation.serializers import DocumentGetSerializer, DocumentSerializer, MemorySerializer, OutputSerializer, ProjectSerializer, PromptSerializer, SkillGetSerializer, SkillSerializer, TagSerializer, RecipeSerializer, RecipeGetSerializer
from core.clients import create_document, delete_document, nearest_neighbor_search, retrieve_document, retrieve_documents
from keywordresearch.tasks import memory_file_analysis, memory_text_analysis, memory_youtube_analysis
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from youtube_transcript_api import YouTubeTranscriptApi
from core.helpers import manual_pagination
from .utils import get_random_system_prompt, get_generation_prompt
from app_auth.helpers import get_user_from_token

import uuid
import json


from .helpers import prompts, parts

# Create your views here.
@api_view(['GET'])
def generateTitle(request):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": prompts.title_system_prompt },
    {"role": "user", "content": "Prompt: Create 5 SEO-friendly titles for \"Cost for a trip to Morocco.\" Titles must be engaging, less than 60 characters, and include target keywords and power words to elicit an emotional response. Use numbers to increase engagement.\nInstructions:\nTitle length should be between 50-59 characters.\nInclude target keywords at the beginning of the title.\nUse power words to increase reader engagement.\nInclude numbers to perform better.\nNote: Please provide a plain JSON array not an object, Please provide relevant and informative content that directly answers the prompt. Do not use affirmative language or provide irrelevant information that doesn't address the prompt."}
  ])

  return Response(chat_resp)
  

@api_view(['GET'])
def generateOutline(request):
  chat_resp = parts.generateOutline(request.query_params['title'])

  return Response(chat_resp)

@api_view(['GET'])
def generateMetaTitle(request):
  outputs = 1
  try:
    outputs = request.query_params['num_outputs']
  except:
    outputs = 1
  chat_resp = parts.generateTitlePart(request.query_params['topic'], outputs if outputs else 1)

  return Response(chat_resp)

@api_view(['GET'])
def generateMetaDescription(request):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": prompts.meta_description_prompt },
    {"role": "user", "content": f"Provide 5 optimized meta descriptions for the following blog post: '{request.query_params['title']}'"}
  ])

  return Response(chat_resp)

@api_view(['GET'])
def generateBlogFormatAndIntent(request):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": prompts.blog_format_prompt },
    {"role": "user", "content": f"For the following blog post title, {request.query_params['title']}, Generate a JSON object that has two properties: 'format' and 'intent'. The values for the 'format' property should be exclusively from the following list: [Listicle - How-to Guide - Interview - Opinion Piece - Infographics - Video Posts - Case Study and more]. The values for the 'intent' property should be exclusively from the following list: [Informational - Navigational - Commercial - Transactional]. Please ensure that the output contains only the JSON object with the required properties."}
  ])

  return Response(chat_resp)


@api_view(['GET', 'POST'])
def writeBlogPost(request):
    # parts: title - sections - section
    # target keyword
    # toneOfVoice
    if request.data['part'] == 'tee_up':
      chat_resp = parts.generateTeeUp(request.data['title'], target_keyword=request.data['targetKeyword'], num_outputs=request.data.get('num_outputs', 1))
      return Response({
        'paragraphs': chat_resp['content']
      })
    elif request.data['part'] == 'title':
      chat_resp = parts.generateTitlePart(request.data['targetKeyword'], request.data.get('num_titles', 1))
      return Response({
        'title': chat_resp['content']
      })
    elif request.data['part'] == 'sections':
      chat_resp = parts.generateOutline(request.data['targetKeyword'])
      try: 
        return Response({
          'sections': json.loads(chat_resp)
        })
      except:
        return Response({
          'sections': chat_resp
        })
    elif request.data['part'] == 'section':
      chat_resp = parts.generateSection(request.data)

      return Response(chat_resp)
    return Response({
      'data': request.data
    })

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def tagActions(request, _id=None):
    if request.method == 'GET':
        if _id is not None:
            tag = get_object_or_404(Tag, _id=_id)
            serializer = TagSerializer(tag)
            return Response(serializer.data)
        else:
            tag = Tag.objects.all()
            serializer = TagSerializer(tag, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
        serializer = TagSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        tag = Tag.objects.get(_id=_id)
    except Tag.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = TagSerializer(tag, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        tag.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def promptActions(request, _id=None):
    if request.method == 'GET':
        if _id is not None:
            prompt = get_object_or_404(Prompt, _id=_id)
            serializer = PromptSerializer(prompt)
            return Response(serializer.data)
        else:
            prompts = Prompt.objects.all()
            serializer = PromptSerializer(prompts, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
        serializer = PromptSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        prompt = Prompt.objects.get(_id=_id)
    except Prompt.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = PromptSerializer(prompt, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        prompt.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def skillsActions(request, _id=None): 
    if request.method == 'GET':
        class RestrictedSkillGetSerializer(SkillGetSerializer):
          class Meta(SkillGetSerializer.Meta):
              fields = ['_id', 'name', 'description', 'hidden', 'icon', 'emoji', 'beta', 'input_schema', 'tags', 'created_at', 'updated_at']
        if _id is not None:
            skill = get_object_or_404(Skill, _id=_id)
            if request.user.is_authenticated and request.user.groups.filter(name='Admin').exists():
              serializer = SkillGetSerializer(skill)
            else:
              serializer = RestrictedSkillGetSerializer(skill)
            return Response(serializer.data)
        else:
            skills = Skill.objects.all()
            data = manual_pagination(skills, SkillGetSerializer if request.user.is_authenticated and request.user.groups.filter(name='Admin').exists() else RestrictedSkillGetSerializer, request)
            return JsonResponse(data)

    elif request.method == 'POST':
      if isinstance(request.data, dict):
          # If the request data is a single skill object, serialize and save it
          serializer = SkillSerializer(data=request.data)
          if serializer.is_valid():
              serializer.save()
              return Response(serializer.data, status=status.HTTP_201_CREATED)
      elif isinstance(request.data, list):
          # If the request data is a list of skills, serialize and save each skill
          serialized_skills = []
          for skill_data in request.data:
              serializer = SkillSerializer(data=skill_data)
              if serializer.is_valid():
                  serializer.save()
                  serialized_skills.append(serializer.data)
              else:
                  # If any skill data is invalid, return a 400 Bad Request response
                  return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

          # Return a response with the serialized skills and a 201 Created status
          return Response(serialized_skills, status=status.HTTP_201_CREATED)
      # If the request data is neither a list nor a single skill object, return a 400 Bad Request
      return Response({'error': f'Invalid data format - {type(request.data)} - {isinstance(request.data, dict)}'}, status=status.HTTP_400_BAD_REQUEST)

    try:
        skill = Skill.objects.get(_id=_id)
    except Skill.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = SkillSerializer(skill, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Skill.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      skill.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
def skillOutputs(request, _id):
  if not _id:
    return Response('Not id provided', status=status.HTTP_400_BAD_REQUEST)
  
  order_by = request.GET.get('order_by', '-created_at')
  outputs = Output.objects.filter(skill=_id).order_by(order_by)
  serializer = OutputSerializer(outputs, many=True)

  return Response(serializer.data)


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def documentActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            document = get_object_or_404(Document, _id=_id)
            serializer = DocumentGetSerializer(document)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            project = request.query_params.get('project', None)
            if project:
              document = Document.objects.filter(user=user['id'], project=project).order_by(order_by)
            else:
              document = Document.objects.filter(user=user['id']).order_by(order_by)

            serializer = DocumentGetSerializer(document, many=True)
            return Response(serializer.data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        serializer = DocumentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        document = Document.objects.get(_id=_id)
        print(document)
    except Document.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = DocumentSerializer(document, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Document.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      document.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def projectActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            project = get_object_or_404(Project, _id=_id)
            serializer = ProjectSerializer(project)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            project = Project.objects.filter(user=user['id']).order_by(order_by)
            serializer = ProjectSerializer(project, many=True)
            return Response(serializer.data)
    
    user = get_user_from_token(request)
    request.data['user'] = user['id']
    if request.method == 'POST':
        print(request.data)
        serializer = ProjectSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
      project = Project.objects.get(_id=_id)
    except Project.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = ProjectSerializer(project, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Output.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      project.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def outputActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            output = get_object_or_404(Output, _id=_id)
            serializer = OutputSerializer(output)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            output = Output.objects.filter(user=user['id']).order_by(order_by)
            serializer = OutputSerializer(output, many=True)
            return Response(serializer.data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        serializer = OutputSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        output = Output.objects.get(_id=_id)
    except Output.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = OutputSerializer(output, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Output.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      output.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def memoryActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            memory = get_object_or_404(Memory, _id=_id)
            serializer = MemorySerializer(memory)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            memory = Memory.objects.filter(user=user['id']).order_by(order_by)
            serializer = MemorySerializer(memory, many=True)
            return Response(serializer.data)
    
    mutable_data = request.data.copy()
    mutable_data['user'] = user['id']

    if request.method == 'POST':
        serializer = MemorySerializer(data=mutable_data)
        if serializer.is_valid():
            type = mutable_data.get('type', None)
            if not type:
              return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

            _id = uuid.uuid4()

            serializer.validated_data['_id'] = _id
            serializer.save()

            if type == 'FILE':
              file = request.FILES.get('file', None)
              file_content = file.read()
              job_id = memory_file_analysis.delay((_id, file_content, file.name))
              
            if type == 'YTB':
              url = mutable_data.get('url')
              job_id = memory_youtube_analysis.delay((_id, url))

            if type == 'TEXT':
              text = mutable_data.get('text')
              job_id = memory_text_analysis.delay((_id, text))

            print(job_id)

            return Response(serializer.data, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
      memory = Memory.objects.get(_id=_id)
    except Memory.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = MemorySerializer(memory, data=mutable_data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      if _id == None:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
      else:
        memory.delete()
        delete_document('memories', { 'filter_by': f'parent_id:={_id}' })
        return Response(status=status.HTTP_204_NO_CONTENT)



@api_view(['GET', 'POST', 'PUT'])
def skillPrompt(request, _id=None):
  if (not _id):
    return Response(status=status.HTTP_400_BAD_REQUEST)
  
  if request.method == 'GET':
    prompt = get_object_or_404(Prompt, skill=_id)
    serializer = PromptSerializer(prompt)
    return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
  
  if request.method == 'POST':
    try:
      skill = get_object_or_404(Skill, _id=_id)

      skill_purpose = prompts.chat_scaffold([
        { "role": "user", "content": f"""
  Knowing that a skill is what an AI can generate, Determine what's demanded from the following skill preset:
  Skill label: {skill.name}
  Skill description: {skill.description}.
  The list of variable names to include in curly braces acting as placeholders to be replaced afterward: {" - ".join([f"{ {schema['id']} }" for schema in skill.input_schema])}
  """ }
      ])

      skill_prompt = prompts.chat_scaffold([
        { "role": "user", "content": f"""
  Knowing that a skill is what an AI can generate, Determine what's demanded from the following skill preset:
  Skill label: {skill.name}
  Skill description: {skill.description}.
  The list of variable names to include in curly braces acting as placeholders to be replaced afterward: {" - ".join([f"{ {schema['id']} }" for schema in skill.input_schema])}
  """ },
        { "role": "assistant", "content": skill_purpose["content"] },
        { "role": "user", "content": f"""
  Generate a GPT-4 Prompt that takes these abstract variables and generate what's intended from the skill
  You should:
    - Describe the task in plain English
    - Explicit what the is its input and output
        - e.g. "The input is a description of a book, and the output is a title for the book"
    - Be creative in what you ask GPT-4 to do, create intricate mechanisms to constrain the AI from generating bad responses
    
    Remember, GPT-4 knows it's an AI, so you don't need to tell it this

  These variables should be enclosed in curly braces {{}} and should be integrated into the text in such a way that it appears as if they are actual values. The variables can be anything and should fit naturally into the context of the sentence.

  Here are the steps I want you to follow to generate the best prompt:
  **Task Description:**
  - It's where you describe the task the AI need to do including the variables above, and including the best steps, tips and tricks to achieve the best result, here is an example that you need to be inspired of and not take religiously:
    " Create a set of {{numberofQuestions}} frequently asked questions (FAQs) related to the topic of {{topic}}. Ensure the questions are written in a {{tone}} tone and aim for clarity and relevance. The generated output should provide a cohesive list of {{numberofQuestions}} FAQs that could conclude a blog post on the specified {{topic}}. "

  **Input:**
  - It's where you describe the variables and explain them so the AI knows the context and knows how to implement them, here is an example that you need to be inspired of and not take religiously:
    " - topic: The subject matter around which the FAQs should revolve.
    - tone: The desired style or manner in which the questions should be framed (e.g., formal, casual, technical).
    - numberofQuestions: The total number of FAQs required for the output. "

  **Output:**
  - Here you describe how the output should be crafted, based on the information above, you here include all sort of secrets, tips, tricks and steps to achieve the best of outputs, here is an example that you need to be inspired of and not take religiously:
    "A set of {{numberofQuestions}} well-structured FAQs along with their answers, tailored to the {{topic}} and written in the specified {{tone}} tone."
  - Return ONLY the OUTPUT, do not return the input or any fluff

  **Constraints and Guidelines:**
  - Here is where you use you knowledge to get the best of guidelines to achieve the goal in the task description, Ensure that the guidelines are reliable and able to help the AI generate the optimal output and achieve what the user might expect, here is an example that you need to be inspired of and not take religiously:
    "1. Ensure the generated questions are relevant and coherent with the given {{topic}}.
    2. Maintain a consistent {{tone}} throughout the FAQs.
    3. Avoid generating duplicate or repetitive questions.
    4. Aim for diversity in the types and angles of the {{numberofQuestions}} FAQs.
    5. The questions should be phrased in a manner suitable for a blog post conclusion."
  -----

  {'**Here Are other example outputs to consider**' if len(skill.examples) else ''}
  {skill.examples}

  """ }
      ])
      
      return Response(skill_prompt, status=status.HTTP_201_CREATED)
    except Exception:
      return Response(Exception, status=status.HTTP_404_NOT_FOUND)
  if request.method == 'PUT':
    try:
      try:
        prompt = get_object_or_404(Prompt, skill=_id)
        serializer = PromptSerializer(prompt, data={
          'prompt': request.data.get('prompt', "-"),
          'skill': _id
        })
        if serializer.is_valid():
            serializer.save()
      except:
        serializer = PromptSerializer(data={
          'prompt': request.data.get('prompt', "-"),
          'skill': _id
        })
        if serializer.is_valid():
            serializer.save()
      
      return JsonResponse(serializer.data, status=status.HTTP_201_CREATED)
    except Exception:
      return Response(Exception, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def execute(request):
  if request.data['skill_id'] == None or request.data['inputs'] == None:
    return Response(status=status.HTTP_400_BAD_REQUEST)

  print("Skill found")
  try:
    prompt = get_object_or_404(Prompt, skill=request.data['skill_id'])
    print("Prompt found")
  except:
    return Response(status=status.HTTP_400_BAD_REQUEST)

  prompt_text = prompt.prompt

  for _id, value in request.data['inputs'].items():
    prompt_text = prompt_text.replace("{" + _id + "}", str(value))

  results = []

  bg_data = ""
  memory_id = request.data.get('memory', None)

  if memory_id:
    filters = {
        'q': '*',
        'query_by': '*',
        'filter_by': f"parent_id:={str(memory_id)}",
        "per_page": 15,
        "page": 1
    }
    # nearest_neighbor_search('memories', )
    bg_data = retrieve_documents('memories', filters)
    bg_data = '\n'.join([t['text'] for t in bg_data])

  for i in range(request.data["inputs"]['num_outputs']):
    chat_resp = prompts.chat_scaffold([
      {"role": "system", "content": f"Here is some background data: \n {bg_data}"},
      {"role": "user", "content": prompt_text}
    ])
    print(f"Here is some background data: \n {bg_data}")
    user = get_user_from_token(request)
    data = {
      "text": chat_resp["content"],
      "user": user['id'],
      "usage": chat_resp["usage"],
      "completionId": "",
      "outputWordCount": len(chat_resp['content'].split()),
      "skill": request.data["skill_id"],
      "payload": request.data
    }
    output_serializer = OutputSerializer(data=data)
    if output_serializer.is_valid():
      output_serializer.save()
      results.append(output_serializer.data)

  return Response(results, status=status.HTTP_201_CREATED)

@api_view(['POST'])
def getCompletion(request):
  if request.data['command'] == None:
    return Response(status=status.HTTP_400_BAD_REQUEST)
  
  command = request.data['command']
  context = request.data.get('context', None)
  chat_resp = prompts.chat_scaffold([
    { "role": "system", "content": f"Here is some context for the command below, the context is an article, and everytime the user mentions 'above' it means this context article:\n{context}.\nIn case there is no command complete the sentence / article." if context else "Based on the command below provide provide a well formated text" },
    {"role": "user", "content": command}
  ])

  return Response(chat_resp)

@api_view(['POST'])
def extractFromVideo(request):
  if request.data['id'] == None:
    return Response(status=status.HTTP_400_BAD_REQUEST)
  
  video_id = request.data['id']
  transcript = YouTubeTranscriptApi.get_transcript(video_id)

  raw_text = request.data.get('raw_text', True)
  if raw_text:
    concatenated_text = ""
    for obj in transcript:
        concatenated_text += obj["text"] + " "
    return Response(concatenated_text.strip())

  else:
    return Response(transcript)

@api_view(['POST'])
def extractSummaryFromTranscript(request):
  if request.data['transcript'] == None:
    return Response(status=status.HTTP_400_BAD_REQUEST)
  
  transcript = request.data['transcript']

  chat_resp = prompts.chat_scaffold([
    {"role": "user", "content": prompts.extract_transcript_info + f"\n \"{transcript}\""}
  ])
  return Response(chat_resp)

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def recipesActions(request, _id=None): 
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            recipe = get_object_or_404(Recipe, _id=_id)
            serializer = RecipeSerializer(recipe)
            return Response(serializer.data)
        else:
            suggestions = Recipe.objects.filter(user=user['id'])
            serializer = RecipeGetSerializer(suggestions, many=True)
            return Response(serializer.data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        serializer = RecipeSerializer(data=request.data)
        if serializer.is_valid():
          serializer.save()
          return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        recipe = Recipe.objects.get(_id=_id)
    except Recipe.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = RecipeSerializer(recipe, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Skill.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      recipe.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)