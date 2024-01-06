from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    is_admin = serializers.BooleanField(source='is_superuser', default=False)

    class Meta(object):
        model = User 
        fields = [
            'id',
            '_id',
            'first_name',
            'last_name',
            'username',
            'password',
            'email',
            'is_admin',
            'is_active',
            'created_at',
            'updated_at',
        ]