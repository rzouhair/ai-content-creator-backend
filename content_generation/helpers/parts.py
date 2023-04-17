from . import prompts
import json

def generateTitlePart(topic, num_titles = 1):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": prompts.meta_title_system_prompt },
    {"role": "user", "content": f"""
    Prompt: Generate a specified number of SEO optimized titles for the target keyword "{topic}' sexe", using the following criteria: Relevant keywords (including the target keyword), short and concise title (maximum 59 characters), descriptive language, unique value proposition, and appropriate use of title tags. Ensure the titles engage the reader, avoid generic phrases, and seamlessly integrate the target keywords. Use descriptive language to communicate the main idea of the article succinctly, while offering a unique value proposition that sets your content apart from others. Format your titles with title tags to make them easy to locate while enhancing readability. Here's an example title based on the target keyword "can cockatiels sleep with noise":

"Noise and Sleep: Understanding Your Cockatiel's Rest Patterns" (58 characters)

Generate {num_titles} SEO optimized titles that comply with the above criteria, and format them into a valid plain JSON array of strings.
    """}
  ])

  return chat_resp


def generateTeeUp(title, target_keyword = None, num_outputs = 1):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": "Act as a professional SEO content writer, I provide you the main blog post title and some criteria, and you generate a Tee-up section that follows the given critera, the main conditons are, write in 8th or 9th grade reading level with high readability score, include the target keyword in the first section, and make it natural and helpful." },
    {"role": "user", "content": f"""
      Title: {title}
      Target keyword: {target_keyword or title}
      Prompt: Generate {num_outputs} introductory section for a blog post around the main topic "{target_keyword or title}" with the title "{title}" that fulfills the following criteria:

      - Clearly identifies the topic of the post
      - Establishes a rapport with the reader and instills confidence in your ability to provide helpful information
      - Avoids mentioning other topics excessively to avoid triggering Google's spam filters
      - Contains a human touch that is free from plagiarism
      - Is 2-3 sentences in length.

      Make sure you return a valid JSON array of strings containing the number of desired sections with no fluff or jargon.
    """}
  ])
  return chat_resp



def generateOutline(title):
  chat_resp = prompts.chat_scaffold([
    {"role": "system", "content": prompts.outline_system_prompt },
    {"role": "user", "content": f"Prompt: Generate an SEO-optimized outline for a blog post with the title \"{title}\" that includes a catchy introduction, sections with H2 subheadings, and relevant keywords. If any H2 subheading is too broad to fit under one subheading, add H3 headings. always start with an Introduction heading and end with a conclusion, both should not have any h3." \

"Generate ONLY ONLY the subheadings in a plain JSON array of objects, each object should contain the h2 headings that is related to the title in the field \"h2\" and if there are h3 headings add them to the object in the field \"h3\" which is an array of strings\nNote: Please provide only a plain JSON array not an object, Please provide relevant and informative content that directly answers the prompt. Do not use affirmative language or provide irrelevant information that doesn't address the prompt."}
  ])
  return chat_resp


def generateSection(data):
    d = {}
    section = data['section']
    title = data['title']
    targetKeyword = data['targetKeyword']

    h2_section = None
    h3_sections = []

    if (section['h2'].lower() == 'introduction'):
      chat_resp = generateTeeUp(title, target_keyword=targetKeyword, num_outputs=1)
      return {
        "heading": section['h2'],
        "paragraph": list(json.loads(str(chat_resp["content"]).replace('",', '"')))[0]
      }

    h2 = prompts.chat_scaffold([
      {"role": "system", "content": prompts.blog_section_dev },
      {"role": "user", "content": f"""
        Title: {title}
        Target keyword: {targetKeyword}
        Subheading: {section['h2']}

        Prompt: Write a blog post section that expands upon the topic presented in the title and subheading. The section should definitely answer the subheading question at the beginning of the section with no fluff and jargon. Your writing should be at an 8th or 9th grade reading level, and use short paragraphs with a line break after every 2-3 sentences. Research relevant keywords and optimize your content for SEO by including them in a natural way throughout your post. Use a descriptive heading that accurately reflects the content of your article.

        Provide enough detail to adequately address the subject matter while still keeping your language clear, natural and concisely detailed. Consider using bullet points or numbered lists to make it easier for readers to follow. Illustrate your ideas with relevant examples that add value to your readers. Avoid technical jargon and other language that might obscure the meaning of the text.

        Finally, review your work to ensure it is error-free and provides value to your readers, and return only the generated paragraph.
      """}
    ])

    h2_section = {
      "heading": section['h2'],
      "paragraph": h2['content']
    }

    if section.get('h3', None) and len(section.get('h3', None)):
      for h3 in section['h3']:
        current_h3 = prompts.chat_scaffold([
          {"role": "system", "content": prompts.blog_section_dev },
          {"role": "user", "content": f"""
        Title: {targetKeyword}
        Parent subheading: {section['h2']}
        Subheading: {h3}

        Prompt: Write a blog post section that expands upon the topic presented in the title and subheading and the parent subheading. The section should definitely answer the subheading question at the beginning of the section with no fluff and jargon. Your writing should be at an 8th or 9th grade reading level, and use short paragraphs with a line break after every 2-3 sentences. Research relevant keywords and optimize your content for SEO by including them in a natural way throughout your post. Use a descriptive heading that accurately reflects the content of your article.

        Provide enough detail to adequately address the subject matter while still keeping your language clear, natural and concisely detailed. Consider using bullet points or numbered lists to make it easier for readers to follow. Illustrate your ideas with relevant examples that add value to your readers. Avoid technical jargon and other language that might obscure the meaning of the text.

        Finally, review your work to ensure it is error-free and provides value to your readers, and return only the generated paragraph.
          """}
        ])
        h3_sections.append({
          "heading": h3,
          "paragraph": current_h3['content']
        })
      
      if len(h3_sections) > 0:
        h2_section["children"] = h3_sections
    try:
      return {
        'section': json.loads(h2_section)
      }
    except:
      return {
        'section': h2_section
      }