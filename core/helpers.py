import requests
import html
import math
import json

import numpy as np
from sklearn.cluster import DBSCAN
from sklearn.metrics import silhouette_score
from sklearn.cluster import KMeans
from content_generation.helpers import prompts

def suggested_num_clusters(embeddings, eps_range=(0.1, 2.0), min_samples_range=(5, 20)):
    best_eps = 0
    best_min_samples = 0
    best_score = -1
    
    for eps in np.arange(eps_range[0], eps_range[1], 0.1):
        for min_samples in range(min_samples_range[0], min_samples_range[1] + 1):
            dbscan = DBSCAN(eps=eps, min_samples=min_samples)
            clusters = dbscan.fit_predict(embeddings)
            if len(np.unique(clusters)) > 1:  # Ensure at least two clusters are formed
                score = silhouette_score(embeddings, clusters)
                if score > best_score:
                    best_score = score
                    best_eps = eps
                    best_min_samples = min_samples
                    
    return best_eps, best_min_samples

def cluster_keywords(dataset, num_clusters=3):
    # Stack the arrays into a NumPy matrix
    embeddings = [obj.get("embedding", None) for obj in dataset]
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

        clustered_sentences[int(cluster_id)].append(dataset[int(sentence_id)])
    result = []
    for i in range(num_clusters):
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


def manual_pagination(queryset, serializer_class, request):
    # Get pagination parameters from the query parameters
    page = int(request.query_params.get('page', 1))
    page_size = int(request.query_params.get('page_size', 2))
    sort_by = request.query_params.get('sort_by')
    if sort_by:
        sort_order = '-' if sort_by.startswith('-') else ''
        sort_by = sort_by.lstrip('-')

        # Apply sorting to the queryset
        queryset = queryset.order_by(sort_order + sort_by.replace('.', '__'))

    # Calculate the starting and ending indices for the pagination
    start_index = (page - 1) * page_size
    end_index = start_index + page_size

    # Retrieve the data subset based on pagination indices
    paginated_queryset = queryset[start_index:end_index]
    serializer = serializer_class(paginated_queryset, many=True)
    
    return {
        'page': page,
        'page_size': page_size,
        'page_count': math.ceil(len(queryset) / page_size),
        'items_count': len(queryset),
        'data': serializer.data,
    }