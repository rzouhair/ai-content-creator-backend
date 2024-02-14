import uuid
from django.db import IntegrityError, models
from django.contrib.postgres.fields import ArrayField
from django.contrib.auth.models import AbstractUser as DjangoUser

# Create your models here.
class User(DjangoUser) :
    pass
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    # _id = models.CharField(default=uuid.uuid4, editable=False, unique=True, max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.first_name)

    class Meta:
        verbose_name_plural = 'Users'
        ordering = ('email', )