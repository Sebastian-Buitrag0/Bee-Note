import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bee_note_application/data/project.dart';
import 'package:bee_note_application/data/task.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static final Dio _dio = Dio();

  // Método para iniciar sesión
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/token/',
        data: {
          'nombreUsuario': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final accessToken = responseData['access'];
        final refreshToken = responseData['refresh'];
        await _storeTokens(accessToken, refreshToken);
        return responseData;
      } else {
        throw Exception(
            'Error al iniciar sesión, usuario o contraseña incorrectos');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error al iniciar sesión: ${e.response?.data['detail']}');
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    }
  }

  // Método para almacenar los tokens de forma segura
  static Future<void> _storeTokens(
      String accessToken, String refreshToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  // Método para obtener el token de acceso
  static Future<String?> getAccessToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'access_token');
  }

  // Método para cerrar sesión
  static Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  // Método para obtener la lista de proyectos
  static Future<List<Proyecto>> getProyectos() async {
    try {
      final accessToken = await getAccessToken();
      final response = await _dio.get(
        '$baseUrl/proyecto',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        final proyectosData = response.data as List<dynamic>;
        return proyectosData.map((json) => Proyecto.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener los proyectos');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error al obtener los proyectos: ${e.response?.data['detail']}');
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    }
  }

  static Future<void> registerUser(
    String nombre,
    String apellido,
    String correo,
    String telefono,
    String fechaNacimiento,
    String nombreUsuario,
    String password,
    String? imagenPerfil,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrl/registro/',
        data: {
          'nombreUsuario': nombreUsuario,
          'password': password,
          'datosPersonales': {
            'nombre': nombre,
            'apellido': apellido,
            'fechaNacimiento': fechaNacimiento,
            'telefono': telefono,
            'correo': correo,
          },
          if (imagenPerfil != null) 'imagenPerfilUrl': imagenPerfil, // Agrega la URL de la imagen de perfil aquí
        },
      );

      if (response.statusCode == 201) {
        print('Usuario registrado exitosamente');
      } else {
        throw Exception('Error al registrar el usuario');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Error al registrar el usuario: ${e.response?.data}');
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    }
  }

  static Future<void> createProyecto(
    String nombre,
    String descripcion,
    DateTime fechaInicio,
    DateTime fechaFin,
    int estado,
  ) async {
    try {
      final accessToken = await getAccessToken();
      final response = await _dio.post(
        '$baseUrl/proyecto/',
        data: {
          'nombre': nombre,
          'descripcion': descripcion,
          'fechaInicio': fechaInicio.toIso8601String(),
          'fechaFin': fechaFin.toIso8601String(),
          'estado': estado,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 201) {
        print('Proyecto creado exitosamente');
      } else {
        throw Exception('Error al crear el proyecto');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error al crear el proyecto: ${e.response?.data['detail']}');
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    }
  }

  static Future<void> updateImagenPerfilUrl(String imagenPerfilUrl) async {
    try {
      final accessToken = await getAccessToken();
      final response = await _dio.patch(
        '$baseUrl/usuario/',
        data: {'imagenPerfil': imagenPerfilUrl},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Error al actualizar la URL de la imagen de perfil');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          // El token de acceso ha expirado o no es válido
          // Puedes realizar acciones adicionales, como refrescar el token o redirigir al usuario a la pantalla de inicio de sesión
          print(
              'Token de acceso inválido. Por favor, inicia sesión nuevamente.');
        } else {
          // Otro tipo de error
          print('Error al actualizar la URL de la imagen de perfil: $e');
        }
      } else {
        // Error de conexión u otro tipo de error
        print('Error al actualizar la URL de la imagen de perfil: $e');
      }
      throw Exception('Error al actualizar la URL de la imagen de perfil');
    }
  }

  static Future<void> createTarea(
    int proyectoId,
    String nombre,
    String descripcion,
    String fechaInicio,
    String fechaFin,
    int estado,
    int prioridad,
  ) async {
    print('Creando tarea');
    try {
      final accessToken = await getAccessToken();
      final response = await _dio.post(
        '$baseUrl/tarea/',
        data: {
          'proyecto': proyectoId,
          'nombre': nombre,
          'descripcion': descripcion,
          'estado': estado,
          'prioridad': prioridad,
          'fechaInicio': fechaInicio,
          'fechaFin': fechaFin,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 201) {
        print('Tarea creada exitosamente');
      } else {
        throw Exception('Error al crear la tarea');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error al crear la tarea: ${e.response?.data['detail']}');
      } else {
        throw Exception('Error al conectar con el servidor');
      }
    }
  }

  static Future<List<Tarea>> getTareasPorProyecto(int proyectoId) async {
    try {
      final accessToken = await getAccessToken();
      final response = await _dio.get(
        '$baseUrl/tarea/',
        queryParameters: {'proyecto': proyectoId},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        final tareasData = response.data as List<dynamic>;
        final tareas = tareasData.map((json) => Tarea.fromJson(json)).toList();
        return tareas;
      } else {
        throw Exception('Error al obtener las tareas del proyecto');
      }
    } catch (e) {
      print('Error al obtener las tareas del proyecto: $e');
      throw Exception('Error al obtener las tareas del proyecto');
    }
  }
}
