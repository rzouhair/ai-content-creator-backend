
# Create your views here.
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.authentication import SessionAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework import status

from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from .models import User
from .helpers import get_user_from_token, user_permissions
from rest_framework.authtoken.models import Token
from rest_framework_simplejwt.tokens import RefreshToken

from .serializers import UserSerializer
from core.helpers import manual_pagination

@api_view(['POST'])
@permission_classes([AllowAny])
def signup(request):
    payload = request.data
    if (not payload.get('username')):
        payload['username'] = request.data['email']

    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        user = User.objects.get(email=request.data['email'])
        user.set_password(request.data['password'])
        user.save()
        refresh = RefreshToken.for_user(user)
        return Response({'token': str(refresh.access_token), 'refresh': str(refresh), 'user': serializer.data})
    return Response(serializer.errors, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([AllowAny])
def login(request):
    user = get_object_or_404(User, email=request.data['email'])
    if not user.check_password(request.data['password']):
        return Response("Missing user", status=status.HTTP_404_NOT_FOUND)
    refresh = RefreshToken.for_user(user)
    serializer = UserSerializer(user)
    return Response({'token': str(refresh.access_token), 'refresh': str(refresh), 'user': serializer.data})

@api_view(['GET'])
def me(request):
    user = get_user_from_token(request)
    if not user:
        return Response("Please try logging in again", status=status.HTTP_404_NOT_FOUND)
    return JsonResponse(user)

@api_view(['GET'])
@authentication_classes([SessionAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def test_token(request):
    return Response("passed!")

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def userActions(request, _id=None):
    if request.method == 'GET':
        if _id is not None:
            user = get_object_or_404(User, id=_id)
            serializer = UserSerializer(user)
            return Response(serializer.data)
        else:
            users = User.objects.all()
            data = manual_pagination(users, UserSerializer, request)
            return JsonResponse(data)
    
    elif request.method == 'POST':
        print(str(request.data))
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
          serializer.save()
          return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    try:
        user = User.objects.get(id=_id)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'PUT':
        serializer = UserSerializer(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
      """ if _id == None:
        Skill.objects.all().delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
      else: """
      user.delete()
      return Response(status=status.HTTP_204_NO_CONTENT)