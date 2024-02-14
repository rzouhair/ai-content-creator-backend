from django.urls import path
from . import views

urlpatterns = [
  path('title/', views.generateTitle, name='generateTitle'),
  path('outline/', views.generateOutline, name='generateOutline'),
  path('meta-title/', views.generateMetaTitle, name='generateMetaTitle'),
  path('meta-description/', views.generateMetaDescription, name='generateMetaDescription'),
  path('blog-format/', views.generateBlogFormatAndIntent, name='generateBlogFormatAndIntent'),
  path('writer/', views.writeBlogPost, name='writeBlogPost'),

  path('skills/', views.skillsActions, name='skills-all'),
  path('skills/<uuid:_id>/', views.skillsActions, name='skills-actions'),
  path('skills/<uuid:_id>/outputs/', views.skillOutputs, name='skills-actions'),
  path('skills/<uuid:_id>/prompt/', views.skillPrompt, name='skills-prompt'),

  path('completion/', views.getCompletion, name='get-completion'),

  path('execute/', views.execute, name='execute'),

  path('extract/', views.extractFromVideo, name='extract'),
  path('extract/analyze/', views.extractSummaryFromTranscript, name='extract-analyze'),

  path('documents/', views.documentActions, name='document-all'),
  path('documents/<uuid:_id>/', views.documentActions, name='document-actions'),

  path('projects/', views.projectActions, name='project-all'),
  path('projects/<uuid:_id>/', views.projectActions, name='project-actions'),

  path('memories/', views.memoryActions, name='memory-all'),
  path('memories/<uuid:_id>/', views.memoryActions, name='memory-actions'),

  path('prompts/', views.promptActions, name='prompts-all'),
  path('prompts/<uuid:_id>/', views.promptActions, name='prompts-actions'),
  
  path('tags/', views.tagActions, name='tags-all'),
  path('tags/<uuid:_id>/', views.tagActions, name='tags-actions'),

  path('outputs/', views.outputActions, name='output-all'),
  path('outputs/<uuid:_id>/', views.outputActions, name='output-actions'),

  path('recipes/', views.recipesActions, name='recipes-all'),
  path('recipes/<uuid:_id>/', views.recipesActions, name='recipes-actions'),
]