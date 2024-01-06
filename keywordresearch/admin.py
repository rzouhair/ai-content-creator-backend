from django.contrib import admin
from .models import Search, Article, Suggestion, Keywords

# Register your models here.

admin.site.register(Search)
admin.site.register(Article)
admin.site.register(Suggestion)
admin.site.register(Keywords)
