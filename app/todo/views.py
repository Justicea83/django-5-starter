from rest_framework import mixins, viewsets

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
