import re
import time
from bs4 import BeautifulSoup
import requests
from core.helpers import get_html_content, unescape_html, get_response_content
from keywordresearch.helpers.get_article_data import get_post_info
from .get_article_info import get_article_info

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


def get_keyword_questions(keyword):

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

  questions = []

  if not soup:
      return None

  ppa_soup = soup.select('div[data-initq] div[data-sgrd] div div[role="button"]')

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
    

  related_questions_soup = soup.select('a[data-xbu="true"]')
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

  print(f"First batch done")

  first_batch_of_questions = [*questions]

  for q in first_batch_of_questions:

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
    inner_ppa_soup = inner_soup.select('div[data-initq] div[data-sgrd] div div[role="button"]')

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
        })

    inner_related_questions_soup = soup.select('a[data-xbu="true"]')

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
        })

  return list(questions)


def analyze_serp_dr(keyword):

  html = get_search_query_html(keyword)

  soup = BeautifulSoup(html, 'html.parser')

  questions = []

  if not soup:
      return None

  return None


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

            em_words = [elem.text for elem in last_span.select('em')]

            result['meta_description'] = {
                "html": str(last_span) if last_span else None,
                "text": last_span.get_text().strip() if last_span else None,
                "highlighted_words": em_words if last_span.select_one('em') else None,
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
    

    return results

