from rest_framework import mixins, viewsets
from django.core.cache import cache
from rest_framework.response import Response

from core.models import Todo
from todo.serializers import TodoSerializer


# Create your views here.
class TodoViewSet(
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.ListModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = TodoSerializer
    queryset = Todo.objects
    authentication_classes = []
    permission_classes = []

    def perform_create(self, serializer):
        serializer.save()

    def list(self, request, *args, **kwargs):
        cache_key = 'todo_list'
        data = cache.get(cache_key)
        if not data:
            queryset = self.filter_queryset(self.get_queryset())

            page = self.paginate_queryset(queryset)
            if page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)

            serializer = self.get_serializer(queryset, many=True)
            data = serializer.data
            cache.set(cache_key, serializer.data, 60 * 15)
        return Response(data)
