import copy
import re
import json
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
import requests
from app_auth.helpers import get_user_from_token
from keywordresearch.helpers.get_article_data import get_article_content, get_post_info
from keywordresearch.helpers.ideation import alphabet_soup_method, autocomplete_suggestions, create_ideation_keywords_list, query_generation_method
from keywordresearch.tasks import analyze_search_results
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from duckduckgo_search import DDGS
from app_auth.permissions import verify_auth
from app_auth.models import User
from core.helpers import manual_pagination, suggested_num_clusters
from core.clients import create_document, delete_document, typesense_client, retrieve_documents, update_document

from core.helpers import cluster_keywords
from uuid import UUID
class UUIDEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, UUID):
            # if the obj is uuid, we simply return the value of uuid
            return str(obj)
        return json.JSONEncoder.default(self, obj)

import nltk
from nltk.corpus import stopwords
from rake_nltk import Rake, Metric

from bs4 import BeautifulSoup

from .helpers import prompts

from core.helpers import get_html_content, unescape_html, get_response_content
from .helpers.get_article_info import get_article_info
from .helpers.search_results import get_bing_suggestions, get_google_suggestions, get_search_query_html, get_organic_search_results, get_keyword_questions, merge_questions

from .models import Search, Suggestion, Keywords
from .serializers import KeywordsPostSerializer, SearchGetSerializer, SearchSerializer, SuggestionSerializer, KeywordsSerializer, KeywordsSerializerWithEmbedding

@api_view(['GET', 'POST'])
def analyzeKeyword(request):
    keyword = request.data.get('query', None)

    if not keyword:
        return Response('No query prvided')

    questions = get_keyword_questions(keyword)
    return Response(questions)

@api_view(['GET', 'POST'])
def getSerpResults(request):
    if not request.data or not request.data['query']:
        return Response({
            'data': 'No query provided'
        })

    query = request.data['query']

    html_unescaped = get_search_query_html(query)
    search_content = {}
    if not request.data.get('with_data', None):
        search_content = get_organic_search_results(html_unescaped)
    else:
        search_content = get_organic_search_results(html_unescaped, True)

    return Response({
        'data': search_content,
    })
    

@api_view(['GET', 'POST'])
def getSuggestions(request):
    # base_url = "https://suggestqueries.google.com/complete/search?client=firefox&q="
    query = request.data.get('query', None)
    country = request.data.get('country', 'us')

    country_lang = {
        'us': {
            "country": 'us',
            "lang": 'en-us'
        },
        'fr': {
            "country": 'fr',
            "lang": 'fr'
        },
        'es': {
            "country": 'es',
            "lang": 'es'
        },
        'ma': {
            "country": 'ma',
            "lang": 'fr'
        },
    }

    with_styling = request.data.get('with_styling', False)
    if not query:
        return Response('No query provided')

    google_suggestions = get_google_suggestions(query, country=country_lang[country].get('country'), with_styling=with_styling)
    bing_options = get_bing_suggestions(query, country)

    ddg_options = []
    with DDGS() as ddgs:
        for r in ddgs.suggestions(query):
            ddg_options.append(r["phrase"])

    return Response({
        "bing": map(lambda q: q["query"], bing_options),
        "google": google_suggestions,
        "ddg": ddg_options
    })


@api_view(['GET', 'POST'])
def getTopResultsKeywords(request):
    nltk.download('stopwords')
    nltk.download('punkt')
    top = request.data.get('top', 10)
    # desktop user-agent
    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    headers = {"user-agent": USER_AGENT} 
    query = request.data.get('query', None)

    if not query:
        return Response('Not iterable')

    search_query = f'https://www.google.com/search?q={query}&gl=us'
    html_escaped = get_html_content(search_query, headers=headers)

    html_unescaped = unescape_html(html_escaped)

    allArticles = ''
    allKeywords = []

    soup = BeautifulSoup(html_unescaped, 'html.parser')

    print('=====')
    body = soup.select('div[data-header-feature] h3')
    a = soup.select('div[data-header-feature] a')
    # soup.select('a')[0].get_attribute_list('href')

    stop_words = set(stopwords.words('english'))
    r = Rake(
        stopwords=stop_words,
        ranking_metric=Metric.WORD_FREQUENCY,
        min_length=2,
        max_length=3,
        include_repeated_phrases=False
    )


    if not body:
        print('No body found')
        return Response({
            'body': body
        })
    else:
        for i, heading in enumerate(body[:top]):
            link = a[i].get_attribute_list('href')[0]
            page_html = get_html_content(link, headers=headers)
            page_soup = BeautifulSoup(page_html, 'html.parser')
            body = page_soup.select_one('body')
            article = body.select_one('article') or body.select_one('div.article') or body.select_one('#article') or body.select_one('#article-body') or body.select('body')

            articleInfo = get_article_info(article, body = body, getAll=True)

            if articleInfo.get('all', None):
                allArticles += f'\n{articleInfo["all"]}'


        if allArticles:
            r.extract_keywords_from_text(allArticles)

            for rating, keyword in r.get_ranked_phrases_with_scores():
                if (rating > 5):
                    allKeywords.append((rating, keyword))

    keywords = map(lambda pa: pa[1], sorted(list(set(allKeywords)), key=lambda x: x[0], reverse=True))
    ks =map(lambda pa: pa[1], list(set(allKeywords)))
    clustered_keywords = cluster_keywords(keywords=ks, num_clusters=20) if allKeywords else []
    return Response({
        'clusters': clustered_keywords,
        'keywords': keywords,
    } if allKeywords else str(allArticles))

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def suggestionsActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            suggestion = get_object_or_404(Suggestion, _id=_id)
            serializer = SuggestionSerializer(suggestion)
            return Response(serializer.data)
        else:
            suggestions = Suggestion.objects.filter(user=user['id'])
            data = manual_pagination(suggestions, SuggestionSerializer, request)
            return JsonResponse(data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        serializer = SuggestionSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        print(_id)
        suggestion = Suggestion.objects.get(_id=_id)
    except Suggestion.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = SuggestionSerializer(suggestion, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        suggestion.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
def getSuggestionSearch(request, _id):
    suggestion = get_object_or_404(Suggestion, _id=_id)
    search = Search.objects.get(related_suggestion_id=suggestion)
    serializer = SearchGetSerializer(search)

    json_fields = {
        'questions': json.loads(serializer.data["questions"]),
    }

    dumped_json = json.dumps(json_fields)

    return Response({
        **serializer.data,
        **json.loads(dumped_json)
    })

@api_view(['GET'])
def reanalyzeQuestions(request, _id):
    suggestion = get_object_or_404(Suggestion, _id=_id)
    search = Search.objects.get(related_suggestion_id=suggestion)
    serializer = SearchGetSerializer(search)

    pure_questions = list(map(lambda x: x['question'], json.loads(serializer.data['questions'])))

    old_questions = copy.deepcopy(json.loads(serializer.data['questions']))
    
    for q in pure_questions:
        current_question = get_keyword_questions(q)
        old_questions = merge_questions(old_questions, current_question)
    

    return Response({
        "questions": old_questions,
        "others": pure_questions,
    })

@api_view(['POST'])
def analyze_suggestion(request, suggestion_id):
    user = get_user_from_token(request)
    suggestion = Suggestion.objects.get(_id=suggestion_id)
    if suggestion.status == "IN_PROGRESS" or suggestion.status == 'ANALYZED':
        return Response("Suggestion analysis already started/finished", status=status.HTTP_400_BAD_REQUEST)
    suggestion.status = "IN_PROGRESS"
    suggestion.save()

    if not user.get('id', None):
        return Response(status=status.HTTP_401_UNAUTHORIZED)
    
    analyze_search_results.delay((suggestion._id, user.get('id', None)))

    serializer = SuggestionSerializer(suggestion)
    return Response(serializer.data)

@api_view(['POST'])
def keywordClustering(request, _id=None):

    user = get_user_from_token(request)

    kw_list_id = _id
    if (not kw_list_id):
        return Response('No keywords list provided', status=status.HTTP_400_BAD_REQUEST)
    keywords_list = Keywords.objects.get(_id=kw_list_id)

    kw_embedding = []
    suggestions_query_set = keywords_list.suggestions.all()
    serialized = SuggestionSerializer(suggestions_query_set, many=True)

    newly_embedded = 0
    for keyword in serialized.data:
        filters = {
            'q': '*',
            'query_by': '*',
            'filter_by': f"id:={str(keyword['_id'])}"
        }
        try:
            is_keyword_embedded = retrieve_documents('keywords', filters)
        except Exception as e:
            is_keyword_embedded = None

        if (not is_keyword_embedded):
            newly_embedded += 1
            embedding = prompts.embedding_scaffold(keyword['search_query'])
            print(f"clustered: {keyword['search_query']}")
            create_document('keywords', json.dumps({
                'id': keyword['_id'],
                'parent_id': keyword['_id'],
                'text': keyword['search_query'],
                'embedding': embedding,
                'metadata': {
                    'list_id': _id,
                }
            }, cls=UUIDEncoder))
        else:
            embedding = is_keyword_embedded['embedding']

        kw_embedding.append({
            'keyword': keyword['search_query'],
            'embedding': embedding
        })

    print(f'number_of_newly_embedded_kw: {newly_embedded}')
    num_clusters = request.data.get('cluster_count', None)

    eps, min_samples = suggested_num_clusters(embeddings=[d['embedding'] for d in kw_embedding])

    print(f"{eps}, {min_samples}")

    if not num_clusters:
        num_clusters = min_samples

    print(f'suggested_clusters_count: {min_samples} - selected clusters count: {num_clusters}')

    clusters = cluster_keywords(dataset=kw_embedding, num_clusters=num_clusters)

    serializer = KeywordsPostSerializer(keywords_list, data={
        'saved_cluster':clusters,
        'user': user['id']
    })
    if serializer.is_valid():
        serializer.save()
    else:
        print(serializer.errors)

    return JsonResponse(clusters, safe=False)


@api_view(['POST'])
def getRelatedQuestions(request):
    search_query = request.data.get('search_query', None)

    # test
    if search_query == None:
        return Response('No search query provided', status=status.HTTP_400_BAD_REQUEST)
    
    questions = get_keyword_questions(keyword=search_query)

    return Response(questions)


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def searchActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            suggestion = get_object_or_404(Suggestion, _id=_id)
            serializer = SearchGetSerializer(suggestion)
            return Response(serializer.data)
        else:
            suggestions = Suggestion.objects.filter(user=user['id'])
            serializer = SearchGetSerializer(suggestions, many=True)
            return Response(serializer.data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        serializer = SuggestionSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        suggestion = Suggestion.objects.get(_id=_id)
    except Suggestion.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = SuggestionSerializer(suggestion, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        suggestion.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

@api_view(['GET'])
def google_search(request):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    }
    url = f'https://www.google.com/search?q={request.query_params.get("query")}&gl=us'
    response = requests.get(url, headers=headers)

    soup = BeautifulSoup(response.text, 'html.parser')

    # Use BeautifulSoup to parse the HTML content of the search results page
    soup = BeautifulSoup(response.content, 'html.parser')

    # Find all the search result elements using the tags and CSS classes that contain the relevant data
    result_elements = soup.select('div.g[lang]')

    # Loop through each search result element and extract the relevant data
    results = []
    for i, tag in enumerate(result_elements):

        title = tag.select_one('a h3')
        anchor = tag.select_one('a')
        link = anchor.get_attribute_list('href')[0] if anchor else None

        header_part = tag.select_one('div[data-snf]')
        middle_part = tag.select_one('div[data-sncf="1"]')
        footer_part = tag.select_one('div[data-sncf="2"]')

        snippet_heading = tag.select_one('div[role="heading"]')


        result = {
            'position': i + 1,
            'title': title.get_text().strip() if title else None,
            'link': None,
            'domain': None,
            'about_this_result': None,
            'block_position': i + 1,
        }

        if footer_part != None:
            result["serp"] = {
                "footer": str(footer_part) if footer_part else None,
            }

        if header_part != None:
            title = header_part.select_one('h3')
            displayed_link = header_part.select_one('cite')
            if displayed_link != None:
                displayed_name_parent = displayed_link.find_previous(lambda tag: tag.name == 'span')
                result['serp_header'] = {
                    "title": title.text if title else None,
                    "displayed_link": displayed_link.text if displayed_link else None,
                    "displayed_name": displayed_name_parent.text if displayed_name_parent else str(displayed_name_parent)
                }
        else:
            title = tag.select_one('h3')
            displayed_link = tag.select_one('cite')
            if displayed_link != None:
                displayed_name_parent = displayed_link.find_previous(lambda tag: tag.name == 'span')
                result['serp_header'] = {
                    "title": title.text if title else None,
                    "displayed_link": displayed_link.text if displayed_link else None,
                    "displayed_name": displayed_name_parent.text if displayed_name_parent else str(displayed_name_parent)
                }


        if middle_part != None:
            spans = middle_part.select('span')
            date_span = spans[0] if spans else None
            last_span = spans[-1] if spans else None

            em_words = [elem.text for elem in last_span.select('em')] if last_span else []

            result['meta_description'] = {
                "html": str(last_span) if last_span else None,
                "text": last_span.get_text().strip() if last_span else None,
                "highlighted_words": em_words if last_span and last_span.select_one('em') else None,
                "date": date_span.text.replace(' — ', '') if date_span and len(spans) > 1 else None,
            }


        if link != None:
            result['link'] = link
            pattern = r'(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/\n]+)'
            match = re.search(pattern, link)
            if match:
                result["domain"] = match.group(1)
                try:
                    post_content = get_post_info(link)
                    result["post_content"] = post_content
                except Exception as e:
                    print("Maybe an error here")
                    print(f"Exception at {link} - to continue")
                    continue

        result["snippet"] = {}

        if (snippet_heading != None):
            result['snippet']["heading"] = {
                "content": snippet_heading.get_text().strip(),
                "highlighted_word": snippet_heading.select_one('b').get_text().strip() if snippet_heading.select_one('b') else None,
                "html": str(snippet_heading)
            }
            print(f"======= SNIPPET PARENT =======")
            print(str(snippet_heading.find_next_sibling()))
            snippet_body = snippet_heading.find_next_siblings()
            if (snippet_body != None):
                result['snippet']["body"] = str(snippet_body)
            
            print(f"======= SNIPPET PARENT =======")

        
        
        
        # Append the search result to the list of results
        results.append(result)
    

    return Response({'results': results})


@api_view(['GET'])
def wordpress_post(request):

    post_info = get_post_info(request.query_params.get('url'))
    # Return the post information as a JSON response
    return Response({ "post_info": post_info })

@api_view(['POST'])
def clusterKeywords(request, _id=None):
    clusters_count = request.data.get('cluster_count')

    print(f"Cluster count: {clusters_count}")
    keywordsList = get_object_or_404(Keywords, _id=_id)
    serializer = KeywordsSerializer(keywordsList)

    """ for keyword in request.data["keywords"]:
        embedding = prompts.embedding_scaffold(keyword)
        embeddedKeywords["embeddings"].append({
            "keyword": keyword,
            "embedding": embedding
        }) """

    clustered_keywords = cluster_keywords(serializer.data, clusters_count)
    serializer = KeywordsSerializer(keywordsList, data={ "saved_cluster": clustered_keywords })
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)

    print("Not valid")
    return Response(serializer.data)

@api_view(['GET'])
def get_keywords_list_suggestions(request, _id=None):
    if _id is not None:
        keywordsList = get_object_or_404(Keywords, _id=_id)
        suggestions = keywordsList.suggestions.all()
        data = manual_pagination(suggestions, SuggestionSerializer, request)
        return JsonResponse(data)


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def keywordsActions(request, _id=None):
    user = get_user_from_token(request)
    if request.method == 'GET':
        if _id is not None:
            keywordsList = get_object_or_404(Keywords, _id=_id)
            serializer = KeywordsSerializer(keywordsList)
            return Response(serializer.data)
        else:
            keywords = Keywords.objects.filter(user=user['id'])
            serializer = KeywordsSerializer(keywords, many=True)
            return Response(serializer.data)
    
    request.data['user'] = user['id']
    if request.method == 'POST':
        suggestions_list = request.data.get("keywords", [])
        suggestions = [{ 'parent_keyword': '-', 'search_query': suggestion, 'project': request.data.get("project", None), 'user': user['id'] } for suggestion in suggestions_list]

        suggestionsSerializer = SuggestionSerializer(data=suggestions, many=True)
        if suggestionsSerializer.is_valid():
            suggestionsSerializer.save()

        embeddedKeywords = {
            "title": request.data.get("title", None),
            "suggestions": [suggestion['_id'] for suggestion in suggestionsSerializer.data],
            "user": user['id']
        }
        """ for keyword in request.data["keywords"]:
            embedding = prompts.embedding_scaffold(keyword)
            embeddedKeywords["embeddings"].append({
                "keyword": keyword,
                "embedding": embedding
            }) """
        serializer = KeywordsPostSerializer(data=embeddedKeywords)
        if serializer.is_valid():
            serializer.save()
            return Response(request.data.get("title"), status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        keywordsList = Keywords.objects.get(_id=_id)
    except Keywords.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = KeywordsSerializer(keywordsList, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        keywordsList.delete()
        delete_document('keywords', { 'filter_by': f'id:={_id}' })
        return Response(status=status.HTTP_204_NO_CONTENT)

# TODO: add project required decorator
@api_view(['POST'])
def autocomplete(request):
    try:
        general_niche = request.data.get('general_niche', None)
        if not general_niche:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
        results = autocomplete_suggestions(request.data)

        return create_ideation_keywords_list(general_niche, request, results)
    except Exception as e:
        return e

@api_view(['POST'])
def alphabet_soup(request):
    try:
        partial_query = request.data.get('partial_query', None)
        if not partial_query:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
        results = alphabet_soup_method(partial_query, request.data.get('country', 'US'))
        return create_ideation_keywords_list(partial_query, request, results)
    except Exception as e:
        return e

@api_view(['POST'])
def query_generation(request):
    try:
        partial_query = request.data.get('general_niche', None)
        if not partial_query:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
        results = query_generation_method(request.data)

        return create_ideation_keywords_list(partial_query, request, results)
    except Exception as e:
        return e