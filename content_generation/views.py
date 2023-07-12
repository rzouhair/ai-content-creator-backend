from django.shortcuts import get_object_or_404, render
from content_generation.models import Document, Output, Project, Prompt, Skill, Tag
from content_generation.serializers import DocumentGetSerializer, DocumentSerializer, OutputSerializer, ProjectSerializer, PromptSerializer, SkillGetSerializer, SkillSerializer, TagSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status

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
        if _id is not None:
            skill = get_object_or_404(Skill, _id=_id)
            serializer = SkillGetSerializer(skill)
            return Response(serializer.data)
        else:
            suggestions = Skill.objects.all()
            serializer = SkillGetSerializer(suggestions, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
        print(str(request.data))
        serializer = SkillSerializer(data=request.data)
        if serializer.is_valid():
          serializer.save()
          return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

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
    if request.method == 'GET':
        if _id is not None:
            document = get_object_or_404(Document, _id=_id)
            serializer = DocumentGetSerializer(document)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            project = request.query_params.get('project', None)
            if project:
              document = Document.objects.filter(project=project).order_by(order_by)
            else:
              document = Document.objects.all().order_by(order_by)

            serializer = DocumentGetSerializer(document, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
        serializer = DocumentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        document = Document.objects.get(_id=_id)
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
    if request.method == 'GET':
        if _id is not None:
            project = get_object_or_404(Project, _id=_id)
            serializer = ProjectSerializer(project)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            project = Project.objects.all().order_by(order_by)
            serializer = ProjectSerializer(project, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
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
    if request.method == 'GET':
        if _id is not None:
            output = get_object_or_404(Output, _id=_id)
            serializer = OutputSerializer(output)
            return Response(serializer.data)
        else:
            order_by = request.GET.get('order_by', '-created_at')
            output = Output.objects.all().order_by(order_by)
            serializer = OutputSerializer(output, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
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

@api_view(['POST'])
def execute(request):
  if request.data['skill_id'] == None or request.data['inputs'] == None:
    return Response(status=status.HTTP_400_BAD_REQUEST)

  try:
    prompt = get_object_or_404(Prompt, skill=request.data['skill_id'])
  except:
    print("==========")
    print(request.data['skill_id'])
    print("==========")
    return Response(status=status.HTTP_400_BAD_REQUEST)
  prompt_text = prompt.prompt

  for _id, value in request.data['inputs'].items():
    prompt_text = prompt_text.replace("{" + _id + "}", str(value))

  results = []

  for i in range(request.data["inputs"]['num_outputs']):
    chat_resp = prompts.chat_scaffold([
      {"role": "user", "content": prompt_text}
    ])
    data = {
      "text": chat_resp["content"],
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
