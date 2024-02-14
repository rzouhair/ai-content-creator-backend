from html import unescape
import json
import re
import time
from bs4 import BeautifulSoup
import requests
from core.helpers import get_html_content, unescape_html, get_response_content
from keywordresearch.helpers.get_article_data import get_post_info
from .get_article_info import get_article_info

def get_bing_suggestions(query, country='US'):
    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    headers = {"user-agent": USER_AGENT} 
    
    bing_url = f"https://www.bing.com/AS/Suggestions"
    params = {
        "mkt": country,
        "qry": query,
        "cp": 10,
        "cvid": "6E3353AA20CE4BDFA6634D8441275B34"
    }

    try:
        response = requests.get(bing_url, params=params, headers=headers)
        response.raise_for_status()
        html_content = response.text
        unescaped_html = unescape(html_content)
        soup = BeautifulSoup(unescaped_html, 'html.parser')
        options = soup.select('li.sa_sg[role="option"]')
        return options
    except requests.exceptions.RequestException as e:
        print("Error fetching Bing suggestions:", e)
        return None

def get_google_suggestions(query, country='US', with_styling=False):
    base_url = f"https://www.google.com/complete/search?q={query}&gl={country}&cp=4&client=gws-wiz-serp&xssi=t&authuser=0&psi=bVUaZPSOEtCtkdUPoNa0-Ag.1679447406374&dpr=2"

    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
    headers = {"user-agent": USER_AGENT} 

    url = base_url

    try:
      response = get_response_content(url, headers=headers)
      
      response = response[4:]  # remove the first 4 characters ")]}'"
      data = json.loads(response)
      return map(lambda q: q[0] if with_styling else unescape_html(q[0].replace('<b>', '').replace('</b>', '')), unescape_html(data[0]))
    except requests.exceptions.RequestException as e:
        print("Error fetching suggestions:", e)
        return None


def get_search_query_html(query):
    try:
       # desktop user-agent
      USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
      headers = {"user-agent": USER_AGENT} 

      search_query = f'https://www.google.com/search?q={query}&gl=us'
      print(search_query)
      html_escaped = get_html_content(search_query, headers=headers)
      print(html_escaped)

      html_unescaped = unescape_html(html_escaped)
      print(html_unescaped)

      return html_unescaped
    except Exception as e:
       print("An error here :" + str(e))


def get_serp_page_content(link):
  USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
  headers = {"user-agent": USER_AGENT} 
  print(f'======== LINK {link} =========')
  try:
    page_html = get_html_content(link, headers=headers) 
    if not page_html:
      print("===== NO HTML PAGE =====")
      return None
    page_soup = BeautifulSoup(page_html, 'html.parser')
    body = page_soup.select_one('body')
    if body:
      article = body.select_one('article.post') or body.select_one('div.article') or body.select_one('#article') or body.select_one('#article-body') or body.select_one('article')
      return get_article_info(article=article, body=body)
    else:
      print("===== NO BODY =====")
      return None;
    
  except:
    return None
  
 


def get_organic_search_results(html, with_data = False):
    soup = BeautifulSoup(html, 'html.parser')

    if not soup:
       return None

    serps = []

    body = soup.select('h3')
    a = soup.select('div[data-header-feature="0"] a')
    allSerps = soup.select('div.g')
    # soup.select('a')[0].get_attribute_list('href')

    def dataFeature(num, suffix, feature='header'):
      return f'div[data-{feature}-feature] {suffix}'

    if not body:
      return None
    else:
      for i, s in enumerate(allSerps[:10]):
        a = s.select_one('a')
        link = a.get_attribute_list('href')[0] if a else None
        title = s.select_one('h3')

        snippet = s.select_one('div[role="heading"] span span')

        date = s.select_one(dataFeature(2, 'span span', feature='content'))
        meta_description = s.select_one(dataFeature(2, 'span:nth-of-type(2)', feature='content'))

        result = {
          'position': i + 1,
          'url': link,
          'title': title.get_text().strip() if title else 'None',
          'date': date.get_text().strip() if date else None,
          'meta_description': meta_description.get_text().strip() if meta_description else None,
        }

        if link:
          if (with_data):
            result['page_data'] = get_serp_page_content(link)
          
        if (snippet):
          result['snippet'] = snippet.get_text() if snippet else 'ya noona'
        
        serps.append(result)

        """ page_html = get_html_content(link, headers=headers)
        page_soup = BeautifulSoup(page_html, 'html.parser')
        article = page_soup.select_one('article') or page_soup.select_one('div.article') or page_soup.select_one('#article') or page_soup.select_one('#article-body')

        search_content[f'heading_{i}'] = {
            'text': heading.get_text().strip(),
            'link': link,
            **get_article_info(article)
        } """

    return serps

def extract_ppa_questions(soup, old_questions):
    questions = [*old_questions]

    if not soup:
        return None

    ppa_soup = soup.select('div[data-initq] div[data-sgrd] div div[role="button"]')

    ppa_holders = [k['question'] for k in questions if k['type'] == 'PPA']
    for i, ppa in enumerate(ppa_soup):
        text = ppa.get_text().strip()
        if text in ppa_holders:
            for q in questions:
                if q.get('type') == 'PPA' and q.get('question') == text:
                    q['visible_in_serps'] = q.get('visible_in_serps', 0) + 1
        else:
            ppa_holders.append(text)
            questions.append({
                "question": ppa.get_text().strip(),
                "type": 'PPA',
                'visible_in_serps': 1,
            })

    print(questions)
    return questions

def extract_related_questions(soup, old_questions):
    questions = [*old_questions]

    if not soup:
        return None

    related_questions_soup = soup.select('[data-abe] a')
    related_holders = [k['question'] for k in questions if k['type'] == 'Related']

    for i, rq in enumerate(related_questions_soup):
        text = rq.get_text().strip()
        if text in related_holders:
            for q in questions:
                if q.get('type') == 'Related' and q.get('question') == text:
                    q['visible_in_serps'] = q.get('visible_in_serps', 0) + 1
        else:
            related_holders.append(text)
            questions.append({
                "question": text,
                "type": 'Related',
                'visible_in_serps': 1,
            })

    print(questions)
    return questions


def get_keyword_questions(keyword, old_questions = []):

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

  questions = [*old_questions]

  if not soup:
      return None

  ppa_holders = extract_ppa_questions(soup, questions)
  related_holders = extract_related_questions(soup, questions)


  """ ppa_soup = soup.select('div[data-initq] div[data-sgrd] div div[role="button"]')
  ppa_holders = []
  for i, ppa in enumerate(ppa_soup):
    text = ppa.get_text().strip()
    if text in ppa_holders:
      for q in questions:
        if q.get('type') == 'PPA' and q.get('question') == text:
          q['visible_in_serps'] = q.get('visible_in_serps', 0) + 1
    else:
      ppa_holders.append(text)
      questions.append({
          "question": ppa.get_text().strip(),
          "type": 'PPA',
          'visible_in_serps': 1,
      })
    

  related_questions_soup = soup.select('[data-abe] a')
  related_holders = []
  for i, rq in enumerate(related_questions_soup):
    text = rq.get_text().strip()
    if text in related_holders:
      for q in questions:
        if q.get('type') == 'Related' and q.get('question') == text:
          q['visible_in_serps'] = q.get('visible_in_serps', 0) + 1
    else:
      related_holders.append(text)
      questions.append({
          "question": text,
          "type": 'Related',
          'visible_in_serps': 1,
      })
 """
  print(f"First batch: {questions}")
  print(f"First batch: {ppa_holders}")
  print(f"First batch: {related_holders}")
  print(f"First batch done")

  first_batch_of_questions = [*questions, *ppa_holders, *related_holders]

  loop_questions = [*questions, *ppa_holders, *related_holders]

  print("Loop questions")
  print(loop_questions)
  for q in loop_questions:

    time.sleep(3)
    print(f"Slept 1 second for {q.get('question')} - {q.get('type')}")
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
        'referer':'https://www.google.com/'
    }
    url = f'https://www.google.com/search?q={q.get("question")}&gl=us'
    response = requests.get(url, headers=headers)

    inner_html = response.text

    inner_soup = BeautifulSoup(inner_html, 'html.parser')
    inner_ppa_questions = extract_ppa_questions(inner_soup, first_batch_of_questions)
    first_batch_of_questions = inner_ppa_questions
    """ inner_ppa_soup = inner_soup.select('div[data-initq] div[data-sgrd] div div[role="button"]')

    for i, ppa in enumerate(inner_ppa_soup):
      text = ppa.get_text().strip()
      if text in ppa_holders:
        for iq in questions:
          if iq.get('type') == 'PPA' and iq.get('question') == text:
            iq['visible_in_serps'] = iq.get('visible_in_serps', 0) + 1
      else:
        ppa_holders.append(text)
        questions.append({
            "question": ppa.get_text().strip(),
            "type": 'PPA',
            'visible_in_serps': 1,
        }) """

    inner_related_questions = extract_related_questions(inner_soup, first_batch_of_questions)
    first_batch_of_questions = inner_related_questions

    """ inner_related_questions_soup = soup.select('a[data-abe="true"]')

    for i, rq in enumerate(inner_related_questions_soup):
      text = rq.get_text().strip()
      if text in related_holders:
        for iq in questions:
          if iq.get('type') == 'Related' and iq.get('question') == text:
            iq['visible_in_serps'] = iq.get('visible_in_serps', 0) + 1
      else:
        related_holders.append(text)
        questions.append({
            "question": text,
            "type": 'Related',
            'visible_in_serps': 1,
        }) """

  return list(first_batch_of_questions)

def merge_questions(arr1, arr2):
    merged = []
    for q1 in arr1:
        added = False
        for q2 in arr2:
            if q1["question"] == q2["question"]:
                merged_question = q1.copy()
                merged_question["visible_in_serps"] = q1["visible_in_serps"] + q2["visible_in_serps"]
                merged.append(merged_question)
                added = True
                break
        if not added:
            merged.append(q1)
    for q2 in arr2:
        if not any(q2["question"] == mq["question"] for mq in merged):
            merged.append(q2)
    return merged


def analyze_google_search(query):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    }
    url = f'https://www.google.com/search?q={query}&gl=us'
    response = requests.get(url, headers=headers)

    print(f"================== Response ==================")
    # Use BeautifulSoup to parse the HTML content of the search results page
    soup = BeautifulSoup(response.content, 'html.parser')

    print(f"================== Soup extracted ==================")
    # Find all the search result elements using the tags and CSS classes that contain the relevant data
    result_elements = soup.select('div.g[lang]')

    print(f"================== Got serps ==================")

    # Loop through each search result element and extract the relevant data
    results = []
    for i, tag in enumerate(result_elements):

        title = tag.select_one('a h3')
        print(f"================== Analysing {title} ==================")
        anchor = tag.select_one('a')
        link = anchor.get_attribute_list('href')[0] if anchor else None

        header_part = tag.select_one('div[data-snf]')
        middle_part = tag.select_one('div[data-sncf="1"]')
        footer_part = tag.select_one('div[data-sncf="2"]')

        snippet_heading = tag.select_one('div[role="heading"]')
        snippet_body = tag.select_one('div:not([role]) + div[role="heading"]')

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

            if (last_span != None):
              em_words = [elem.text for elem in last_span.select('em')]

            result['meta_description'] = {
                "html": str(last_span) if last_span else None,
                "text": last_span.get_text().strip() if last_span else None,
                "highlighted_words": em_words if last_span != None and last_span.select('em') else None,
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
        
        result["snippet"] = {}

        if (snippet_heading != None):
            result['snippet']["heading"] = {
                "content": snippet_heading.get_text().strip(),
                "highlighted_word": snippet_heading.select_one('b').get_text().strip() if snippet_heading.select_one('b') else None,
                "html": str(snippet_heading)
            }

        if (snippet_body != None):
            result['snippet']["body"] = str(snippet_body)
        
        
        # Append the search result to the list of results
        results.append(result)
    

    return results

