import nltk
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans
import numpy as np

def cluster_keywords(keywords, num_clusters=3):
    if not keywords:
       return 'none'
      
    print(keywords)

    queries = list(keywords)

    # Tokenize the queries
    tokenized_queries = [word_tokenize(query) for query in queries]

    # Vectorize the queries
    vectorizer = TfidfVectorizer()
    vectors = vectorizer.fit_transform(queries)

    # Cluster the queries using K-Means
    kmeans = KMeans(n_clusters=num_clusters)
    kmeans.fit(vectors)

    # Assign names to each cluster based on the most common keywords
    cluster_names = []
    for i in range(num_clusters):
        centroid = kmeans.cluster_centers_[i]
        closest_words = sorted(
            [(vectorizer.get_feature_names()[j], centroid[j]) for j in range(len(centroid))],
            key=lambda x: -x[1]
        )
        cluster_name = ", ".join([word for word, score in closest_words[:3]])
        cluster_names.append(cluster_name)

    # Create a dictionary of the clusters and their queries
    clusters = {}
    for i in range(num_clusters):
        cluster_queries = []
        for j in range(len(queries)):
            if kmeans.labels_[j] == i:
                cluster_queries.append(queries[j])
        clusters[cluster_names[i]] = cluster_queries

    return clusters
