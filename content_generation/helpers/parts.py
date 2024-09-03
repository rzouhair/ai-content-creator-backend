from content_generation.helpers.improval_prompts import improve_readability
from content_generation.helpers.post_prompts import get_memory_context, listicle_outline_prompt
from . import prompts
import json
from .post_prompts import articleLengthMap, beginner_guide_outline_prompt, expanded_definition_outline_prompt, generate_heading_paragraph, how_to_guide_outline_prompt 

def generateTitlePart(data):
  language = data['language']
  topic = data['targetKeyword']
  article_type = data['articleType']
  article_length = articleLengthMap[data['articleLength']]

  titles_function = [
    {
      "name": "get_generated_title",
      "description": "Get the generated title from the prompt",
      "parameters": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "The blog post title",
          },
        },
        "required": ["title"],
        "additionalProperties": False,
      },
    }
  ];

  titles_templates = {
    "listicle": """
XX Ways to [Desired Outcome]
XX [Topic] Tips [Benefit or Desire]
XX [Type] Tools [Benefit or Desire]
XX Reasons Why [Problem]
XX [Topic] Techniques [Benefit or Desire]
XX [Products] For [Audience]

Where XX is a number and the other words in brackets are placeholders.
""",
    "how_to_guide": """- For (How to guides): 
How to [Achieve Desired Outcome] (XX Steps)
How to [Achieve Desired Outcome] (Even If [Common Obstruction]]
How to [Achieve Desired Outcome] ([Additional Benefit]]""",

    "expanded_definition": """- For (Expanded definitions posts):
What is/are [Concept]? Everything You Need to Know
What is/are [Acronym]? [Expanded Acronym] Explained
What is/are [Concept]? A [Brief/Quick/Detailed] Introduction""",

    "beginner_guide": """- For (Beginner's guides posts):
[Topic] For Beginners: [Desire]
The Beginner's Guide to [Topic]
The Noob-Friendly Guide to [Topic]"""
  }

  chat_resp = prompts.chat_scaffold([
    { "role": "system", "content": "You are a blog post title generator, you help the user create catchy, relevant titles that can improve click-through rates and enhance website rankings. When generating your response, please focus solely on providing relevant and informative content that directly answers the prompt. Please refrain from using affirmative language or providing irrelevant information that does not directly address the prompt." },
    {"role": "user", "content": f"""I want you to respond only in language {language}.  
I want you to act as a blog post title writer that speaks and writes fluent {language}. 
I will type a title, or keywords via comma and you will reply with a list of blog post titles in {language} based on the chosen post type. 
They should all have a hook and high potential to go viral on social media.

Choose a the best title suited for the chosen topic out of the following titles:
{titles_templates[article_type]}
XX should align with the article sections count: {article_length} and be converted to a respective number of sections / tips / list items.

You must write all in {language}. my first keywords are {topic} and the chosen list post is {article_type}
  """ },
  ], titles_function)

  return chat_resp

def generateOutline(data):
  titles_function = [
    {
      "name": "get_outline",
      "description": "Get the generated outline as a JSON array from the prompt",
      "parameters": {
        "type": "object",
        "properties": {
          "outline": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "type": {
                  "type": "string",
                  "enum": ['introduction', 'normal', 'faq'],
                  "description": "The type of the generated outline",
                },
                "name": {
                  "type": "string",
                  "description": "The name of the section",
                },
                "children": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "type": {
                        "type": "string",
                        "enum": ['normal'],
                        "description": "The type of the child item which should only be 'normal'",
                      },
                      "name": {
                        "type": "string",
                        "description": "the subheading or entity content / name",
                      },
                    }
                  },
                  "required": ["type", "name"],
                }
              },
              "required": ["type", "name"],
              "additionalProperties": False,
            }
          }
        },
        "required": ["outline"],
        "additionalProperties": False,
      },
    }
  ];

  memory = data.get('memory_id', None)
  context = None
  if memory:
    context = get_memory_context(memory, f"Target keyword: {data['targetKeyword']} - Title: {data['title']}")

  chat_resp = prompts.chat_scaffold([
    { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
    {"role": "user", "content": {
      "listicle": listicle_outline_prompt,
      "how_to_guide": how_to_guide_outline_prompt,
      "expanded_definition": expanded_definition_outline_prompt,
      "beginner_guide": beginner_guide_outline_prompt,
    }[data['articleType']](data) }
  ], function_call=titles_function)
  return chat_resp


def generateSection(data):
  section_num = data['sectionNum']
  section_index = section_num - 1
  section = data['sections'][section_index]

  memory = data.get('memory_id', None)
  context = None
  if memory:
    context = get_memory_context(memory, f"Target keyword: {data['targetKeyword']} - Title: {data['title']} - Heading: {section['name']}")

  titles_function = [
    {
      "name": "get_paragraph",
      "description": "Get the generated paragraph for the heading",
      "parameters": {
        "type": "object",
        "properties": {
          "paragraph": {
            "type": "string",
            "description": "The current heading's paragraph",
          },
        },
        "required": ["paragraph"],
        "additionalProperties": False,
      },
    }
  ];

  output = {}

  resp = prompts.chat_scaffold([
    { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
    { "role": "user", "content": generate_heading_paragraph(section['name'], 'h2', data) }
  ], titles_function)

  if (data['improveReadability']):
    resp = prompts.chat_scaffold([
      { "role": "user", "content": improve_readability(resp['content']['paragraph']) }
    ])

  output['h2'] = {
    'heading': section['name'],
    'paragraph': resp['content']
  }

  if (len(section['children'])):
    output['h3'] = []
    for child in section['children']:
      resp = prompts.chat_scaffold([
        { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
        { "role": "user", "content": generate_heading_paragraph(child['name'], 'h3', data) }
      ], titles_function)

      if (data['improveReadability']):
        resp = prompts.chat_scaffold([
          { "role": "user", "content": improve_readability(resp['content']['paragraph']) }
        ])

      output['h3'].append({
        'paragraph': resp['content'],
        'heading': child['name']
      })

  return output
      