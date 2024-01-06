import openai

openai.api_key = "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"
EMBEDDING_MODEL="text-embedding-ada-002"

def embedding_scaffold(input):
  response = openai.Embedding.create(
    input=input,
    model=EMBEDDING_MODEL
  )

  return response.data[0].embedding

