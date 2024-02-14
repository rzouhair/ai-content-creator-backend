from django.db import models
from app_auth.models import User
from django.shortcuts import get_object_or_404
from .serializers import UserSerializer
from functools import wraps
from django.http import HttpResponse

from rest_framework_simplejwt.tokens import AccessToken
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.exceptions import AuthenticationFailed
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework import status

def get_user(id):
  user = get_object_or_404(User, id=id)
  serializer = UserSerializer(user)
  return Response(serializer.data)

def get_decoded_token_data(request: Request) -> dict or None:
    try:
        # Attempt to extract the access token from the request
        access_token = AccessToken.from_authorization_header(request.headers['Authorization'])
        
        # Retrieve the payload (token data) from the access token
        token_data = access_token.payload
        
        return token_data
    
    except (KeyError, AccessToken.DoesNotExist, ValueError) as e:
        # Handle exceptions such as missing or invalid token
        # Optionally, log the error or raise an exception
        return None


def get_user_from_token(request: Request):
    """
    Retrieve the user based on the provided JWT token in the request.
    Returns the user object if authenticated, otherwise None.
    """
    try:
        authentication = JWTAuthentication()
        authenticated_user, _ = authentication.authenticate(request)
        user = UserSerializer(authenticated_user)
        return user.data
    except AuthenticationFailed:
        return None

def user_permissions(allowed_roles):
    """
    Decorator for views that checks if the user has the required roles.
    """
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            if request.user.is_authenticated and request.user.groups.filter(name__in=allowed_roles).exists():
                # If the user has one of the allowed roles, execute the view function
                return view_func(request, *args, **kwargs)
            else:
                # If the user doesn't have the required role(s), deny access
                return HttpResponse("Unauthorized", status=status.HTTP_401_UNAUTHORIZED)  # You can return any response you prefer

        return _wrapped_view

    return decorator