from django.urls import re_path, path
from rest_framework_simplejwt.views import TokenVerifyView, TokenRefreshView

from . import views

urlpatterns = [
    re_path('signup', views.signup),
    re_path('login', views.login),
    path('test_token', TokenVerifyView.as_view(), name='test_token_verify'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('me/', views.me, name='user-me'),
    path('users/', views.userActions, name='user-all'),
    path('users/<uuid:_id>/', views.userActions, name='user-actions'),
]