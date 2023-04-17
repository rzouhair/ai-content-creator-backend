from django.contrib import admin
from .models import Search, Article, Suggestion

# Register your models here.

admin.site.register(Search)
admin.site.register(Article)
admin.site.register(Suggestion)
