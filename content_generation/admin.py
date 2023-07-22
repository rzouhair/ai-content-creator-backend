from django.contrib import admin

from content_generation.models import Prompt, Skill, Tag, Recipe

# Register your models here.

admin.site.register(Tag)
admin.site.register(Skill)
admin.site.register(Prompt)
admin.site.register(Recipe)