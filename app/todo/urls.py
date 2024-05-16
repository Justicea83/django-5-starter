from django.urls import path, include

from rest_framework.routers import DefaultRouter

from todo.views import TodoViewSet

router = DefaultRouter()
router.register('todo', TodoViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
