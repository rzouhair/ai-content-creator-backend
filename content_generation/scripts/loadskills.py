import json

jsson = """
{
  "skills": [
  {
    "id":"3423bd2d-c9e9-4263-8835-4a9d3eca6673",
    "name":"AIDA Framework",
    "description":"Use the oldest marketing framework in the world. Attention, Interest, Desire, Action.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product name",
        "required":false,
        "placeholder":"Otter AI"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"aida",
    "emoji":"",
    "beta":false,
    "tags":"Frameworks,Social Media,Ecommerce,Ads",
    "hidden":false,
    "updated_at":"2023-03-24T19:18:52.673141+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"e799bdff-398d-4330-83a0-fa932213cfd2",
    "name":"Amazon Product Description (paragraph)",
    "description":"Create compelling product descriptions for Amazon listings.",
    "inputSchema":[
      {
        "id":"productName",
        "type":"text",
        "label":"Product name",
        "required":true,
        "placeholder":"Khombu OrthoLite X25 Insoles"
      },
      {
        "id":"productBenefits",
        "type":"textarea",
        "label":"Key benefits/features",
        "required":true,
        "placeholder":"High rebound cushion. Eco-friendly & Sustainable. Manage Moisture. High level breathability. Antimicrobial & Light."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"amazon",
    "emoji":"",
    "beta":false,
    "tags":"Ecommerce",
    "hidden":false,
    "updated_at":"2022-12-28T19:09:21.539814+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"4c41dc5a-d317-4aa9-8555-f7cd4cbb7a09",
    "name":"Amazon Product Features (bullets)",
    "description":"Create key feature and benefit bullet points for Amazon listings under the \"about this item\" section.",
    "inputSchema":[
      {
        "id":"productName",
        "type":"text",
        "label":"Product name",
        "required":true,
        "placeholder":"Khombu OrthoLite X25 Insoles"
      },
      {
        "id":"productInfo",
        "type":"textarea",
        "label":"Product info",
        "required":true,
        "placeholder":"Khombu OrthoLite X25 High-Performance Orthotic Insoles for Men - Full-Length Thin FoamShoe Inserts - Cushion, Comfort, Arch/Heel/Foot Support for Sport, Running, Work"
      },
      {
        "id":"productBenefits",
        "type":"text",
        "label":"Key benefits/features",
        "required":false,
        "placeholder":"High rebound cushion. Eco-friendly & Sustainable. Manage Moisture. High level breathability. Antimicrobial & Light."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional. Friendly. Funny."
      },
      {
        "id":"examples"
      }
    ],
    "icon":"amazon",
    "emoji":"",
    "beta":false,
    "tags":"Ecommerce",
    "hidden":false,
    "updated_at":"2023-03-09T15:52:50.519111+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"93f2403d-22de-47c1-bef5-ee60169b69cd",
    "name":"A Thousand Words is Worth a Picture",
    "description":"Get image prompt ideas to use with Jasper Art",
    "inputSchema":[
      {
        "id":"sourcecontent",
        "type":"textarea",
        "label":"Source content",
        "required":true,
        "placeholder":"The blog post, article, tweet, etc. you'd like an image for"
      },
      {
        "id":"artisticvision",
        "type":"text",
        "label":"Artistic Vision (optional)",
        "tooltip":"Separate languages with a comma. Do not use a space after the comma.",
        "required":false,
        "placeholder":"in the style a comic book"
      }
    ],
    "icon":"",
    "emoji":"🖼️",
    "beta":true,
    "tags":"",
    "hidden":false,
    "updated_at":"2023-02-23T06:25:21.776242+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"c05c981f-3d9a-471b-b79a-70ba944fc906",
    "name":"Before-After-Bridge Framework",
    "description":"Create marketing copy using the BAB framework. Before, After, Bridge.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Content description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"🌁",
    "beta":false,
    "tags":"Frameworks",
    "hidden":false,
    "updated_at":"2022-12-28T20:27:42.24333+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9cc5240c-167a-4c22-9989-39e910180c6c",
    "name":"Blog Post Conclusion Paragraph",
    "description":"Wrap up your blog posts with an engaging conclusion paragraph.",
    "inputSchema":[
      {
        "id":"blogPostMainPoints",
        "type":"textarea",
        "label":"What are the main points or outline of your blog post?",
        "required":true,
        "placeholder":"You need a puppy in your life. Puppies are so cute and cuddly! You will have a friend for life. Dogs make great companions!"
      },
      {
        "id":"cta",
        "type":"text",
        "label":"Call to action",
        "required":false,
        "placeholder":"What type of dog do you have? Let me know in the comments below!"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Casual"
      }
    ],
    "icon":"",
    "emoji":"🏁",
    "beta":false,
    "tags":"Blog",
    "hidden":false,
    "updated_at":"2023-03-31T18:46:52.258692+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"1e3729e1-fe42-4adb-b990-ef8c369b8b06",
    "name":"Blog Post Intro Paragraph",
    "description":"Blast through writers block by letting Jasper write your opening paragraph",
    "inputSchema":[
      {
        "id":"blogPostTitle",
        "type":"text",
        "label":"Blog post title",
        "required":true,
        "placeholder":"Emerging Digital Marketing Trends That You Should Pay Attention To"
      },
      {
        "id":"audience",
        "type":"text",
        "label":"Audience",
        "required":false,
        "placeholder":"Marketers. Moms. Bitcoin holders."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Casual"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Blog",
    "hidden":false,
    "updated_at":"2023-03-31T18:47:18.177796+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"5428c948-4d14-4af5-990f-ea409b07602a",
    "name":"Blog Post Outline",
    "description":"Create lists and outlines for articles. Works best for \"Listicle\" and \"How to\" style blog posts or articles.",
    "inputSchema":[
      {
        "id":"title",
        "type":"text",
        "label":"Blog post title/topic",
        "required":true,
        "placeholder":"Digital Marketing Trends That You Should Pay Attention To"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Blog",
    "hidden":false,
    "updated_at":"2023-03-31T18:44:39.156835+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"92696802-85a2-4236-83da-63b0eff4b833",
    "name":"Blog Post Topic Ideas",
    "description":"Brainstorm new blog post topics that will engage readers and rank well on Google.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company name",
        "required":false,
        "placeholder":"Otter AI"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant."
      },
      {
        "id":"audience",
        "type":"text",
        "label":"Audience",
        "required":false,
        "placeholder":"Marketers. Moms. Bitcoin holders."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      },
      {
        "id":"examples"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Blog",
    "hidden":false,
    "updated_at":"2023-03-31T18:47:34.073282+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"267d377a-cf2a-4193-bfa3-6828f587947f",
    "name":"Business or Product Name",
    "description":"Generate a winning name for your business or product.",
    "inputSchema":[
      {
        "id":"description",
        "type":"textarea",
        "label":"Tell us about your business or product",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Keywords to include",
        "required":false,
        "placeholder":"ninja"
      }
    ],
    "icon":"",
    "emoji":"💈",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-12-07T20:55:19.062106+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"a524d926-af80-4998-8aca-19d503bae931",
    "name":"Commands",
    "description":"Tell Jasper exactly what to write with a command",
    "inputSchema":[
      {
        "id":"command",
        "type":"textarea",
        "label":"Your command for Jasper",
        "required":true,
        "placeholder":"Write a creative story about Tobby flying to the moon in Matthew McConaughey's tone of voice"
      },
      {
        "id":"content",
        "type":"textarea",
        "label":"Do you have any background information for Jasper?",
        "useJbv":true,
        "placeholder":"Tobby was a happy dog that loved to sneak around eating people's food",
        "jbvMaxLength":1500
      }
    ],
    "icon":"",
    "emoji":"🗣️",
    "beta":false,
    "tags":"Social Media,Frameworks,Email,Website,Blog,Ads,Ecommerce,Google,Video,SEO,New",
    "hidden":false,
    "updated_at":"2023-03-20T01:57:28.073572+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"b4f3c7c9-08d7-4379-9466-236411851244",
    "name":"Company Bio",
    "description":"Tell your company's story with a captivating bio.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company Name",
        "required":false,
        "placeholder":"Proof"
      },
      {
        "id":"companyInformation",
        "type":"textarea",
        "label":"Company information",
        "required":true,
        "placeholder":"Proof helps digital marketers boost website conversions using the power of social proof. Founded in 2017. Located in Austin TX. Software company in the digital marketing space."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"💼",
    "beta":false,
    "tags":"Website",
    "hidden":false,
    "updated_at":"2022-08-11T20:03:46.252566+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"e501f9e4-5f83-48c0-a274-9a03a9dfcf11",
    "name":"Content Improver",
    "description":"Take a piece of content and rewrite it to make it more interesting, creative, and engaging. ",
    "inputSchema":[
      {
        "id":"blandContent",
        "type":"textarea",
        "label":"Content",
        "required":true,
        "placeholder":"We help agencies automate their daily tasks so they can scale better and faster with less effort."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Funny"
      }
    ],
    "icon":"stars",
    "emoji":"🪄",
    "beta":false,
    "tags":"Email,Website,Blog,Ads,Ecommerce,Social Media",
    "hidden":false,
    "updated_at":"2023-03-31T18:45:10.817659+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"0de2aea5-5c09-4903-866d-a4ead2c78c93",
    "name":"Creative Story",
    "description":"Write wildly creative stories to engage your readers.",
    "inputSchema":[
      {
        "id":"storyPlot",
        "type":"textarea",
        "label":"Plot",
        "required":true,
        "placeholder":"Jane and Gerald are two mad scientists living in the Amazon Rainforest. Jane discovers a mysterious shiny object. The scientists are mesmerized and frightened."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"🦸‍♀️",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2022-12-07T20:25:58.925688+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"c2c9f594-7dac-4271-a698-f6e198220086",
    "name":"Email Subject Lines",
    "description":"Write compelling email subject lines that get readers to open.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Conversion.ai"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      },
      {
        "id":"emailContent",
        "type":"textarea",
        "label":"What is your email about?",
        "required":true,
        "placeholder":"This email is promoting the launch of our new software tool that uses AI to write high performing marketing copy. The offer is a 50% discount."
      }
    ],
    "icon":"",
    "emoji":"📨",
    "beta":false,
    "tags":"Email",
    "hidden":false,
    "updated_at":"2023-02-27T21:47:15.91138+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"a8fdd2fe-31e5-47df-bcc5-28345371bb4e",
    "name":"Engaging Questions",
    "description":"Create a form to ask your audience creative questions to increase engagement.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"text",
        "label":"Topic",
        "required":false,
        "placeholder":"Bitcoin price rising"
      },
      {
        "id":"Audience",
        "type":"text",
        "label":"Audience",
        "required":false,
        "placeholder":"Gold investors"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Casual"
      }
    ],
    "icon":"",
    "emoji":"🤔",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2022-08-11T20:01:38.335464+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9f9097f9-ea71-443b-acc9-2c72a3e51680",
    "name":"Explain It To a Child",
    "description":"Rephrase text to make it easier to read and understand.",
    "inputSchema":[
      {
        "id":"input",
        "type":"textarea",
        "label":"Input text",
        "required":true,
        "placeholder":"Open houses are an excellent way to showcase your home and get it in front of as many potential buyers as possible. You'll want to do this on a day when you're sure that you will be able to have the house open for the whole time so people won't show up and there's no one around. They're also best during times when most people don't work since they might not be able to make it out if they can't take off from their jobs."
      },
      {
        "id":"grade",
        "type":"text",
        "label":"Output Grade level",
        "required":false,
        "placeholder":"8"
      }
    ],
    "icon":"",
    "emoji":"👶",
    "beta":false,
    "tags":"Blog",
    "hidden":false,
    "updated_at":"2023-02-27T22:01:40.319204+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"cbd5c70e-1971-4f18-8b60-b4936488c558",
    "name":"Facebook Ad Headline",
    "description":"Generate scroll-stopping headlines for your Facebook Ads to get prospects to click, and ultimately buy.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Otter AI"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      },
      {
        "id":"examples"
      }
    ],
    "icon":"facebook",
    "emoji":"",
    "beta":false,
    "tags":"Ads",
    "hidden":false,
    "updated_at":"2022-08-01T20:27:02.662933+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"d79c5fc7-dda7-402b-acb9-99af8a884edf",
    "name":"Facebook Ad Primary Text",
    "description":"Create high converting copy for the \"Primary Text\" section of your Facebook ads.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Excited."
      }
    ],
    "icon":"facebook",
    "emoji":"",
    "beta":false,
    "tags":"Ads",
    "hidden":false,
    "updated_at":"2023-03-01T22:49:58.72499+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"02c4e6cd-56e7-4d9b-a6aa-40d66cc959b7",
    "name":"FAQ Generator",
    "description":"Finish your blog post with some FAQs about your topic.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"text",
        "label":"Topic",
        "required":true,
        "placeholder":"Slack"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Tongue in Cheek"
      },
      {
        "id":"productInfo",
        "type":"text",
        "label":"Number of Questions",
        "required":false,
        "placeholder":"8"
      }
    ],
    "icon":"",
    "emoji":"❓",
    "beta":false,
    "tags":"Blog,Website,Marketing,New,Social Media",
    "hidden":false,
    "updated_at":"2023-02-23T06:25:29.044217+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"4076d9ac-2e7d-4190-a12f-b5a853b17180",
    "name":"Feature to Benefit",
    "description":"Turn your product features into benefits that compel action.",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"We help agencies automate their daily tasks so they can scale better and faster with less effort."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Website,Ecommerce,Frameworks,Email",
    "hidden":false,
    "updated_at":"2022-09-27T14:43:16.618256+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"e3ced2b1-dee0-4ddc-8b77-bf0a938ceef0",
    "name":"Google Ads Description",
    "description":"Create high converting copy for the \"Description\" section of your Google Ads.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      },
      {
        "id":"examples"
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Ads,Google",
    "hidden":false,
    "updated_at":"2022-12-28T17:35:14.245632+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"acc983cf-506c-4448-8aa1-7c5b43ea9977",
    "name":"Google Ads Headline",
    "description":"Create high converting copy for the \"Headlines\" section of your Google Ads.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Friendly."
      },
      {
        "id":"examples"
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Ads,Google",
    "hidden":false,
    "updated_at":"2022-09-22T19:57:45.748681+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9dff9eca-496a-4fad-8d93-ed5490f4f939",
    "name":"Google My Business - Event Post",
    "description":"Generate event details for your Google My Business event posts",
    "inputSchema":[
      {
        "id":"eventInformation",
        "type":"textarea",
        "label":"Tell us about your event",
        "required":true,
        "placeholder":"Yoga class on our outdoor patio. Free pint of beer and socializing afterward. Saturday Mar 27th 5-9pm."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Google",
    "hidden":false,
    "updated_at":"2022-08-11T20:02:47.594407+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"ffde818d-4c7e-42a4-9339-65e66a5d5714",
    "name":"Google My Business - Offer Post",
    "description":"Generate offer details for your Google My Business offer posts",
    "inputSchema":[
      {
        "id":"description",
        "type":"textarea",
        "label":"Tell us about your offer",
        "required":true,
        "placeholder":"Free teeth cleaning for new patients"
      },
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Daisy Dental"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Google",
    "hidden":false,
    "updated_at":"2022-08-11T20:02:33.713898+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"885522f1-d515-417e-9bc0-b745c14f8658",
    "name":"Google My Business - Product Description",
    "description":"Generate product descriptions for your Google My Business",
    "inputSchema":[
      {
        "id":"productName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Pushpress"
      },
      {
        "id":"productInformation",
        "type":"textarea",
        "label":"Tell us about the product",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Google",
    "hidden":false,
    "updated_at":"2022-08-11T20:02:09.917603+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"87b793b7-a5a3-4ca6-b0f0-7b4d3229fcc0",
    "name":"Google My Business - What's New Post",
    "description":"Generate What's New post updates for Google My Business",
    "inputSchema":[
      {
        "id":"description",
        "type":"textarea",
        "label":"Tell us about your business update",
        "required":true,
        "placeholder":"We now offer garbage disposal repairs. We are plumbing company. Serving Austin Texas."
      },
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Tom's plumbing"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional."
      }
    ],
    "icon":"google",
    "emoji":"",
    "beta":false,
    "tags":"Google",
    "hidden":false,
    "updated_at":"2022-08-11T20:02:41.235218+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"f8949cf4-3eb3-4954-a36e-00175fbd460e",
    "name":"Jasper.ai Testimonial Helper",
    "description":"Use this template to generate testimonials for Jasper.ai. If this goes well, we'll open it up for you to collect testimonials from all of your customers.",
    "inputSchema":[
      {
        "id":"productReview",
        "type":"textarea",
        "label":"What do you like about Jasper.ai?",
        "required":true,
        "placeholder":"Super easy to use. Gives me copywriting superpowers. Love the Facebook ads templates. Saves me so much time."
      }
    ],
    "icon":"",
    "emoji":"😍",
    "beta":true,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-08-31T15:33:26.006905+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9b7aaa43-ea0c-4c3a-8ea5-bad378a5ba7c",
    "name":"LinkedIn Single Image Ads",
    "description":"Use Jasper with LinkedIn Single Image Ads to reach the right professional audience",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Background Info",
        "required":true,
        "placeholder":"Tell us about your company or product. Include all key details to be mentioned throughout the posts. "
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Intended Audience",
        "required":false,
        "placeholder":"Tech startups"
      }
    ],
    "icon":"",
    "emoji":"🧑‍💼",
    "beta":true,
    "tags":"Social Media,Business,Marketing,New",
    "hidden":false,
    "updated_at":"2023-03-21T20:06:54.472383+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"da7d88b0-f4af-436c-bab7-339f4d6588a7",
    "name":"LinkedIn Text Ads",
    "description":"Use Jasper with LinkedIn Text Ads to reach the right professional audience",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Background Info",
        "required":true,
        "placeholder":"Tell us about your company or product. Include all key details to be mentioned throughout the posts. "
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Intended Audience",
        "required":false,
        "placeholder":"Tech startups"
      }
    ],
    "icon":"",
    "emoji":"🧑‍💼",
    "beta":true,
    "tags":"Social Media,Business,Marketing,New",
    "hidden":false,
    "updated_at":"2023-03-21T20:06:46.890534+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"5abf8578-967d-44bb-8550-3b954b45e491",
    "name":"Listicle ✨",
    "description":"Generate a numbered list based on a topic. Perfect for filling in detail of a blog post.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"text",
        "label":"Topic",
        "required":true,
        "placeholder":"Wine regions in France"
      },
      {
        "id":"count",
        "type":"text",
        "label":"List count",
        "required":true,
        "placeholder":"How many paragraphs do you want?"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Clever, casual"
      }
    ],
    "icon":"",
    "emoji":"📓",
    "beta":false,
    "tags":"New,Blog",
    "hidden":false,
    "updated_at":"2023-02-23T07:05:28.392756+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"8e7ec45c-0756-4ba3-bcd7-c7aa7deb32c9",
    "name":"Marketing Angles",
    "description":"Brainstorm different angles to add vibrancy to your marketing.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"📐",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-08-31T15:34:22.439174+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"df29e185-d59a-45d3-8de6-25675d3e6db5",
    "name":"Mini-VSL (Video Sales Letter)",
    "description":"Write a captivating 60-90 second script for a video that generates interest for your offer. Created by expert copywriter and inventor of the VSL, Jon Benson.",
    "inputSchema":[
      {
        "id":"yourName",
        "type":"text",
        "label":"Your Name",
        "required":false,
        "placeholder":"Sarah"
      },
      {
        "id":"companyName",
        "type":"text",
        "label":"Company Name",
        "required":false,
        "placeholder":"Shade Matcha"
      },
      {
        "id":"audience",
        "type":"text",
        "label":"Who is your ideal buyer audience?",
        "required":false,
        "placeholder":"Women under 40 who drink coffee or energy drinks"
      },
      {
        "id":"productBenefits",
        "type":"textarea",
        "label":"List your key benefits & features",
        "required":false,
        "placeholder":"Lasting energy and focus"
      },
      {
        "id":"negativePain",
        "type":"text",
        "label":"What current pain or negative circumstance is your customer facing now?",
        "required":false,
        "placeholder":"Mid-day energy crash, bad gut health, etc."
      },
      {
        "id":"negativeScaryFact",
        "type":"text",
        "label":"What's a true negative or scary fact?",
        "required":false,
        "placeholder":"Fact: 65% of people feel anxiety after drinking energy drinks."
      },
      {
        "id":"bigIdea",
        "type":"text",
        "label":"What's the big idea in 2-3 words? What hook makes your product different?",
        "required":false,
        "placeholder":"Plant-Based Productivity. (Don't say your product yet)"
      },
      {
        "id":"numberCustomers",
        "type":"text",
        "label":"Number of customers for social proof",
        "required":false,
        "placeholder":"50,000"
      },
      {
        "id":"niche",
        "type":"text",
        "label":"What is your niche? A more narrow focus of your audience.",
        "required":false,
        "placeholder":"Students, Business Professionals, Busy Parents, etc..."
      },
      {
        "id":"goal",
        "type":"text",
        "label":"What are customers' initial goal?",
        "required":false,
        "placeholder":"To feel awake with lasting energy the entire day"
      },
      {
        "id":"bigGoal",
        "type":"text",
        "label":"What are customers' ultimate goal that results from the initial goal?",
        "required":false,
        "placeholder":"Crush goals at work, actively play with kids, live longer, look younger. "
      },
      {
        "id":"deliverable",
        "type":"text",
        "label":"How is your product delivered?",
        "required":false,
        "placeholder":"Tea Powder, Online Course, Digital Report, Software Tool"
      },
      {
        "id":"productName",
        "type":"text",
        "label":"What is your product name?",
        "required":false,
        "placeholder":"Ceremonial Matcha, Model XYZ, etc. "
      },
      {
        "id":"productPrice",
        "type":"text",
        "label":"What is your product's price?",
        "required":false,
        "placeholder":"$49.99, $19/mo, free, etc."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Natural, Excited, Informative, etc.."
      }
    ],
    "icon":"",
    "emoji":"💰",
    "beta":false,
    "tags":"Video,",
    "hidden":false,
    "updated_at":"2022-10-20T17:50:16.551673+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"b5ad4903-69da-4e1d-8452-f6b68b2bad26",
    "name":"One-Shot Blog Post",
    "description":"Generate a full blog post with intro, body, and conclusion.",
    "inputSchema":[
      {
        "id":"blogtopic",
        "type":"textarea",
        "label":"Blog Topic",
        "required":true,
        "placeholder":"SEO, Social Media"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional"
      },
      {
        "id":"intendedaudience",
        "type":"text",
        "label":"Intended Audience",
        "required":false,
        "placeholder":"CMO's, CIO's"
      }
    ],
    "icon":"",
    "emoji":"⚡",
    "beta":false,
    "tags":"Marketing,Blog",
    "hidden":false,
    "updated_at":"2023-03-16T14:32:48.757989+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"dfb13a49-a05d-41cf-8ed5-8b7b4abe8d7d",
    "name":"One-Shot Landing Page",
    "description":"Generate a full landing page with H1, H2 and H3s.",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Background Information",
        "required":true,
        "placeholder":"New Nespresso Vertuo reviving origins pack. We partner with farmers to help restore coffee regions."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":true,
        "placeholder":"Educational, Clever"
      }
    ],
    "icon":"",
    "emoji":"⚡️",
    "beta":true,
    "tags":"Website,New,SEO,Ecommerce",
    "hidden":false,
    "updated_at":"2023-02-23T06:22:11.750742+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"27c9770b-cbca-4ef4-a109-efc576ff9d2a",
    "name":"Paragraph Generator",
    "description":"Generate paragraphs that will captivate your readers.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"textarea",
        "label":"What is your paragraph about?",
        "required":true,
        "placeholder":"What are the best foods for every season?"
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Keywords to include",
        "tooltip":"Separate keywords with a comma. Do not use a space after the comma.",
        "required":false,
        "placeholder":"vegetables,healthy"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Informative"
      }
    ],
    "icon":"",
    "emoji":"📜",
    "beta":false,
    "tags":"Blog,Social Media,Website,SEO",
    "hidden":false,
    "updated_at":"2023-03-14T15:31:28.996822+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":true
  },
  {
    "id":"56e61c7f-f032-408b-b11d-06413dc47214",
    "name":"PAS Framework",
    "description":"Problem-Agitate-Solution. A valuable framework for creating new marketing copy ideas.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product name",
        "required":false,
        "placeholder":"Otter AI"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"pas",
    "emoji":"",
    "beta":false,
    "tags":"Frameworks,Social Media,Ads,Ecommerce",
    "hidden":false,
    "updated_at":"2023-03-31T18:46:00.915478+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"3ea3ae92-c0fe-4b4e-b0c4-df180195bf71",
    "name":"Perfect Headline",
    "description":"Trained with formulas from the world's best copywriters, this template is sure to create high-converting headlines for your business.",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"productName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Pushpress"
      },
      {
        "id":"customerAvatar",
        "type":"text",
        "label":"Customer Avatar",
        "required":false,
        "placeholder":"Gym Owners"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Funny."
      }
    ],
    "icon":"headline",
    "emoji":"",
    "beta":false,
    "tags":"Website",
    "hidden":false,
    "updated_at":"2023-02-27T22:08:02.128459+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"2b38fa60-e113-4e82-9c85-0f9e179d80b3",
    "name":"Personal Bio",
    "description":"Write a creative personal bio that captures attention.",
    "inputSchema":[
      {
        "id":"personalInformation",
        "type":"textarea",
        "label":"Personal Information",
        "required":true,
        "placeholder":"Dave Rogenmoser. CEO of Conversion.ai. CEO of Proof. Y Combinator 2018. Play basketball. 3 boys and a lovely wife. Love reading books of crazy survival stories. Extremely tall."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      },
      {
        "id":"pointOfView",
        "type":"text",
        "label":"Point of view (First Person or Third Person)",
        "required":false,
        "placeholder":"Third person"
      }
    ],
    "icon":"",
    "emoji":"👩‍💻",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2022-10-17T21:19:23.641324+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"19dfddcd-d7ca-4e1f-b99a-da00a7061361",
    "name":"Personalized Cold Emails",
    "description":"Write cold emails that actually work and get responses.",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Tell us about your product",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"productName",
        "type":"text",
        "label":"Your Company/Product Name",
        "required":false,
        "placeholder":"Pushpress"
      },
      {
        "id":"emailReplyInstructions",
        "type":"text",
        "label":"Context to include in the email",
        "required":false,
        "placeholder":"I saw that you own a gym in Austin TX"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"📨",
    "beta":false,
    "tags":"Email",
    "hidden":false,
    "updated_at":"2022-07-28T20:54:43.847881+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"c912b9e4-707a-4861-9557-0e152d8bf806",
    "name":"Personal LinkedIn Post",
    "description":"Stand out from the crowd with creative, long LinkedIn posts. Build your brand, own your voice and engage your audience. ",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"textarea",
        "label":"Problem",
        "required":true,
        "placeholder":"Marketers are stuck. They can't be financially free. "
      },
      {
        "id":"productName",
        "type":"textarea",
        "label":"Solution",
        "required":true,
        "placeholder":"Reverse your thinking. Offer a service, productize that service as a consultant, turn that into a digital product, offer a starter option, and then turn that into a workshop. "
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Other Information",
        "required":true,
        "placeholder":"The process took me 5 years but was worth it. Don't exhaust demand by trying to make a cheap product first and then scale up."
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Intended Audience",
        "required":true,
        "placeholder":"Millennial Marketer"
      },
      {
        "id":"topic",
        "type":"text",
        "label":"CTA",
        "required":true,
        "placeholder":"Think most people can do this? Leave a comment below. 👇"
      }
    ],
    "icon":"",
    "emoji":"🔗",
    "beta":false,
    "tags":"New,Social Media,Marketing,Website",
    "hidden":false,
    "updated_at":"2023-02-08T22:21:12.381649+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"8f9f9b6d-92db-4120-9e57-00489762e41b",
    "name":"Persuasive Bullet Points",
    "description":"Generate persuasive bullet points to insert into landing pages, emails, and more.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"⚫",
    "beta":false,
    "tags":"Email,Website",
    "hidden":false,
    "updated_at":"2022-08-31T15:34:16.217092+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"2b5cce23-9b36-4b05-b211-8a66e6895bf7",
    "name":"Photo Post Captions",
    "description":"Write catchy captions for your Instagram posts",
    "inputSchema":[
      {
        "id":"postTopic",
        "type":"textarea",
        "label":"What is your post about?",
        "required":true,
        "placeholder":"Traveling to South Africa to see some Rhinos on a Safari"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"instagram",
    "emoji":"",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2023-03-31T18:49:56.333679+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"f9ba1225-1d40-4f02-91fd-8392126538ff",
    "name":"Pinterest Pin Title & Description",
    "description":"Create great Pinterest pin titles and descriptions that drive engagement, traffic, and reach.",
    "inputSchema":[
      {
        "id":"productInformation",
        "type":"textarea",
        "label":"Tell us about the pin",
        "required":true,
        "placeholder":"Cutest tiny homes that are affordable"
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keywords",
        "placeholder":"tiny homes"
      },
      {
        "id":"productName",
        "type":"text",
        "label":"Company/Product Name",
        "placeholder":"Home Away"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2022-08-11T20:02:02.191417+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"2855af09-8d02-44e5-b923-5d0d591722a5",
    "name":"Poll Questions & Multiple Choice Answers",
    "description":"Engage your community and get to know them on a deeper level. Create questions with multiple choice answers.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"text",
        "label":"Topic",
        "required":false,
        "placeholder":"Bitcoin price rising"
      },
      {
        "id":"Audience",
        "type":"text",
        "label":"Audience",
        "required":false,
        "placeholder":"Gold investors"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Casual"
      }
    ],
    "icon":"",
    "emoji":"🗳",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-08-11T20:01:30.251621+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"13811b1d-30fb-4ba3-a3bd-a23fbbf278c3",
    "name":"Press Release",
    "description":"Inform your audience of your recent updates and news. Include all facts and quotes you want Jasper to reference. ",
    "inputSchema":[
      {
        "id":"topic",
        "type":"text",
        "label":"Whats your press release about?",
        "required":true,
        "placeholder":"Happsy is Making Organic Mattresses Accessible for Everyone"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Facts + Quotes to Include",
        "required":true,
        "placeholder":"First organic bed-in-a-box, our mission is to make healthier mattresses more affordable. We are celebrating becoming 100% climate neutral certified and joining the conservation alliance. \"Happsy was started to make organic, healthier, non-toxic mattresses more accessible to more people\" - Dale Luckwitz, Brand Manager at Happsy."
      }
    ],
    "icon":"",
    "emoji":"📰",
    "beta":false,
    "tags":"Marketing,New,Website,Email",
    "hidden":false,
    "updated_at":"2023-02-24T20:16:16.923271+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"4e2f87a9-1263-4591-8dbb-60edfd22ab05",
    "name":"Press Release Title & Intro",
    "description":"Write the opening paragraph of a press release that people will actually want to read.",
    "inputSchema":[
      {
        "id":"blandContent",
        "type":"textarea",
        "label":"What is your Press Release about?",
        "required":true,
        "placeholder":"Conversion AI launches new product called Long Form Assistant. Instantly generate high quality long form copy for blogs using AI."
      },
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Conversion AI"
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"keyword",
        "required":false,
        "placeholder":"artificial intelligence"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional"
      }
    ],
    "icon":"",
    "emoji":"📰",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-08-11T20:01:45.869049+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"7c7d6c03-e535-45d8-a8b2-bb50d71d5f07",
    "name":"Product Description",
    "description":"Create compelling product descriptions to be used on websites, emails and social media.",
    "inputSchema":[
      {
        "id":"productName",
        "type":"text",
        "label":"Product Name",
        "required":true,
        "placeholder":"Sherlock Holmes Adventure Escape Room"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Tell us about the product",
        "required":true,
        "placeholder":"Try out a variety of options, including product spec lists"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice or brand style",
        "required":false,
        "placeholder":"Happy Theme Park"
      },
      {
        "id":"audience",
        "type":"text",
        "label":"Target audience",
        "required":false,
        "placeholder":"Underdog office workers who want to change the world"
      }
    ],
    "icon":"",
    "emoji":"💭",
    "beta":false,
    "tags":"Ecommerce",
    "hidden":false,
    "updated_at":"2023-03-31T18:50:45.105634+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"5c09e48d-3517-46d2-b06e-d38bd5071696",
    "name":"Quora Answers",
    "description":"Intelligent answers for tough questions.",
    "inputSchema":[
      {
        "id":"question",
        "type":"textarea",
        "label":"Question",
        "required":true,
        "placeholder":"What are some realistic ways to get rich in 5 years?"
      },
      {
        "id":"information",
        "type":"text",
        "label":"Information to include in the answer",
        "required":false,
        "placeholder":"start a business"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Casual"
      }
    ],
    "icon":"",
    "emoji":"🙋",
    "beta":false,
    "tags":"Social Media",
    "hidden":false,
    "updated_at":"2023-03-31T18:51:21.470935+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"8b85ad74-ff44-48b9-bbda-725c8dcd8b37",
    "name":"Real Estate Listing - Residential",
    "description":"Creative captivating real estate listings that sell homes quickly.",
    "inputSchema":[
      {
        "id":"homeInfo",
        "type":"textarea",
        "label":"Information about the home to include in the listing",
        "required":true,
        "placeholder":"5 Beds. 6 Baths. Barton Creek Community. 1.1 acre lot. Huge foyer. wood floors. chef style kitchen. covered patio. fruit trees. Next to Barton Creek Golf course."
      }
    ],
    "icon":"",
    "emoji":"🏡",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-12-07T20:53:00.002837+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"93dab89f-7c9d-4f7e-8d1c-abfc7cb4ed18",
    "name":"Review Responder",
    "description":"Write responses to public customer reviews that are winsome, professional, and delightful.",
    "inputSchema":[
      {
        "id":"review",
        "type":"textarea",
        "label":"Customer review",
        "required":true,
        "placeholder":"Copy and paste the full customer review"
      },
      {
        "id":"productName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Single Grain Marketing Agency"
      },
      {
        "id":"name",
        "type":"text",
        "label":"Reviewer name",
        "tooltip":"Input the headline this sub-head will go underneath.",
        "required":false,
        "placeholder":"Jessica"
      },
      {
        "id":"stars",
        "type":"text",
        "label":"Star rating from reviewer (from 1-5)",
        "required":false,
        "placeholder":"5"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Friendly"
      }
    ],
    "icon":"",
    "emoji":"📣",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2023-03-01T23:05:37.731049+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"ec2bb8d1-3577-4877-9af8-7592aee37476",
    "name":"Ridiculous Marketing Ideas",
    "description":"A fun template that generates bad marketing ideas that might get you on the front page of the paper for all the wrong reasons. We are not responsible for you ending up in jail or losing all your customers if you attempt these. This is a joke.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Pushpress"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Gym software that helps gym owners manage their gym with less stress and make more money."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Professional. Friendly. Funny."
      }
    ],
    "icon":"smile",
    "emoji":"",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-11-04T17:45:00.831649+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"725827a2-4814-4ee2-a1d3-d33597da2e73",
    "name":"Sentence Expander",
    "description":"Expand a short sentence or a few words into multiple sentences.",
    "inputSchema":[
      {
        "id":"input",
        "type":"textarea",
        "label":"A few words or a short sentence you'd like to expand on",
        "required":true,
        "placeholder":"The key to getting good results from Jasper is to have high quality inputs."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Excited."
      }
    ],
    "icon":"expand",
    "emoji":"",
    "beta":false,
    "tags":"",
    "hidden":false,
    "updated_at":"2022-12-07T20:58:45.960722+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"5ebe23a1-6f0c-4279-ac6e-5ff9f2cce0f4",
    "name":"SEO - Blog Posts - Title and Meta Descriptions",
    "description":"Write SEO optimized title tags and meta descriptions for blog posts that will rank well on Google.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":false,
        "placeholder":"Hubspot"
      },
      {
        "id":"blogPostTitle",
        "type":"text",
        "label":"Blog post title:",
        "required":true,
        "placeholder":"The Who, What, Why, & How of Digital Marketing"
      },
      {
        "id":"blogPostDescription",
        "type":"textarea",
        "label":"Blog post description:",
        "required":false,
        "placeholder":"Learn the basic fundamentals of digital marketing."
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keyword:",
        "required":false,
        "placeholder":"Digital Marketing"
      }
    ],
    "icon":"",
    "emoji":"🔍",
    "beta":false,
    "tags":"SEO,Blog",
    "hidden":false,
    "updated_at":"2023-02-27T21:54:52.52572+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"ab319383-834f-4c5e-92d4-dc9fd60e1acb",
    "name":"SEO - Homepage - Title and Meta Descriptions",
    "description":"Write SEO optimized title tags and meta descriptions for homepages that will rank well on Google.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Clickfunnels"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Clickfunnels helps you quickly create beautiful marketing funnels that convert your visitors into leads and then customers. ClickFunnels Is A Website And Sales Funnel Builder For Entrepreneurs."
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keyword:",
        "required":false,
        "placeholder":"Marketing Funnel"
      }
    ],
    "icon":"",
    "emoji":"🔍",
    "beta":false,
    "tags":"SEO",
    "hidden":false,
    "updated_at":"2022-12-28T18:34:58.163467+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"31f8815f-25f2-4bd3-8275-c1740f79cad5",
    "name":"SEO - Product Page - Title and Meta Descriptions",
    "description":"Write SEO optimized title tags and meta descriptions that will rank well on Google for product pages. ",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company Name",
        "required":true,
        "placeholder":"Anthropology"
      },
      {
        "id":"productName",
        "type":"text",
        "label":"Product name:",
        "required":true,
        "placeholder":"Pilcro The Wanderer Jeans"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description:",
        "required":true,
        "placeholder":"A reimagining of our beloved Wanderer silhouette, the Denim Wanderer features an easygoing fit with subtle, well-loved touches - like this pair's subtle fading and double front button - and patch pockets aplenty. Try styling them with a ruffled blouse or buttondown for a playfully polished ensemble. 96% cotton, 3% polyester, 1% elastane. Relaxed fit. Machine wash."
      },
      {
        "id":"keywordInclude",
        "type":"text",
        "label":"Keyword:",
        "required":false,
        "placeholder":"Pilcro The Wanderer Jeans"
      }
    ],
    "icon":"",
    "emoji":"🔍",
    "beta":false,
    "tags":"SEO,Ecommerce",
    "hidden":false,
    "updated_at":"2022-12-28T18:14:55.462273+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"bcbd0d69-3efe-4d29-8e26-309a6b55b494",
    "name":"SEO - Services Pages - Title and Meta Descriptions",
    "description":"Write SEO optimized title tags and meta descriptions that will rank well on Google for company services pages.",
    "inputSchema":[
      {
        "id":"companyName",
        "type":"text",
        "label":"Company Name",
        "required":true,
        "placeholder":"Bert Roofing"
      },
      {
        "id":"descriptionOfService",
        "type":"textarea",
        "label":"Description of Service:",
        "required":true,
        "placeholder":"Roof Repair in Dallas Texas."
      },
      {
        "id":"keywordInclude",
        "type":"text",
        "label":"Keyword:",
        "required":false,
        "placeholder":"Roof Repair"
      }
    ],
    "icon":"",
    "emoji":"🔍",
    "beta":false,
    "tags":"SEO",
    "hidden":false,
    "updated_at":"2022-12-28T18:52:16.675468+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9d8b6018-e544-4ba5-832b-47ee6313b544",
    "name":"Text Summarizer",
    "description":"Get the key points from a piece of text.",
    "inputSchema":[
      {
        "id":"blandContent",
        "type":"textarea",
        "label":"Text",
        "required":true,
        "placeholder":"This AI is freaking incredible. Writing content for my company used to take hours and my brain would be mush at the end of each day. With conversion.ai, I can spark creativity at any point in the day - whether I'm building out trainings, copywriting for social media, or creating books for lead generation. My only wish is that I could have met Jarvis (the AI's name) sooner! I have shown a brief glimpse at what the AI does to other friends of mine in business and they were shocked just with one tool - BUT the team is constantly expanding the types of content that the AI produces."
      }
    ],
    "icon":"",
    "emoji":"🧙",
    "beta":false,
    "tags":"Social Media,Website,Blog",
    "hidden":false,
    "updated_at":"2022-09-27T16:34:12.014787+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"6ec4981b-9364-46d5-8a42-575f80fddc88",
    "name":"TikTok Video Captions",
    "description":"Generate viral captions for your TikTok videos.",
    "inputSchema":[
      {
        "id":"topic",
        "type":"textarea",
        "label":"What is your video about?",
        "required":true,
        "placeholder":"Bitcoin is going to the moon"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Sarcastic"
      },
      {
        "id":"keywords",
        "type":"text",
        "label":"Keywords to include",
        "tooltip":"Separate keywords with a comma. Do not use a space after the comma.",
        "required":false,
        "placeholder":"Ethereum,Bitcoin"
      }
    ],
    "icon":"",
    "emoji":"🤳",
    "beta":false,
    "tags":"Social Media,Video,New",
    "hidden":false,
    "updated_at":"2023-02-08T22:22:44.661225+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"4affa710-4d6d-471a-85c0-03e2c04568f6",
    "name":"Tone Detector ",
    "description":"Discover your unique tone of voice with the help of Jasper. Simply paste previously written content in, and Jasper will tell you.\n\n",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Content Description",
        "required":false,
        "placeholder":"You only need a paragraph or two for Jasper to be able to tell you your tone of voice"
      }
    ],
    "icon":"",
    "emoji":"🎶",
    "beta":false,
    "tags":"New,Blog,Marketing,Social Media,Ecommerce,Ads,Email,Website",
    "hidden":false,
    "updated_at":"2023-02-23T07:05:36.521442+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"622b173f-3e6f-4e45-93e2-70ef4d92ab07",
    "name":"Tweet Machine",
    "description":"Generate viral tweets for Twitter.",
    "inputSchema":[
      {
        "id":"tweet topic",
        "type":"textarea",
        "label":"What is your tweet about?",
        "required":true,
        "placeholder":"Updates about the James Webb telescope, our company just announced..."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice:",
        "required":false,
        "placeholder":"Factual yet witty"
      }
    ],
    "icon":"",
    "emoji":"🐥",
    "beta":true,
    "tags":"Social Media,New",
    "hidden":false,
    "updated_at":"2022-12-07T21:02:43.373816+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"aaa3d54c-396f-4294-afa5-96ff6ce21ec2",
    "name":"Unique Value Propositions",
    "description":"Create a clear statement that describes the benefit of your offer in a powerful way.",
    "inputSchema":[
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"We help agencies automate their daily tasks so they can scale better and faster with less effort."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"",
    "emoji":"",
    "beta":false,
    "tags":"Website",
    "hidden":false,
    "updated_at":"2022-08-11T20:03:37.371315+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"5996d8b1-4e36-491c-9c9b-9a83633893a8",
    "name":"Video Description - YouTube",
    "description":"Create unique descriptions for Youtube videos that rank well in search.",
    "inputSchema":[
      {
        "id":"videoTitle",
        "type":"text",
        "label":"Video title",
        "required":true,
        "placeholder":"COMPLETE Shopify Tutorial For Beginners 2020 - How To Create A Profitable Shopify Store From Scratch"
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keyword to rank for:",
        "required":false,
        "placeholder":"Shopify"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"youtube",
    "emoji":"",
    "beta":false,
    "tags":"Video",
    "hidden":false,
    "updated_at":"2022-08-11T20:04:58.420332+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"9d4171bc-21f8-48b2-bf22-1cb73b854db0",
    "name":"Video Script Hook and Introduction",
    "description":"Create a video intro that will capture your viewers attention and compel them to watch all the way through.",
    "inputSchema":[
      {
        "id":"videoTitle",
        "type":"text",
        "label":"Video title",
        "required":true,
        "placeholder":"COMPLETE Shopify Tutorial For Beginners 2020 - How To Create A Profitable Shopify Store From Scratch"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"youtube",
    "emoji":"",
    "beta":false,
    "tags":"Video",
    "hidden":false,
    "updated_at":"2022-08-11T20:04:48.763236+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"bf370305-ba24-4965-8f23-31313e2661e3",
    "name":"Video Script Outline",
    "description":"Create script outlines for your videos. Works best for \"Listicle\" and \"How to\" style videos.",
    "inputSchema":[
      {
        "id":"title",
        "type":"text",
        "label":"Video title/topic",
        "required":true,
        "placeholder":"8 strategies for lowering your risk of heart attack."
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"youtube",
    "emoji":"",
    "beta":false,
    "tags":"Video",
    "hidden":false,
    "updated_at":"2022-08-11T20:05:06.696781+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"315351e4-77a6-4ce5-9d75-f9b3445268f8",
    "name":"Video Titles",
    "description":"Create engaging, click-worthy titles for your videos that will rank on Youtube.",
    "inputSchema":[
      {
        "id":"videoTopic",
        "type":"text",
        "label":"What is the video about?",
        "required":true,
        "placeholder":"How  to build a Shopify business"
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keyword to rank for:",
        "required":false,
        "placeholder":"Shopify"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"youtube",
    "emoji":"",
    "beta":false,
    "tags":"Video",
    "hidden":false,
    "updated_at":"2022-08-11T20:05:24.243707+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"a230b22f-2fb4-4b35-83c7-af9eb0063020",
    "name":"Video Topic Ideas",
    "description":"Brainstorm new video topics that will engage viewers and rank well on YouTube.",
    "inputSchema":[
      {
        "id":"videoTopic",
        "type":"text",
        "label":"What topic should the videos be about?",
        "required":true,
        "placeholder":"Making homemade bread"
      },
      {
        "id":"keyword",
        "type":"text",
        "label":"Keyword to rank for:",
        "required":false,
        "placeholder":"Homemade Bread"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      }
    ],
    "icon":"youtube",
    "emoji":"",
    "beta":false,
    "tags":"Video",
    "hidden":false,
    "updated_at":"2022-08-11T20:05:15.232722+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  },
  {
    "id":"10780d17-829d-4603-9ad6-7dc554cd3a2c",
    "name":"Website Sub-headline",
    "description":"Create delightfully informative sub-headlines (H2) for your websites and landing pages.",
    "inputSchema":[
      {
        "id":"productName",
        "type":"text",
        "label":"Company/Product Name",
        "required":true,
        "placeholder":"Single Grain"
      },
      {
        "id":"productDescription",
        "type":"textarea",
        "label":"Product description",
        "required":true,
        "placeholder":"Single Grain is a high performance marketing agency that helps fast growing companies do PPC and SEO."
      },
      {
        "id":"headline",
        "type":"text",
        "label":"Headline",
        "tooltip":"Input the headline this sub-head will go underneath.",
        "required":false,
        "placeholder":"We drive persistent growth for remarkable companies"
      },
      {
        "id":"tone",
        "type":"text",
        "label":"Tone of voice",
        "required":false,
        "placeholder":"Witty"
      },
      {
        "id":"examples",
        "tooltip":"Adding 1-3 examples of quality outputs may help Jarvis produce better results."
      }
    ],
    "icon":"subheadline",
    "emoji":"",
    "beta":false,
    "tags":"Website",
    "hidden":false,
    "updated_at":"2022-12-28T19:36:20.377773+00:00",
    "favoriteSkills_aggregate":{
      "aggregate":{
        "count":0
      }
    },
    "improved":null
  }
]
}
"""

f = open('skills.json', 'r')
print(str(f.read()))

f.close()
