from rest_framework import serializers
from .models import Search, Article, Suggestion, Keywords

class SearchSerializer(serializers.ModelSerializer):
    class Meta:
        model = Search
        fields = ('_id', 'related_suggestion_id', 'user', 'serps', 'questions', 'created_at')

class ArticleSerializer(serializers.ModelSerializer):
    related_search_id = SearchSerializer(many=False)

    class Meta:
        model = Article
        fields = ('_id', 'title', 'meta_description', 'user', 'article_content', 'related_search_id', 'created_at')


class SuggestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Suggestion
        fields = ['_id', 'parent_keyword', 'user', 'status', 'search_query', 'project', 'metadata', 'created_at']

class KeywordsSerializerWithEmbedding(serializers.ModelSerializer):
    class Meta:
        model = Keywords
        fields = ['_id', 'title', 'user', 'suggestions', 'saved_cluster', 'embeddings', 'created_at']

class KeywordsPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Keywords
        fields = ['_id', 'user', 'title', 'suggestions', 'saved_cluster', 'created_at']
class KeywordsSerializer(serializers.ModelSerializer):
    suggestions = SuggestionSerializer(many=True)
    class Meta:
        model = Keywords
        fields = ['_id', 'user', 'title', 'suggestions', 'saved_cluster', 'created_at']

class SearchGetSerializer(serializers.ModelSerializer):
    related_suggestion_id = SuggestionSerializer(many=False)    

    class Meta:
        model = Search
        fields = ('_id', 'related_suggestion_id', 'serps', 'questions', 'created_at')
