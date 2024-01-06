from django.db import models
from app_auth.models import User
import uuid

# Create your models here.

class Suggestion(models.Model):
    from content_generation.models import Project

    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    parent_keyword = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255, default="")
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    status = models.CharField(max_length=255, default="CREATED")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.search_query)

    class Meta:
        verbose_name_plural = 'Suggestions'


class Search(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    related_suggestion_id = models.ForeignKey(Suggestion, on_delete=models.CASCADE, null=True)
    serps = models.JSONField(default=dict)
    questions = models.JSONField(default=dict)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.related_suggestion_id.search_query)

    class Meta:
        verbose_name_plural = 'Searches'

class Keywords(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    title = models.CharField(max_length=255, default="Keywords List")
    suggestion = models.ManyToManyField(Suggestion, null=True, default=None)
    saved_cluster = models.JSONField(default=dict)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = 'Keywords'



class Article(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    title = models.CharField(max_length=255)
    meta_description = models.CharField(max_length=255)
    article_content = models.TextField()
    related_search_id = models.ForeignKey(Search, on_delete=models.CASCADE, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name_plural = 'Articles'