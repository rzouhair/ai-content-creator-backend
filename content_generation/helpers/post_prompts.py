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

def generate_heading_paragraph(heading, headingType, data):
  language = data['language']
  topic = data['targetKeyword']
  article_type = data['articleType']
  tone_of_voice = data['toneOfVoice']
  target_country = data['country']
  section_index = data['sectionNum'] - 1
  h2_heading = data['sections'][section_index]['name']

  improve_readability = data['improveReadability']

  title = data['title']

  prompt = {
    'h2': f"""Please generate a comprehensive and informative paragraph for the following H2 heading: **{heading}**. The paragraph should:
- Provide a clear overview of the topic.
- Explain the key concepts or points related to this heading.
- Never exceed 4 concise sentences in the whole paragraph, for each 2 sentences break the line""", 

    'h3': f"""Please generate a detailed and focused paragraph for the following H3 subheading: **{heading}**. The paragraph should:
- Elaborate on how it connects to the broader H2 heading.
- Maintain consistency with the overall tone and purpose of the blog post.
- Never exceed 4 concise sentences in the whole paragraph, for each 2 sentences break the line""", 
  }

  return f"""{prompt[headingType]}

**Context**
{h2_heading if headingType == 'h3' else ''}
- The current heading is "{heading}"

- The blog post title is "{title}"
- The topic is {topic}
- The article type is {article_type}
- target country is {target_country}
- Please write a paragraph of exactly 100 words on the following topic: **{heading}**. The content should be concise, focused, and adhere strictly to the word limit.

- Use the following tone of voice {tone_of_voice}, {toneOfVoicePromptMap[tone_of_voice]}

Here is the blog post title which you need to create an outline for: {title}
Please answer only in {language} and do not include any other text.
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
Generate an SEO-optimized outline for a blog post with the following details:

Target Keyword: "{topic}"
Blog Post Title: "{title}"
Number of Sections: "{article_length}"

Create an outline that:
1. Includes an introduction and conclusion
2. Features {article_length} main sections with relevant subheadings
3. Incorporates the target keyword naturally throughout the outline
4. Covers related subtopics to establish topical authority
5. The outline should not include H3 tags at all

also:
- do not include h3 tags, H2s should be covering the topic
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

Ensure the outline is comprehensive, logically structured, and designed to rank well for the target keyword while providing value to the reader.

Other information:
- The topic is {topic}
- The article type is {article_type}
- target country is {target_country}
- The outline should be in a valid JSON format, with no confirmation of strings, only a JSON array.
- Each section should have a name, a type (introduction, normal, faq), and a list of children (subheadings or entities) if applicable, empty if not.
- The outline should include relevant and informative content that directly answers the prompt.

- Use the following tone of voice {tone_of_voice}, {toneOfVoicePromptMap[tone_of_voice]}
"""

def listicle_outline_prompt (data):
  title = data['title']

  footer = get_outline_prompt_footer(data)

  return f"""
Create an outline for a Step-by-Step blog post titled '{title}'. Ensure the outline includes the following components:
- An engaging introduction using the PSP method, highlighting the problem, proposed solution, and proof of effectiveness.
- A series of main steps listed as H2 headings, each representing a specific stage in the process.
- Conclude with a summary of key takeaways and suggestions for internal links to related articles.

The topic should be relevant to an audience of beginners who are seeking easy-to-follow guidance on the chosen subject.

By following this prompt, you can create a structured outline that serves as a roadmap for drafting a comprehensive and reader-friendly Step-by-Step post.

{footer}
"""

def beginner_guide_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)

  return f"""
Create an outline for a Beginner's guide blog post titled '{title}' involves developing a comprehensive educational resource aimed at absolute beginners who are looking to understand a specific topic. The goal is to present information in a clear, logical sequence, using simple language to ensure that readers feel capable of learning and applying that information. 

The topic should be relevant to an audience of beginners who are seeking easy-to-follow guidance on the chosen subject.
- Divide the main topics into H2 (Headings 2) and H3 (Headings 3) sections that guide the reader through a sequence of steps or subtopics.
   - Use H2 headings as major steps or topics that cover broad aspects of the subject matter.

{footer}
"""

def how_to_guide_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)

  return f"""
"Generate an outline for a 'how-to' blog post focusing on "{title}". The outline should include the following sections:
1. A compelling title that communicates the main action and appeals to the audience.
2. An engaging introduction that identifies the problem, presents the solution, and includes proof of efficacy.
3. A main content structure consisting of sequential H2 headings reflecting each step of the process, followed by detailed instructions for each step.
4. A concise conclusion that summarizes the key points and encourages further reading through internal links."
5. do not include any H3 tags

**Main Content Structure:**
  - **List the Steps:** Use H2 headings for each major step in the process. Number them sequentially to create a logical flow for readers.
  - **Detailed Instructions:** Under each H2, provide clear and detailed instructions that guide the reader through the step. Bullet points or numbered lists can be helpful.

By following this optimized prompt, the outline generated will not only cover necessary components for a successful "how-to" post but will also engage and inform the target audience effectively.

{footer}
"""

def expanded_definition_outline_prompt (data):
  title = data['title']
  footer = get_outline_prompt_footer(data)

  return f"""
"Generate an outline for an expanded definition blog post titled "{title}". The outline should include the following sections:
1. Research the topic using Google's "People also ask" box for common questions.
2. Utilize Keywords Explorers to identify related terms and categorize subtopics.
3. Organize the main content with H2 headings for significant sections (e.g., "How it Works," "Applications," "Key Differences").
4. do not include H3 tags
5. Provide detailed explanations, examples, and engaging visuals where applicable.
6. Ensure logical flow and transition between sections.

**Main Content Structure:**
  - **List the Steps:** Use H2 headings for each major step in the process. Number them sequentially to create a logical flow for readers.
  - **Detailed Instructions:** Under each H2, provide clear and detailed instructions that guide the reader through the step. Bullet points or numbered lists can be helpful.

{footer}
"""

