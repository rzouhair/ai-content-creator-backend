import os
import openai

open_ai_api_key = os.getenv('OPEN_AI_API_KEY')

openai.api_key = open_ai_api_key
EMBEDDING_MODEL="text-embedding-ada-002"

def embedding_scaffold(input):
  response = openai.Embedding.create(
    input=input,
    model=EMBEDDING_MODEL
  )

  return response.data[0].embedding

