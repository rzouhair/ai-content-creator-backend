import requests
import html

def unescape_html(code):
    return html.unescape(code)

def get_html_content(url, headers):
    """Sends an HTTP GET request to the given URL and returns the HTML content as a string."""
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.text
    else:
        # Handle errors (e.g. log the error, raise an exception)
        return None

def get_response_content(url, headers):
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.content
    else:
        # Handle errors (e.g. log the error, raise an exception)
        return None