from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view

# Create your views here.
from django.http import JsonResponse

@api_view(['GET'])
def getData(request):
    person = {'name': 'Dennis', 'age': 28}
    return Response(person)

def my_api_view(request):
    data = [
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane'},
        {'id': 3, 'name': 'Bob'}
    ]
    return JsonResponse(data, safe=False)