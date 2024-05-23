import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bee_note_application/data/project.dart';

class ApiService {
  static const String baseUrl =
      'http://127.0.0.1:8000/api'; // Reemplaza con la URL de tu servidor Django
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
        print('Respuesta del servidor: ${response.data}');
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
        print('Error del servidor: ${e.response?.data}');
        throw Exception(
            'Error al iniciar sesión: ${e.response?.data['detail']}');
      } else {
        print('Error al conectar con el servidor: $e');
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
      final proyectos = proyectosData.map((json) => Proyecto.fromJson(json)).toList();
      return proyectos;
    } else {
      throw Exception('Error al obtener los proyectos');
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print('Error del servidor: ${e.response?.data}');
      throw Exception('Error al obtener los proyectos: ${e.response?.data['detail']}');
    } else {
      print('Error al conectar con el servidor: $e');
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
      },
    );

    if (response.statusCode == 201) {
      // El registro se realizó correctamente
      print('Usuario registrado exitosamente');
    } else {
      throw Exception('Error al registrar el usuario');
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print('Error del servidor: ${e.response?.data}');
      throw Exception('Error al registrar el usuario: ${e.response?.data}');
    } else {
      print('Error al conectar con el servidor: $e');
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
      // El proyecto se creó exitosamente
      print('Proyecto creado exitosamente');
    } else {
      throw Exception('Error al crear el proyecto');
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print('Error del servidor: ${e.response?.data}');
      throw Exception('Error al crear el proyecto: ${e.response?.data['detail']}');
    } else {
      print('Error al conectar con el servidor: $e');
      throw Exception('Error al conectar con el servidor');
    }
  }
}



}
