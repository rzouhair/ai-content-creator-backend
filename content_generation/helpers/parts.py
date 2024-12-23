import os
from content_generation.helpers.improval_prompts import generate_image, process_text_through_humanize, split_paragraph
from content_generation.helpers.post_prompts import get_memory_context, listicle_outline_prompt
from . import prompts
import requests
from .post_prompts import articleLengthMap, beginner_guide_outline_prompt, determine_best_paragraph_format, expanded_definition_outline_prompt, fill_in_image_prompt_placeholders, generate_heading_paragraph, generate_paragraph_image, generate_post_featured_image, get_linked_paragraph, how_to_guide_outline_prompt 

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
  required = (['children'] if data['includeH3'] else [])

  topic = data['targetKeyword']

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
                "is_part_of_topic": {
                  "type": "boolean",
                  "description": "Whether the section is part of the topic or not",
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
              "required": ["type", "name", 'is_part_of_topic', *required],
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
  prompt = {
    "listicle": listicle_outline_prompt,
    "how_to_guide": how_to_guide_outline_prompt,
    "expanded_definition": expanded_definition_outline_prompt,
    "beginner_guide": beginner_guide_outline_prompt,
  }[data['articleType']](data)
  final_prompt_template = f"""
  For this title: {data['title']}
  Generate in the background the LSI keywords and entities relevant to the topic, and use them following the instructions below to generate an outline based on these keywords for the optimal SEO optimisation and Topical authority:
  {prompt}
  """
  chat_resp = prompts.chat_scaffold([
    { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
    {"role": "user", "content": final_prompt_template }
  ], function_call=titles_function)
  return chat_resp


def generateSection(data):
  section_num = data['sectionNum']
  section_index = section_num - 1
  section = data['outline'][section_index]

  generate_images = data.get('generateImages', False)
  include_h3 = data.get('includeH3', False)

  memory = data.get('memory_id', None)
  context = None
  if memory:
    context = get_memory_context(memory, f"Target keyword: {data['targetKeyword']} - Title: {data['title']} - Heading: {section['name']}")

  format_function = [
    {
      "name": "get_paragraph_format",
      "description": "Get the Best Paragraph Format for the heading",
      "parameters": {
        "type": "object",
        "properties": {
          "format": {
            "type": "string",
            "description": "The heading's Recommended format",
          },
          "suggestions": {
            "type": "string",
            "description": "The suggestions for the heading's Recommended format",
          },
          "explanation": {
            "type": "string",
            "description": "The explanation for the heading's Recommended format",
          }
        },
        "required": ["format", "suggestions", "explanation"],
        "additionalProperties": False,
      },
    }
  ];

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

  format = prompts.chat_scaffold([
    { "role": "user", "content": determine_best_paragraph_format(data.get('title'), section.get('name')) },
  ], format_function)

  resp = prompts.chat_scaffold([
    { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
    { "role": "user", "content": f"""
{generate_heading_paragraph(section, 'h2', data)}

Recommended Paragraph Format:
  {format['content']['format']}
Explanation:
  {format['content']['explanation']}
Suggestions:
  {format['content']['suggestions']}
""" }
  ], titles_function)

  if (data['improveReadability']):
    resp = process_text_through_humanize(resp['content']['paragraph'])

  output['h2'] = {
    'heading': section['name'],
    'paragraph': resp['output']
  }
 
  if (generate_images and section.get('is_part_of_topic', False)):
    image_resp_prompt = fill_in_image_prompt_placeholders(output['h2'], data)
    image_resp = prompts.chat_scaffold([
      { "role": "user", "content": image_resp_prompt }
    ], [
      {
        "name": "generate_image",
        "description": "Generate an image prompt by filling in the placeholders",
        "parameters": {
          "type": "object",
          "properties": {
            "image_prompt": {
              "type": "string",
              "description": "The complete image prompt",
            },
          },
          "required": ["image_prompt"],
          "additionalProperties": False,
        },
      }
    ])

    prompt = image_resp['content']['image_prompt']

    if (generate_images):
      images = generate_image(prompt, number_of_images=4)

    output['h2'] = {
      'heading': section['name'],
      'paragraph': resp['output'],
      'prompt': prompt,
      'images': images
    }

    print('Prompt here')
    print(prompt)

  if (data.get('getLinkedParagraph', False)):
    linked_prompt = get_linked_paragraph(output['h2']['paragraph'])

    linked = prompts.chat_scaffold([
      { "role": "user", "content": linked_prompt }
    ], [
      {
        "name": "get_linked_paragraph",
        "description": "Get the generated linked paragraph",
        "parameters": {
          "type": "object",
          "properties": {
            "linked_paragraph": {
              "type": "string",
              "description": "The generated paragraph with potential anchor links opportunities",
            },
          },
          "required": ["linked_paragraph"],
          "additionalProperties": False,
        },
      }
    ])

    linked_paragraph = linked['content']['linked_paragraph']

    split_linked_prompt = split_paragraph(linked_paragraph)
    print(split_linked_prompt)
    split_linked_paragraph = prompts.chat_scaffold([
      { "role": "user", "content": split_linked_prompt }
    ], [
      {
        "name": "get_linked_paragraph",
        "description": "Get the generated linked paragraph",
        "parameters": {
          "type": "object",
          "properties": {
            "linked_paragraph": {
              "type": "string",
              "description": "The generated paragraph with potential anchor links opportunities",
            },
          },
          "required": ["linked_paragraph"],
          "additionalProperties": False,
        },
      }
    ])

    print(split_linked_paragraph)

    try:
      output['h2']['paragraph'] = split_linked_paragraph['content']['linked_paragraph']
    except:
      output['h2']['paragraph'] = split_linked_paragraph['content']

  if (section.get('children', None) and len(section.get('children', [])) and include_h3):
    output['h3'] = []
    for child in section['children']:
      format = prompts.chat_scaffold([
        { "role": "user", "content": determine_best_paragraph_format(data.get('title'), section.get('name')) },
      ], format_function)

      resp = prompts.chat_scaffold([
        { "role": "system", "content": f"Here is some background data: \n {context}" if context else "" },
        { "role": "user", "content": f"""
{generate_heading_paragraph(child, 'h3', data)}

Recommended Paragraph Format:
  {format['content']['format']}
Explanation:
  {format['content']['explanation']}
Suggestions:
  {format['content']['suggestions']}
""" }
      ], titles_function)

      if (data['improveReadability']):
        resp = process_text_through_humanize(resp['content']['paragraph'])

      split_linked_prompt = split_paragraph(resp['output'])
      print(split_linked_prompt)
      split_paragraph_resp = prompts.chat_scaffold([
        { "role": "user", "content": split_linked_prompt }
      ], [
        {
          "name": "get_linked_paragraph",
          "description": "Get the split paragraph",
          "parameters": {
            "type": "object",
            "properties": {
              "linked_paragraph": {
                "type": "string",
                "description": "The split paragraph output",
              },
            },
            "required": ["split_paragraph"],
            "additionalProperties": False,
          },
        }
      ])

      output['h3'].append({
        'paragraph': split_paragraph_resp['content']['split_paragraph'],
        'heading': child['name']
      })

  return output
      

def generateImage (prompt, options = {
  "model": 'V_2',
  "aspect_ratio": 'ASPECT_16_9',
  "magic_prompt_option": 'OFF'
}):
  url = "https://api.ideogram.ai/generate"

  apiKey = os.getenv('IDEOGRAM_API_KEY')

  payload = { "image_request": {
          "prompt": prompt,
          "aspect_ratio": options.get('aspect_ratio', 'ASPECT_16_9'),
          "model": options.get('model', 'V_2'),
          "magic_prompt_option": options.get('magic_prompt_option', 'OFF')
      } }
  headers = {
      "Api-Key": apiKey,
      "Content-Type": "application/json"
  }

  response = requests.post(url, json=payload, headers=headers)

  return response.json()