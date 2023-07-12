from django.urls import path
from . import views

urlpatterns = [
    path('serp/', views.getSerpResults, name='getSearchResults'),
    path('suggest/', views.getSuggestions, name='getSuggestions'),
    path('top-keywords/', views.getTopResultsKeywords, name='getTopResultsKeywords'),
    path('questions/', views.analyzeKeyword, name='analyzeKeyword'),
    path('analyze/<uuid:suggestion_id>/', views.analyze_suggestion, name='analyzeSuggestion'),
    path('suggestions/', views.suggestionsActions, name='suggestions-all'),
    path('suggestions/<uuid:_id>/', views.suggestionsActions, name='suggestions-actions'),
    path('suggestions/<uuid:_id>/search', views.getSuggestionSearch, name='suggestions-search'),
    path('suggestions/<uuid:_id>/search/analyze-questions', views.reanalyzeQuestions, name='suggestions-questions'),
    path('searches/', views.searchActions, name='search-all'),
    path('searches/<uuid:_id>/', views.searchActions, name='search-actions'),
    path('analyze-query/', views.google_search, name='google-actions'),
    path('analyze-post/', views.wordpress_post, name='wp-actions'),
]