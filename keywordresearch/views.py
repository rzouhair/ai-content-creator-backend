import re
from django.shortcuts import get_object_or_404, render
import requests
from keywordresearch.helpers.get_article_data import get_article_content, get_post_info
from keywordresearch.tasks import analyze_search_results
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status

import json

import nltk
from nltk.corpus import stopwords
from rake_nltk import Rake, Metric

from bs4 import BeautifulSoup

from core.helpers import get_html_content, unescape_html, get_response_content
from .helpers.cluster_keywords import cluster_keywords
from .helpers.get_article_info import get_article_info
from .helpers.search_results import get_search_query_html, get_organic_search_results, get_keyword_questions

from .models import Search, Suggestion
from .serializers import SearchGetSerializer, SearchSerializer, SuggestionSerializer

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
    with_styling = request.data.get('with_styling', False)
    if not query:
        return Response('No query provided')
    base_url = f"https://www.google.com/complete/search?q={query}&gl=us&cp=4&client=gws-wiz-serp&xssi=t&authuser=0&psi=bVUaZPSOEtCtkdUPoNa0-Ag.1679447406374&dpr=2"

    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    headers = {"user-agent": USER_AGENT} 

    url = base_url

    response = get_response_content(url, headers=headers)
    
    response = response[4:]  # remove the first 4 characters ")]}'"
    data = json.loads(response)
    return Response(map(lambda q: q[0] if with_styling else q[0].replace('<b>', '').replace('</b>', ''), data[0]))


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
    if request.method == 'GET':
        if _id is not None:
            suggestion = get_object_or_404(Suggestion, _id=_id)
            serializer = SuggestionSerializer(suggestion)
            return Response(serializer.data)
        else:
            suggestions = Suggestion.objects.all()
            serializer = SuggestionSerializer(suggestions, many=True)
            return Response(serializer.data)
    
    elif request.method == 'POST':
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

@api_view(['POST'])
def analyze_suggestion(request, suggestion_id):
    suggestion = Suggestion.objects.get(_id=suggestion_id)
    if suggestion.status == "IN_PROGRESS" or suggestion.status == 'ANALYZED':
        return Response("Suggestion analysis already started/finished", status=status.HTTP_400_BAD_REQUEST)
    suggestion.status = "IN_PROGRESS"
    suggestion.save()
    
    analyze_search_results.delay(suggestion._id)

    serializer = SuggestionSerializer(suggestion)
    return Response(serializer.data)

@api_view(['POST'])
def keywordClustering(request):
    keywords = request.data.get('keywords', None)
    num_clusters = request.data.get('num_clusters', 3)

    if keywords == None:
        return Response('No keywords provided', status=status.HTTP_400_BAD_REQUEST)

    clusters = cluster_keywords(keywords=keywords, num_clusters=num_clusters)

    return Response(clusters)


@api_view(['POST'])
def getRelatedQuestions(request):
    search_query = request.data.get('search_query', None)

    if search_query == None:
        return Response('No search query provided', status=status.HTTP_400_BAD_REQUEST)
    
    questions = get_keyword_questions(keyword=search_query)

    return Response(questions)


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def searchActions(request, _id=None):
    if request.method == 'GET':
        if _id is not None:
            suggestion = get_object_or_404(Suggestion, _id=_id)
            serializer = SearchGetSerializer(suggestion)
            return Response(serializer.data)
        else:
            suggestions = Suggestion.objects.all()
            serializer = SearchGetSerializer(suggestions, many=True)
            return Response(serializer.data)
    
    """ elif request.method == 'POST':
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
        return Response(status=status.HTTP_204_NO_CONTENT) """

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

        snippet = tag.select_one('div[role="heading"] span span')

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
            displayed_name_parent = displayed_link.find_previous(lambda tag: tag.name == 'span')
            result['serp_header'] = {
                "title": title.text if title else None,
                "displayed_link": displayed_link.text if displayed_link else None,
                "displayed_name": displayed_name_parent.text if displayed_name_parent else str(displayed_name_parent)
            }
        else:
            title = tag.select_one('h3')
            displayed_link = tag.select_one('cite')
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
                post_content = get_post_info(link)
                result["post_content"] = post_content

        if (snippet != None):
            result['snippet'] = {
                "content": snippet.get_text().strip(),
                "highlighted_word": snippet.select_one('b').get_text().strip() if snippet.select_one('b') else None,
                "html": str(snippet)
            }
        
        
        # Append the search result to the list of results
        results.append(result)
    

    return Response({'results': results})


@api_view(['GET'])
def wordpress_post(request):

    post_info = get_post_info(request.query_params.get('url'))
    # Return the post information as a JSON response
    return Response({ "post_info": post_info })