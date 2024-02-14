from django.db import IntegrityError
from keywordresearch.serializers import SuggestionSerializer
from rest_framework import serializers
from .models import Document, Memory, Output, Project, Prompt, Recipe, Skill, Tag

class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ('_id', 'name')

class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Project
        fields = ('_id', 'name', 'user', 'description', 'created_at', 'updated_at')


class SkillGetSerializer(serializers.ModelSerializer):
    tags = TagSerializer(many=True)

    class Meta:
        model = Skill
        fields = ('__all__')

class SkillSerializer(serializers.ModelSerializer):
    tags = serializers.PrimaryKeyRelatedField(
        many=True,
        required=False,
        allow_empty=True,
        queryset=Tag.objects.all()
    )
    
    class Meta:
        model = Skill
        fields = ('__all__')

class PromptSerializer(serializers.ModelSerializer):
    skill = serializers.PrimaryKeyRelatedField(queryset=Skill.objects.all(), many=False)
    
    class Meta:
        model = Prompt
        fields = ('_id', 'prompt', 'skill')

class MemorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Memory
        fields = ('_id', 'user', 'name', 'type', 'metadata', 'status', 'created_at', 'updated_at')


class OutputSerializer(serializers.ModelSerializer):
    class Meta:
        model = Output
        fields = ('__all__')

class RecipeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe
        fields = ('_id', 'name', 'user', 'body', 'created_at', 'last_used')

class RecipeGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recipe
        fields = ('__all__')


class DocumentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Document
        fields = ('__all__')

class DocumentGetSerializer(serializers.ModelSerializer):
    suggestion = SuggestionSerializer(many=False)
    class Meta:
        model = Document
        fields = ('__all__')