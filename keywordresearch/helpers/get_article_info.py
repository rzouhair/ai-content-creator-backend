
# from rake_nltk import Rake
import nltk
from bs4 import BeautifulSoup

from .get_article_data import get_article_data

def get_article_info(article, body = None, getAll=False):
  """ nltk.download('stopwords')
  nltk.download('punkt') """

  data = get_article_data(article, body)

  # r = Rake()

  # Find all h2 and h3 tags
  tags = data['headings']

  pText = [str(p.get_text()) for p in data['p']] if data['p'] else []
  h1Text = data['h1'].get_text() if data['h1'] else 'None'
  h2Text = [str(h2.get_text()) for h2 in data['h2']] if data['h2'] else []
  h3Text = [str(h3.get_text()) for h3 in data['h3']] if data['h3'] else []

  sortedHeadings = [str(f'{p.name} - {p.get_text()}') for p in tags] if tags else None

  length = len(f'{" ".join(set(pText)) if pText else ""}'.split()) + len(f'{h1Text or ""}'.split()) + len(f'{" ".join(set(h2Text)) if h2Text else ""}'.split()) + len(f'{" ".join(set(h3Text)) if h3Text else ""}'.split()) 

  allGrouped = f""" {h1Text} {' '.join(h2Text) if h2Text and len(h2Text) else ''} {' '.join(h3Text) if h3Text and len(h3Text) else ''} {' '.join(pText) if pText and len(pText) else ''} """

  # phrases = []
  max_sum = []
  mmr = []

  # Sort the tags by their position in the HTML
  # sorted_tags = sorted(tags, key=lambda tag: tag.attrs.get('data-pos'))
  resp = {
      'p': pText,
      'h1': h1Text,
      'h2': h2Text,
      'h3': h3Text,
      'sorted_headings': sortedHeadings,
      'length': length,
      # 'joined': map(lambda pa: pa[1], sorted(list(set(phrases)), key=lambda x: x[0], reverse=True)) if allGrouped else 'Not an iterable',
      # 'allCombined': allGrouped
  }

  return resp