from content_generation.helpers.prompts import embedding_scaffold
import typesense
import boto3
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')

print(aws_secret_access_key)
print(aws_access_key_id)

s3_client = boto3.client('s3',
  aws_access_key_id=aws_access_key_id,
  aws_secret_access_key=aws_secret_access_key,
)

typesense_client = typesense.Client({
    'api_key': 'xyz',
    'nodes': [{
        'host': 'typesense',
        'port': '8108',
        'protocol': 'http'
    }],
    'connection_timeout_seconds': 2
})

def create_collection(collection_name = 'keywords'):
  try:
    typesense_client.collections.create({
      'name': collection_name,
      'enable_nested_fields': True,
      'fields': [
        {'name': 'id', 'type': 'string' },
        {'name': 'parent_id', 'type': 'string' },
        {'name': 'text', 'type': 'string' },
        {'name': 'embedding', 'type': 'float[]', 'num_dim': 1536, 'index': True, 'sort': False, 'facet': False },
        {
          'name': "metadata.*",
          'type': "object",
          'optional': True,
          'index': True,
          'facet': True,
        },
      ],
    })
    print(f"{collection_name} collection created")
  except Exception as e:
    print(f"{collection_name} collection NOT created")
    print("An error occurred : " + str(e))
    pass

def retrieve_document(collection, options):
  res = typesense_client.collections[collection].documents.search(options)
  return res['hits'][0]['document'] if len(res['hits']) else None

def retrieve_documents(collection, options):
  res = typesense_client.collections[collection].documents.search(options)
  return [t['document'] for t in res['hits']]

def nearest_neighbor_search(
  table: str,
  q: str,
  k: int,
  params = {},
  distance_threshold = 0.5
):
  embedding = embedding_scaffold(q)

  print(f"embedding:({embedding}, k:{k}, distance_threshold:{distance_threshold or 0.5})")

  search_requests = {
    "searches": [
      {
        "collection": table,
        "q": "*",
        "vector_query": f"embedding:({embedding}, k:{k}, distance_threshold:{distance_threshold or 0.5})",
        "exclude_fields": 'embedding',
        **(params or {}),
      }
    ]
  }

  common_search_params = {}
  res = typesense_client.multi_search.perform(search_requests, common_search_params)

  return res["results"][0]

def similar_document_search(
    table, id, params=None, distance_threshold=None
):
    search_requests = {
        "searches": [
            {
                "collection": table,
                "q": "*",
                "vector_query": f"embedding:([], id:{id}, distance_threshold:{distance_threshold or 0.5})",
                **(params or {}),
            }
        ]
    }

    common_search_params = {}
    res = typesense_client.multi_search.perform(search_requests, common_search_params)

    return res["results"][0]

def update_document(collection, fields, filters):
  return typesense_client.collections[collection].documents.update(fields, filters)

def create_document(collection, fields):
  return typesense_client.collections[collection].documents.create(fields)

def delete_document(collection, filters):
  return typesense_client.collections[collection].documents.delete(filters)
