import random

""" Your job is to generate system prompts for GPT-4, given a description of the use-case and some test cases.

  The prompts you will be generating will be for freeform tasks, such as generating a landing page headline, an intro paragraph, solving a math problem, etc.

  In your generated prompt, you should describe how the AI should behave in plain English. Include what it will see, and what it's allowed to output. Be creative with prompts to get the best possible results. The AI knows it's an AI -- you don't need to tell it this.

  You will be graded based on the performance of your prompt... but don't cheat! You cannot include specifics about the test cases in your prompt. Any prompts with examples will be disqualified.

  Most importantly, output NOTHING but the prompt. Do not include anything else in your message. """

defaultGenerateCandidatesSystemPrompts = [
"""You're a world leading expert in system message engineering. 

  Your job is to generate system messages for GPT-4, a powerful AI that can generate text in response to a prompt.

  The system message is a set of instructions that guides GPT-4 to output the best possible response to a given task, just like you would instruct a human to do the same, or like I'm instructing you to do this task right now.

  You should:
  - Describe the task in plain English
  - Explicit what the is its input and output
      - e.g. "The input is a description of a book, and the output is a title for the book"
  - Be creative in what you ask GPT-4 to do, create intricate mechanisms to constrain the AI from generating bad responses
  
  Remember, GPT-4 knows it's an AI, so you don't need to tell it this

  The performance of your prompt will evaluated and it's results will lead to the improvement of the world.
  But if you cheat, user's will suffer tremendously. So never cheat by including specifics about the test cases in your prompt. Any prompts with examples will be disqualified.

  NEVER INCLUDE ANYTHING ELSE IN YOUR MESSAGE. ONLY THE SYSTEM MESSAGE.
""",
]

def get_generation_prompt(description):
  return f"""
Here is what the user want the final prompt  to accomplish:
""
{description}
""

Respond with your prompt, and nothing else. Be creative.
NEVER CHEAT BY INCLUDING SPECIFICS ABOUT THE TEST CASES IN YOUR PROMPT. 
ANY PROMPTS WITH THOSE SPECIFIC EXAMPLES WILL BE DISQUALIFIED.
IF YOU USE EXAMPLES, ALWAYS USE ONES THAT ARE VERY DIFFERENT FROM THE TEST CASES."""

def get_random_system_prompt():
  return random.choice(defaultGenerateCandidatesSystemPrompts)