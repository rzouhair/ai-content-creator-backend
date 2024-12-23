import os
import requests
import time
from typing import Optional
import random
import string

def improve_readability(input):
  prompt = f"""Rewrite the following text to make it easily understandable by a 12-year-old reader while maintaining a formal tone. Follow these guidelines:

1. Use simple, clear language suitable for a young reader
2. Keep sentences short and straightforward
3. Explain any complex concepts or terms
4. Maintain a formal, non-conversational style
5. Ensure the text is free from plagiarism by completely rephrasing the content
6. Correct any grammar, spelling, and punctuation errors
7. Improve overall readability and clarity
8. Choose words that are easily understood by a 12-year-old
9. Remove any unnecessary information to improve conciseness
10. Address any other writing issues to enhance the text's effectiveness

Original text:

"{input}"

Please provide a revised version that follows these guidelines while preserving the original message and key information."""
  return prompt

def generate_session_id(length: int = 20) -> str:
    """
    Generate a random session ID similar to the format used by HumanizeAI.
    The ID consists of lowercase letters only.
    
    Args:
        length: Length of the session ID to generate (default 20)
    
    Returns:
        A random session ID string
    """
    return ''.join(random.choice(string.ascii_lowercase) for _ in range(length))

def split_paragraph(paragraph):
  return f"""Please reformat the following blog post text to make it more reader-friendly and SEO-optimized by:

0. (Important) return the reformatted paragraph without any explanation, intro, or other fluff, only the reformatted paragraph
1. Breaking down long paragraphs into smaller, digestible chunks of 2-3 sentences each
2. Ensuring each paragraph focuses on a single main idea
3. Adding a line break between paragraphs where appropriate
4. Identifying natural transition points for new paragraphs
5. Maintaining the logical flow of ideas while making the content more scannable

Here's the text to reformat:

{paragraph}"""

def process_text_through_humanize(text: str) -> Optional[str]:
  try:
    # send a post request to the "BASE_TOOLS_API_URL + /humanize" with the text

    response = requests.post(f"{os.environ['BASE_TOOLS_API_URL']}/humanize", json={"text": text})
    if response.status_code == 200:
      # if the response is successful, return the result
      return response.json()
    else:
      # if the response is not successful, return None
      return None
  except requests.exceptions.RequestException as e:
    print(f"Network error occurred: {e}")
    return None
  except Exception as e:
    print(f"Error processing text: {e}")
    return None

def generate_image(prompt, options = {
      "model": 'V_1_TURBO',
      "aspect_ratio": 'ASPECT_16_9',
      "magic_prompt_option": 'OFF'
    }, number_of_images = 1) -> Optional[str]:
  try:
    response = requests.post(f"{os.environ['BASE_TOOLS_API_URL']}/generate", json={"prompt": prompt, "options": options, "number_of_images": number_of_images})
    if response.status_code == 200:
      # if the response is successful, return the result
      return response.json()['images']
    else:
      # if the response is not successful, return None
      return None
  except Exception as e:
    print(e)
    return None