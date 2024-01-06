import requests
import html

import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from content_generation.helpers import prompts

def cluster_keywords(dataset, num_clusters=3):
    # Stack the arrays into a NumPy matrix
    embeddings = [obj.get("embedding", None) for obj in dataset["embeddings"]]
    matrix = np.vstack(embeddings)
    matrix.shape
    embeddings = embeddings / np.linalg.norm(embeddings, axis=1, keepdims=True)

    kmeans = KMeans(n_clusters=num_clusters, init="k-means++", random_state=42)
    kmeans.fit(matrix)
    labels = kmeans.labels_

    clustered_sentences = {}
    for sentence_id, cluster_id in enumerate(labels):
        if cluster_id not in clustered_sentences:
            clustered_sentences[int(cluster_id)] = []

        clustered_sentences[int(cluster_id)].append(dataset["embeddings"][int(sentence_id)])
    result = []
    for i in range(num_clusters):
        print(f"Cluster {i} Keywords:{clustered_sentences[i]}")

        keywords = list(map(lambda x: x['keyword'], clustered_sentences[i]))
        reviews = "\n".join(keywords)
        response = prompts.chat_scaffold([
            { "role": "user", "content": f'What do the following keywords have in common, what is the SEO optimized keyword that the following list of keywords fall into? Please answer in a short understandable keyword sentence of 3 to 4 words.\n\nkeywords:\n"""\n{reviews}\n"""\n\nParent Keyword:' }
        ])
        result.append({
            "parent_keyword": response["content"],
            "keywords": keywords
        })

    return result


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