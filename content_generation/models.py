import uuid
from django.db import IntegrityError, models
from django.contrib.postgres.fields import ArrayField
from app_auth.models import User

# Create your models here.
class Tag(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    name = models.CharField(max_length=255)
    def __str__(self):
        return str(self.name)

    class Meta:
        verbose_name_plural = 'Tags'


class Skill(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    name = models.CharField(max_length=255, unique=True)
    description = models.TextField()
    hidden = models.BooleanField(default=False)
    beta = models.BooleanField(default=False)
    icon = models.CharField(max_length=50, blank=True)
    emoji = models.CharField(max_length=5, blank=True)
    input_schema = ArrayField(models.JSONField())
    tags = models.ManyToManyField(Tag)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.name)

    class Meta:
        verbose_name_plural = 'Skills'

class Prompt(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    prompt = models.TextField()
    skill = models.ForeignKey(Skill, on_delete=models.CASCADE, unique=True)
    def __str__(self):
        return str(self.skill.name)

    class Meta:
        verbose_name_plural = 'Prompts'


class Output(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    text = models.TextField()
    completionId = models.CharField(max_length=255, blank=True, default=None)
    usage = models.JSONField()
    outputWordCount = models.IntegerField()
    skill = models.ForeignKey(Skill, on_delete=models.CASCADE, default=None, blank=True)
    payload = models.JSONField(blank=True, default=dict)
    created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return str(self.text)

    class Meta:
        verbose_name_plural = 'Outputs'


class Project(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    name = models.CharField(max_length=255, blank=True, default=None, unique=True)
    description = models.TextField(blank=True, default="-")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    def __str__(self):
        return str(self.name or "Untitled")

    class Meta:
        verbose_name_plural = 'Documents'


class Document(models.Model):

    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    content = models.TextField()
    delta = models.JSONField(blank=True, default=dict)
    name = models.CharField(max_length=255, blank=True, default=None, unique=True)
    isPublic = models.BooleanField(default=True)
    status = models.CharField(max_length=255)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    suggestion = models.ForeignKey('keywordresearch.Suggestion', on_delete=models.CASCADE, null=True, default=None)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    def __str__(self):
        return str(self.name or "Untitled")

    class Meta:
        verbose_name_plural = 'Projects'


class Recipe(models.Model):
    _id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, to_field="_id", db_column="user_id")
    name = models.TextField(unique=True)
    body = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    last_used = models.DateTimeField(auto_now=True)
    def __str__(self):
        return str(self.name)

    class Meta:
        verbose_name_plural = 'Recipes'
