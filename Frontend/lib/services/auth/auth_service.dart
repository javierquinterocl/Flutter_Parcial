import 'package:cuenta/model/auth/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _dio = Dio();
  static final _storage = FlutterSecureStorage();
  static final url = 'https://api.escuelajs.co/api/v1/auth/login';

  static Future<String?> getToken(String username, String password) async {
    // Sin validación: acepta cualquier usuario y contraseña
    // Simplemente guarda un token falso y permite el acceso
    try {
      // Guardar un token falso para permitir el acceso
      await _storage.write(key: 'token', value: 'fake_token_${DateTime.now().millisecondsSinceEpoch}');
      return null; // Retorna null para indicar éxito
    } catch (e) {
      return 'Error al guardar el token.';
    }
  }
}
