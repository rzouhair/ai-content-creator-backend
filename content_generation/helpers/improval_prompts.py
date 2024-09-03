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