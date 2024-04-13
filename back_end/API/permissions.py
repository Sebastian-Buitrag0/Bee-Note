from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Permite a los propietarios de un objeto editar ese objeto.
    """
    def has_object_permission(self, request, view, obj):
        # Permisos de lectura permitidos para cualquier solicitud
        if request.method in permissions.SAFE_METHODS:
            return True

        # Los propietarios del objeto tienen permiso de escritura
        return obj.user == request.user
