from core.clients import nearest_neighbor_search, retrieve_documents


articleLengthMap = {
  'default': 'Default',
  'custom': 'Custom Number of Sections',
  'shorter': 'Shorter (2-3 Sections, 450-900 Words)',
  'short': 'Short (3-5 Sections, 950-1350 Words)',
  'medium': 'Medium (5-7 Sections, 1350-1870 Words)',
  'long': 'Long Form (7-10 Sections, 1900-2440 Words)',
  'longer': 'Longer (10-12 Sections, 2350-2940 Words)'
}

pointOfViewMap = {
  'first_person_singular': 'first person Singular (I, me, my, mine)',
  'first_person_plural': 'first person Plural (we, us, our, ours)',
  'second_person': 'second person (you, your, yours)',
  'third_person': 'third person (he, she, it, they)'
}

toneOfVoicePromptMap = {
  'seo_optimized':
    'Maintain a tone that is confident, knowledgeable, neutral, and clear. Focus on incorporating relevant keywords naturally for better SEO performance.',
  'excited':
    'Use lively and energetic language to engage the reader with an exciting narrative. Convey enthusiasm and passion about the topic.',
  'professional':
    'Use formal and precise language. Present information in a clear, authoritative manner, suitable for a professional or expert audience.',
  'friendly':
    'Adopt a warm and approachable tone, using conversational language to make the content relatable and easy to understand.',
  'formal':
    'Maintain a tone that is formal and respectful, using polished and sophisticated language appropriate for serious or official topics.',
  'casual':
    'Use a relaxed and informal tone, making the content feel more like a friendly conversation, with simple and approachable language.',
  'humorous':
    'Incorporate humor and playful language to make the content entertaining and engaging, while still conveying the main points effectively.',
  'custom':
    'Use the following custom tone: [Insert Custom Tone Here]. Ensure that the content matches the specific style and mood described.'
};


def determine_best_paragraph_format(title, heading):

  return f"""
# Heading Format Optimizer

Task: Analyze the given heading and determine the most appropriate format for presenting the content beneath it in a blog post or article.

Input:
1. Heading text
2. Brief description of the intended content (if available)
3. Target audience (if known)
4. Overall tone of the blog post (e.g., informative, casual, professional)

Instructions:
1. Analyze the heading and any additional information provided.
2. Consider the following formats and their use cases:
   - Simple Text: For general explanations, narratives, or when other formats don't clearly apply
   - List (Bulleted or Numbered): For series of items, steps, or points that don't require extensive elaboration
   - Quote: For direct quotations from sources or to highlight a key statement
   - Callout: For important information, key takeaways, or tips that should stand out
   - Code Block: For technical content, code snippets, or command-line instructions
   - Table: For comparative data, structured lists, or when organizing information into rows and columns for clarity
3. Evaluate the heading based on these criteria:
   - Content type: Is it descriptive, instructional, comparative, or highlighting key points?
   - Structure: Does it imply a series of items, steps, or points?
   - Purpose: Is it meant to explain, inform, compare, or emphasize?
   - Technicality: Does it suggest code or technical information?
4. Determine the most suitable format based on your analysis.
5. Consider the target audience and overall tone in your decision.

Output:
1. The recommended format for the content under the given heading
2. A brief explanation of why this format is most suitable
3. Any suggestions for enhancing the presentation (e.g., adding subheadings, using bold for key terms)

Example 1:
Input Heading: "5 Essential Steps to Launch Your Online Business"
Brief description: A guide for entrepreneurs starting their first e-commerce venture
Target audience: Aspiring online business owners
Overall tone: Informative and encouraging

Output:
1. Recommended format: Numbered List
2. Explanation: The heading clearly indicates a series of steps, which is best presented as a numbered list. This format will allow readers to easily follow the process in a logical order.
3. Suggestions: 
   - Use bold text for each step's main action
   - Consider adding a brief introduction before the list to set context
   - Include a callout box after the list for additional tips or resources

---
Blog post title: {title}
Heading: "{heading}"
"""

def generate_heading_paragraph(section, headingType, data):
  heading = section['name']
  language = data['language']
  topic = data['targetKeyword']
  article_type = data['articleType']
  tone_of_voice = data['toneOfVoice']
  pointOfView = data['pointOfView']
  section_index = data['sectionNum'] - 1
  h2_heading = data['sections'][section_index]['name']

  title = data['title']
  
  limitPrompt = '5. (Important) This is a h2 paragraph with more details on h3, consider this just an intro to further details' if headingType == 'h2' and section.get('children', None) and len(section.get('children', [])) > 0 else ''


  return f"""
# Human-like SEO-Optimized Paragraph Generator

Task: Generate a natural, SEO-optimized paragraph that reads as if written by a human, avoiding common AI writing patterns.

Inputs:
1. Point of view (e.g., first person, second person, third person)
2. Article type (e.g., how-to guide, opinion piece, news article, product review)
3. Tone of voice (e.g., casual, professional, humorous, empathetic)
4. Blog post title
5. Current heading
6. Target keyword(s)
7. Word count range (e.g., 100-150 words)

Instructions:

1. Analyze the inputs to understand the context and requirements.

2. Begin with a creative ideation phase:
   - Brainstorm unique angles or perspectives on the topic
   - Think of unconventional examples or analogies related to the subject
   - Consider personal anecdotes or hypothetical scenarios that illustrate the point

3. Craft the paragraph using these humanizing techniques:
   - Vary sentence structure (mix short and long sentences)
   - Use contractions, colloquialisms, and idiomatic expressions appropriately
   - Incorporate rhetorical questions or conversational asides
   - Add personal opinions or experiences if suitable for the point of view
   - Include mild imperfections like parenthetical thoughts or self-corrections

4. Integrate SEO elements naturally:
   - Use the target keyword(s) organically, avoiding forced placement
   - Include related terms and synonyms
   - Ensure the content directly addresses the heading and fits the overall post title

5. Enhance readability and engagement:
   - Use transition words sparingly and vary them
   - Include specific examples, data points, or expert opinions when relevant
   - Create mental images through descriptive language

6. Review and refine:
   - Ensure the paragraph aligns with the specified point of view, article type, and tone
   - Check that the content flows naturally and doesn't follow a predictable pattern
   - Verify that the paragraph stays within the specified word count range

Output:
1. The generated SEO-optimized, human-like paragraph
2. A brief explanation of the creative choices made to avoid AI detection



Input:
{f'Point of view: {pointOfViewMap[pointOfView]}' if pointOfView else ''}
- Article type: {article_type}
- Tone of voice: {tone_of_voice}, {toneOfVoicePromptMap[tone_of_voice]}
- Blog post title: "{title}"
- Current heading: "{heading}"
- Target keyword: "{topic}"
- Word count range: {limitPrompt}
- Language: {language}
"""

def generate_post_featured_image(title):

  return f"""
# Blog Featured Image Prompt Generator

You are an AI assistant specialized in creating prompts for featured images of blog posts. Your task is to analyze a given blog post title and generate a prompt for an eye-catching, relevant featured image that will attract readers and convey the essence of the post.

Input:
Blog Post Title: {title}

Your task:
1. Carefully analyze the given blog post title.
2. Identify the main topic, key themes, and any specific elements mentioned.
3. Consider the likely target audience and the tone of the blog post based on the title.
4. Think about visual metaphors or symbols that could represent the main ideas.
5. Determine an appropriate style and color scheme that would appeal to the target audience and reflect the post's content.

Then, generate an image prompt using the following structure:

"Create a striking featured image for a blog post titled '[Blog Post Title]'. The image should feature [main visual element] as the focal point, set against a [background description] that suggests [theme or context]. Incorporate [secondary elements or symbols] to reinforce the key ideas of [main topics from title]. Use a [color scheme] palette to evoke [emotion or tone]. The style should be [appropriate style based on likely content and audience, e.g., minimalist, illustrated, photorealistic, etc.], designed to catch the eye and intrigue potential readers. Ensure the image has space for text overlay without obscuring key visual elements. do not put text in the image."

Additional considerations for your prompt:
- Make the image versatile enough to work well in various sizes (e.g., social media thumbnails, website headers)
- Suggest a composition that's visually balanced and leads the eye
- Avoid overly literal interpretations; aim for a blend of concrete and abstract elements
- Ensure the image will be instantly recognizable and relevant to the blog post topic
- Consider current design trends in blog featured images, if applicable

Remember, your goal is to create a prompt that will result in a featured image that not only represents the blog post's content but also entices readers to click and read more.
"""

def generate_paragraph_image(section, data):
  heading = section['heading']
  paragraph = section['paragraph']
  title = data['title']

  return f"""
# Image Prompt Generator

You are an AI assistant specialized in analyzing text and generating prompts for image creation. Your task is to take a given heading and paragraph, extract the key themes and visual elements, and create a detailed prompt for image generation that captures the essence of the content.

Input:
Blog title: {title}
Heading: {heading}
Paragraph: {paragraph}

Your task:
1. Carefully read and analyze the provided heading and paragraph.
2. Identify the main topic, key themes, and important concepts.
3. Determine the tone and emotion conveyed by the text.
4. Identify any specific visual elements mentioned or implied.
5. Consider symbolic representations for abstract concepts if necessary.

Then, generate an image prompt to be used in Generative AI image generation models, the prompt shouldn't contain too much details that could distract the model from generating a meaningful image. The prompt should be concise and to the point, focusing on the main topic and visual elements.

Ensure that your generated prompt:
- Accurately reflects the content and intent of the original heading and paragraph
- Is detailed enough to guide the creation of a relevant and meaningful image
- Balances literal and symbolic elements as appropriate to the topic
- Specifies a style and color scheme that enhances the message

Remember, your goal is to create a prompt that will result in an image that effectively communicates the essence of the given text at a glance.
"""

def get_memory_context (memory_id, context):
  filters = {
    'q': '*',
    'query_by': '*',
    'filter_by': f"parent_id:={str(memory_id)}",
    "per_page": 10,
    "page": 1
  }

  neighbors_res = nearest_neighbor_search(
    'memories',
    context,
    15,
    filters,
    0.5
  )
  print([d['document'] for d in neighbors_res['hits']])
  bg_data = retrieve_documents('memories', filters)
  bg_data = '\n'.join([t['text'] for t in bg_data])

  return bg_data

def get_outline_prompt_footer (data):
  language = data['language']
  topic = data['targetKeyword']
  article_type = data['articleType']
  article_length = articleLengthMap[data['articleLength']]
  tone_of_voice = data['toneOfVoice']
  target_country = data['country']

  title = data['title']

  return f"""

The output should be a markdown table, with the following columns:
  - Heading
  - Is part of the topic: Yes/No, this should be 'No' if the heading is an introduction, key takeaways, faqs, common mistakes, conclusion, or similar sections
  - Children if needed for h3 headings

Language: {language}
Topic: {topic}
Article Type: {article_type}
Article Length: {article_length}
Tone of Voice: {tone_of_voice}
Target Country: {target_country}
Title: {title}

General guidelines for all outline types:

- Ensure the outline is comprehensive and covers the topic thoroughly
- Adapt the depth and breadth of the outline to fit the specified article length
- Use language and examples appropriate for the target country
- Maintain the specified tone of voice throughout the outline
- Include placeholders for relevant statistics, quotes, or expert opinions where appropriate
- Add a section for the conclusion that ties back to the main topic and provides value to the reader
- Ensure the outline is concise and optimized for SEO for the provided topic
- Ensure the outline is well-structured and follows a logical flow and keeps the reader engaged
- Use the following tone of voice {tone_of_voice}, {toneOfVoicePromptMap[tone_of_voice]}

Please generate the outline now, following the structure and guidelines for the specified article type.
"""

def listicle_outline_prompt (data):
  title = data['title']
  article_length = articleLengthMap[data['articleLength']]
  include_h3 = data.get('includeH3', False)

  footer = get_outline_prompt_footer(data)

  return f"""
Generate a detailed outline for a blog post with the following specifications:

Create an outline for a Step-by-Step blog post titled '{title}'. Ensure the outline includes the following components:

- Add a conclusion section summarizing the list's value
- An engaging introduction using the PSP method, highlighting the problem, proposed solution, and proof of effectiveness.
- A series of main steps listed as H2 headings, each representing a specific stage in the process.
- Conclude with a summary of key takeaways and suggestions for internal links to related articles.
- Create an outline for a list-based article
- Include an introduction section explaining the list's relevance
- List {article_length}
{'- For each main point, include subpoints or a brief description' if include_h3 else ''}

The topic should be relevant to an audience of beginners who are seeking easy-to-follow guidance on the chosen subject.

By following this prompt, you can create a structured outline that serves as a roadmap for drafting a comprehensive and reader-friendly Step-by-Step post.

{footer}
"""

def beginner_guide_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)

  return f"""
Generate a detailed outline for a blog post with the following specifications:

Create an outline for a Beginner's guide blog post titled '{title}' involves developing a comprehensive educational resource aimed at absolute beginners who are looking to understand a specific topic. The goal is to present information in a clear, logical sequence, using simple language to ensure that readers feel capable of learning and applying that information. 

- Begin with an introduction explaining why the topic is important for beginners
- Include a section defining key terms and concepts
- Structure the main content as progressive levels of understanding (e.g., "The Basics", "Intermediate Concepts", "Advanced Topics")
- Include practical examples or exercises for each level
- Add a section on common beginner mistakes and how to avoid them
- Conclude with next steps or resources for further learning

{footer}
"""

def how_to_guide_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)
  article_length = articleLengthMap[data['articleLength']]
  include_h3 = data.get('includeH3', False)

  return f"""
Generate a detailed outline for a blog post with the following specifications:
Generate an outline for a 'how-to' blog post focusing on "{title}". The outline should include the following sections:

- Structure the outline as a step-by-step guide
- Begin with an introduction explaining the guide's purpose
- List {article_length}
{'- Under each step, include substeps or important details' if include_h3 else 'Do not include substeps or h3 headings'}
- Include a section on common mistakes or tips
- End with a conclusion summarizing the benefits of following the guide

By following this optimized prompt, the outline generated will not only cover necessary components for a successful "how-to" post but will also engage and inform the target audience effectively.

{footer}
"""

def expanded_definition_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)

  return f"""
Generate a detailed outline for an expanded definition blog post titled "{title}" with the following specifications:

- Research the topic using Google's "People also ask" box for common questions.
- Start with a section defining the main term or concept
- Include sections on the history or origin of the term
- Add sections explaining different aspects or applications of the concept
- Include examples or case studies to illustrate the definition
- End with a section on the term's relevance or importance today
- Organize the main content with H2 headings for significant sections (e.g., "How it Works," "Applications," "Key Differences").
- Ensure logical flow and transition between sections.

{footer}
"""

def get_linked_paragraph(text):
  return f"""
You are an AI assistant specialized in identifying potential link opportunities in text and transforming them into markdown format. Your task is to take a given paragraph and return a modified version with the following changes:

1. Identify important concepts, terms, or phrases that could benefit from either internal or external links.
2. Transform these identified elements into markdown anchor tags.
3. Use a placeholder URL structure for each link:
   - For potential internal links: `[term](#internal-term)`
   - For potential external links: `[term](https://example.com/term)`

## Input
A paragraph of plain text.

## Output
A markdown-formatted paragraph with potential link opportunities transformed into anchor tags.

## Rules
1. Maintain the original paragraph structure and flow.
2. Only link to significant terms or concepts that would genuinely benefit from additional context or information.
3. Don't over-link; aim for a balance that enhances readability without cluttering the text.
4. Use your judgment to determine whether a link should be internal or external based on the context and nature of the term.
5. Ensure that the transformed paragraph remains coherent and readable.

Please process the given paragraph according to these instructions.

The input paragraph is:
{text}
"""
