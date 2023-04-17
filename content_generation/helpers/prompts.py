import openai
import json

openai.api_key = "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"

def chat_scaffold(messages):
  resp = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=messages
  )

  content = resp.choices[0].message.content

  try:
    return {
      'usage': resp['usage'],
      "content": json.loads(content)
    }
  except:
    return {
      'usage': resp['usage'],
      "content": content
    }

title_system_prompt = "You are title generator, you help the user create catchy, relevant titles that can improve click-through rates and enhance website rankings, you only return a plain JSON array containing the number of titles the user requested, not an object, an array .When generating your response, please focus solely on providing relevant and informative content that directly answers the prompt. Please refrain from using affirmative language or providing irrelevant information that does not directly address the prompt."

outline_system_prompt = "As an outline generator, help the user create a well-structured outline for their blog post that is SEO optimized and engages readers, returning a plain JSON array with an optimal number of sections based on the user's desired length, and if the user doesn't provide the number of headlines to generate, generate a reasonable number of headlines based on the SERPs. .When generating your response, please focus solely on providing relevant and informative content that directly answers the prompt. Please refrain from using affirmative language or providing irrelevant information that does not directly address the prompt. Using the target keyword as an input, please generate a JSON array output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON array. Include any additional formatting or syntax required to produce a valid JSON array."

meta_title_system_prompt = 'You are a meta-title generator, you follow the most updated SEO guidelines to create the most compelling, eye-catching SEO optimized meta title to rank on top of google SERPs, I will provide a target keyword, and it will be your job to come up with a JSON array containing the number of titles desired by the user.'

meta_description_prompt = 'Objective: Generate a JSON array containing a certain number of SEO-optimized meta description for a blog post using the provided keyword, Instructions: Use the primary keyword: Include "Tips for Starting a Successful Blog" in the meta description, ensuring it reads naturally. Use action-oriented language: Use action-oriented language to encourage clicks and engagement, such as "Start your successful blog today" or "Get expert tips for a successful blog." Be descriptive: Provide a concise summary of the blog post, accurately reflecting the content, such as "Learn key strategies to successfully launch and maintain a blog in any niche." Keep it under 160 characters: To ensure proper display in search results, keep the meta description under 160 characters. Highlight benefits: Emphasize the benefits of reading the blog post, such as "Discover the essential steps needed to create a successful blog that stands out to your audience." Include a call-to-action: Encourage clicks and engagement by using a clear and straightforward call-to-action, such as "Take your blog to the next level, read our guide now!"\n Using the data provided by the user as an input, please generate a JSON array output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON array. Include any additional formatting or syntax required to produce a valid JSON array.'

blog_format_prompt = "Objective: for the title the user provides, generate a JSON object. The object should have two properties: 'format' for the format of the blog post and 'intent' for the search intent. The values associated with each property should be exclusively from the following lists: Format - [Listicle - How-to Guide - Interview - Opinion Piece - Infographics - Video Posts - Case Study and more] and Intent - [Informational - Navigational - Commercial - Transactional]. Using the data provided by the user as an input, please generate a JSON object output. Ensure that the output is in a valid JSON format and contains no confirmation of strings, only a JSON object. Include any additional formatting or syntax required to produce a valid JSON object."

blog_section_dev = """As an expert SEO content writer, you follow the most relevant SEO guidelines to write the perfect SEO optimized blog post sections. you write in 8th to 9th grade reading level, Research relevant keywords, Use short naturally sounding paragraphs, use bullet points or numbered lists whenever it is possible, Optimize your content for SEO and more...
"""
