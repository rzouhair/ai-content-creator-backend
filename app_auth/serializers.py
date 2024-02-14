from rest_framework import serializers
from .models import User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

class UserSerializer(serializers.ModelSerializer):
    is_admin = serializers.BooleanField(source='is_superuser', default=False)

    class Meta(object):
        model = User 
        fields = [
            'id',
            # '_id',
            'first_name',
            'last_name',
            'username',
            'email',
            'groups',
            'is_admin',
            'is_active',
            'created_at',
            'updated_at',
        ]

class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        token['email'] = user.email

        return token