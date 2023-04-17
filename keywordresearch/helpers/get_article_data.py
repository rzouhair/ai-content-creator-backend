import re
from bs4 import BeautifulSoup
import requests

def get_article_data(art, body):
  article = BeautifulSoup(str(art), 'html.parser')
  h1 = None
  if (body):
    h1 = body.find('h1')
  else:
    h1 = article.find('h1')

  # Find all h2 and h3 tags
  tags = article.find_all(['h2', 'p', 'h3'])

  def get_p(l):
    if l.name == 'p':
      return True
    else:
      return False

  def get_h2s(l):
    if l.name == 'h2':
      return True
    else:
      return False
  
  def get_h3s(l):
    if l.name == 'h3':
      return True
    else:
      return False

  def get_headings(l):
    if l.name == 'h2' or l.name == 'h3':
      return True
    else:
      return False

  ps = set(list(filter(get_p, tags)))
  h2s = list(filter(get_h2s, tags))
  h3s = list(filter(get_h3s, tags))

  headings = list(filter(get_headings, tags))

  return {
    'h1': h1,
    'h2': h2s,
    'h3': h3s,
    'p': ps,
    'article': str(article),
    'headings': headings
  }

def get_article_content(soup):
  content_classes = ['entry-content', 'post-content', 'the-content', 'content-area', 'article-content', 'body-content', 'single-post-content', 'entry-inner', 'entry', 'post', 'content', 'body-content', 'bodyContent']
  content_ids = ['content', 'main-content', 'post-content', 'article-body', 'article', 'main-article', 'bodyContent', 'body-content']
  content_tags = ['main', 'article']

  content = None
  for content_class in content_classes:
    content = soup.select_one(f".{content_class}")
    if content:
        break

  if content is None:
    for content_id in content_ids:
        content = soup.select_one(f"#{content_id}")
        if content:
            break

  if content is None:
    for content_tag in content_tags:
        content = soup.find(content_tag)
        if content:
            break

  return content


def calculate_headings_length(soup):
    # Get all the headings from h1 to h6
    headings = soup.find_all(['h2', 'h3', 'h4', 'h5', 'h6'])

    # Calculate the total length of all the headings
    total_length = 0
    for heading in headings:
        total_length += len(heading.text.split())

    return total_length

def get_post_info(url):

    try:
      # Make a request to the blog post url and get the HTML content
      print(f"============== TESTING {url} =============")
      response = requests.get(url, timeout=5)
      print(f"============== REQUESTED =============")
      html = response.content
      print(f"============== CONTENT =============")

      # Parse the HTML content using Beautiful Soup
      soup = BeautifulSoup(html, 'html.parser')

      # Get the blog title
      h1_entry = soup.select_one('h1.entry-title')

      if (h1_entry != None):
          blog_title = h1_entry.get_text().strip()
      else:
          h1 = soup.select_one('h1')
          blog_title = h1.get_text().strip() if h1 else None
        
      print(f"============== {url} GOT H1 =============")
      # Get the word count, paragraph count, and headings count
      content = get_article_content(soup)
      if content == None:
          return None
      print(f"============== GOT CONTENT =============")
      word_count = len(content.text.split())
      word_count_with_headings = word_count + calculate_headings_length(soup) + (len(blog_title.split()) if blog_title else 0)
      paragraphs_count = len(content.find_all('p'))
      headings_count = len(content.find_all(['h1', 'h2', 'h3'])) + (1 if blog_title else 0)

      # Get the images count
      images_count = len(content.find_all('img'))

      links_count = len(content.find_all(['a']))
      internal_links_count = 0
      external_links_count = 0

      links = []
      
      def get_domain(link):
          pattern = r'(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/\n]+)'
          match = re.search(pattern, link)
          if match:
              return match.group(1)
          else:
              return ""

      for link in content.select('a'):
          href = link.get_attribute_list('href')[0]

          if href is not None:
              links.append({
                  "link": str(href),
                  "domain": get_domain(href) if not href.startswith('#') else get_domain(url),
                  "is_internal": href.startswith('#') or href.startswith('/') or get_domain(href) == get_domain(url)
              })
              if 'mailto:' in href:
                  external_links_count += 1
                  continue
              if href.startswith('#'):
                  internal_links_count += 1
              else:
                  # This assumes that internal links are on the same domain
                  if get_domain(href) == get_domain(url):
                      internal_links_count += 1
                  else:
                      external_links_count += 1


      # Get the table of contents
      toc = []
      for heading in content.find_all(['h1', 'h2', 'h3']):
          toc.append({
              'name': heading.text.strip(),
              'id': heading.get_attribute_list('id')[0],
              'level': heading.name,
          })

      # Create a dictionary to hold the post information
      post_info = {
          'blog_title': blog_title,
          'word_count': word_count,
          'word_count': word_count_with_headings,
          "word_count_without_headings": word_count,
          'paragraphs_count': paragraphs_count,
          'headings_count': headings_count,
          'images_count': images_count,
          'links_count': links_count,
          "link": {
              "count": links_count,
              "internal": internal_links_count,
              "external": external_links_count,
              "details": links,
          },
          'toc': toc,
      }

      return post_info
    
    except Exception as e:
       print(f"Exception at ({url}) - {str(e)}")