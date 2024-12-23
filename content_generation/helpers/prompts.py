import os
import openai
import json

open_ai_api_key = os.getenv('OPEN_AI_API_KEY')
openai.api_key = open_ai_api_key

GPT_MODEL='gpt-4o-mini'
EMBEDDING_MODEL="text-embedding-ada-002"

def embedding_scaffold(input):
  print(f"Start embedding : {input}")
  response = openai.Embedding.create(
    input=input,
    model=EMBEDDING_MODEL
  )

  print("Done embedding")

  return response.data[0].embedding

def chat_scaffold(messages, function_call=None):
  resp = openai.ChatCompletion.create(
    model=GPT_MODEL,
    messages=messages,
  ) if not function_call else openai.ChatCompletion.create(
    model=GPT_MODEL,
    messages=messages,
    functions=function_call,
    function_call="auto",
  )


  try:
    if not function_call:
      raise Exception
    content = resp.choices[0].message.function_call.arguments
    return {
      'usage': resp['usage'],
      "content": json.loads(content)
    }
  except:
    content = resp.choices[0].message.content
    return {
      'usage': resp['usage'],
      "content": content
    }

def detect_search_intent(keyword):
  return chat_scaffold([
    { 'role': 'system', 'content': """
# What Is Search Intent?

Search intent (also known as user intent) is the reason why a user types a particular query into a search engine. It represents what the user is trying to achieve with their search, whether that's finding an answer to a question, looking for a specific website, purchasing a product, or exploring a topic.

Keyword intent or keyword search intent is the same thing as search intent. It basically means the search intent behind a specific keyword. Some keywords may have a clear intent, while some intent may not be obvious from the keyword. We call this a “mixed intent.”

A common example of a mixed intent is a search term that is the name of a specific product—like “iphone 13 pro max.”

Since it’s unclear whether a user’s intent is transactional, commercial, or informational, the Google search results will include various types of results and SERP features to make sure they meet different search needs.

Let's say someone searches for “best dog food” on Google.

They're not trying to navigate to a specific page. And they don't want to buy a specific product either. (At least not yet.)

They want to do their research before making a purchase.

That means the keyword has commercial intent. And we can use this knowledge to adjust our content to target this keyword better.

## The Four Types of Search Intent

We usually distinguish between four types of search intent:

1. **Navigational Intent:**
   - Users want to find a specific page (e.g., “reddit login”)

   Examples:
   - starbucks
   - gmail login
   - semrush keyword magic tool
   - ikea refund policy

   Navigational keywords are often branded, ensuring easy access for the target audience.

2. **Informational Intent:**
   - Users want to learn more about something (e.g., “what is seo”)

   Examples:
   - bruce willis movies
   - what is seo
   - california time now
   - how to clean a dishwasher

   Informational queries make up a significant number of searches, often addressed with blog posts.

   - Benefits:
     - Visibility
     - Building trust
     - Targeting new leads

3. **Commercial Intent:**
   - Users want to do research before making a purchase decision (e.g., “best coffee maker”)

   Examples:
   - best indoor plants for low light
   - apple watch ultra review
   - mailchimp alternatives
   - hbo max vs netflix

   Commercial queries lie between informational and transactional intent.

4. **Transactional Intent:**
   - Users want to complete a specific action, usually a purchase (e.g., “buy subaru forester”)

   Examples:
   - iphone 13 pro max price
   - personality test online
   - semrush trial
   - watch friends

   Transactional keywords are crucial for conversions.

## How to Determine Search Intent

Search intent often aligns with where users are in the marketing funnel:

- **Awareness:** User searches for informational keywords like “how to do keyword research”
- **Consideration:** User searches for commercial keywords like “best keyword research tools”
- **Conversion:** User searches for transactional or navigational keywords like “Semrush plans”

Determining search intent is a crucial step in any content strategy. Tools like Semrush can automatically calculate search intent for every keyword.

To find the “Intent” metric in Keyword Overview:

- The calculation is based on the words within the keyword phrase and the SERP features present in the search results.

## How Many Types of Search Intent Are There?

The most common intent categorization includes four types of search intent: navigational, informational, commercial, and transactional.

Google uses a slightly different categorization in their Search Quality Evaluator Guidelines, distinguishing between:

- “Know” queries: Users want information (corresponds to informational intent)
- “Do” queries: Users want to do something (corresponds to transactional intent)
- “Website” queries: Users want to visit a specific website (corresponds to navigational intent)
- “Visit-in-person” queries: Users want to visit a specific physical place

""" },
    { 'role': 'user', 'content': f"""
Your task is to determine the search intent associated with a given keyword or search query. You'll be provided with a string, including the keyword or query, as an input. You need to analyze the given string and determine which of the four types of search intent it belongs to. The types of search intent are: 

1. Navigational intent: The user is trying to find a specific page (e.g., branded keywords, specific tool or page names)
2. Informational intent: The user wants to learn more about a subject (e.g., questions or queries involving who, what, where, why, or how)
3. Commercial intent: The user is doing research before making a purchase decision (e.g., searches involving best, review, comparison, etc.)
4. Transactional intent: The user wants to complete a specific action, which could be purchasing a product, subscribing to a service, or downloading a software/tool (e.g., queries containing specific product names, price, online tests, or trial)

The output should be a single string, stating the category of search intent like "Navigational", "Informational", "Commercial", or "Transactional". It's critical you make this decision based on the defined categories and the nature of the input keyword.

Avoid repetitive or monotonous responses, and incorporate intricate mechanisms such as checking for specific words, prefixes, or patterns associated with each type of intent. Be cautious not to generate irrelevant or inappropriate responses, as this could lead to a poor user experience. 

Remember, the goal is to as accurately as possible determine the search intent. You are not just generating text, but analyzing and categorizing the input based on the provided definitions.

Please return only the search intent word, nothing else, no fluff, introduction, conversational fluff, nothing, only the search intent

The Keyword Input:
{keyword}

The Search Intent:
""" }
  ])

title_system_prompt = "You are title generator, you help the user create catchy, relevant titles that can improve click-through rates and enhance website rankings, you only return a plain JSON array containing the number of titles the user requested, not an object, an array .When generating your response, please focus solely on providing relevant and informative content that directly answers the prompt. Please refrain from using affirmative language or providing irrelevant information that does not directly address the prompt."

outline_system_prompt = "As an outline generator, help the user create a well-structured outline for their blog post that is SEO optimized and engages readers, returning a plain JSON array with an optimal number of sections based on the user's desired length, and if the user doesn't provide the number of headlines to generate, generate a reasonable number of headlines based on the SERPs. .When generating your response, please focus solely on providing relevant and informative content that directly answers the prompt. Please refrain from using affirmative language or providing irrelevant information that does not directly address the prompt. Using the target keyword as an input, please generate a JSON array output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON array. Include any additional formatting or syntax required to produce a valid JSON array."

meta_title_system_prompt = 'You are a meta-title generator, you follow the most updated SEO guidelines to create the most compelling, eye-catching SEO optimized meta title to rank on top of google SERPs, I will provide a target keyword, and it will be your job to come up with a JSON array containing the number of titles desired by the user.'

meta_description_prompt = 'Objective: Generate a JSON array containing a certain number of SEO-optimized meta description for a blog post using the provided keyword, Instructions: Use the primary keyword: Include "Tips for Starting a Successful Blog" in the meta description, ensuring it reads naturally. Use action-oriented language: Use action-oriented language to encourage clicks and engagement, such as "Start your successful blog today" or "Get expert tips for a successful blog." Be descriptive: Provide a concise summary of the blog post, accurately reflecting the content, such as "Learn key strategies to successfully launch and maintain a blog in any niche." Keep it under 160 characters: To ensure proper display in search results, keep the meta description under 160 characters. Highlight benefits: Emphasize the benefits of reading the blog post, such as "Discover the essential steps needed to create a successful blog that stands out to your audience." Include a call-to-action: Encourage clicks and engagement by using a clear and straightforward call-to-action, such as "Take your blog to the next level, read our guide now!"\n Using the data provided by the user as an input, please generate a JSON array output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON array. Include any additional formatting or syntax required to produce a valid JSON array.'

blog_format_prompt = "Objective: for the title the user provides, generate a JSON object. The object should have two properties: 'format' for the format of the blog post and 'intent' for the search intent. The values associated with each property should be exclusively from the following lists: Format - [Listicle - How-to Guide - Interview - Opinion Piece - Infographics - Video Posts - Case Study and more] and Intent - [Informational - Navigational - Commercial - Transactional]. Using the data provided by the user as an input, please generate a JSON object output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON object. Include any additional formatting or syntax required to produce a valid JSON object."

blog_section_dev = """As an expert SEO content writer, you follow the most relevant SEO guidelines to write the perfect SEO optimized blog post sections. you write in 8th to 9th grade reading level, Research relevant keywords, Use short naturally sounding paragraphs, use bullet points or numbered lists whenever it is possible, Optimize your content for SEO and more...
"""

extract_transcript_info = """You are an experienced prompt engineer creating a GPT prompt to extract topics, outline, and summary from a YouTube transcript. The YouTube transcript is expected to cover a specific subject, and the generated response will be written in English. The purpose of this prompt is to provide a structured breakdown of the content discussed in the transcript.

GPT, you are a highly skilled language model, capable of understanding and processing diverse topics. Your task is to analyze the YouTube transcript and identify the following elements:

Topics: Extract and list the main subjects or themes discussed in the transcript.
Outline: After carefully reading the transcript Create a coherent outline of the content, organizing the transcript into sections or key points of every topic brought into the video, under the key points in double quotes provide the exact quote from the transcript about the outline topic.
Summary: Craft a concise summary of the key takeaways or highlights from each section of the outline.
Use explicit, simple, and literal language to ensure clarity in the generated response. Assume the role of an expert in the subject matter covered in the YouTube video. Your writing style should be formal, professional, and informative.

Please keep in mind the following guidelines while generating the response:

Act as an expert in the subject matter.
Structure the outline in a logical and coherent manner.
Provide step-by-step instructions for organizing the content.
Generate the response in English language only.
Continue the generation after every 400 words, checking in with the user for further instructions.
Additionally, since the generated response will be based on a YouTube transcript, it is essential to make sure that any content generated adheres to copyright and fair use policies. Please ensure that the generated content does not infringe upon any copyright laws, and make sure to avoid as much as possible any plagiarism.
The output should definitely be in markdown code

the transcript is the following:"""
