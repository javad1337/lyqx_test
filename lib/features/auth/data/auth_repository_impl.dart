import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final SharedPreferences _prefs;
  static const _tokenKey = 'auth_token';
  static const _usernameKey = 'auth_username';

  AuthRepositoryImpl(this._dio, this._prefs);

  @override
  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final token = response.data['token'] as String;
        await _prefs.setString(_tokenKey, token);
        await _prefs.setString(_usernameKey, username);
        return true;
      }
      return false;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_usernameKey);
  }

  @override
  Future<bool> isLoggedIn() async => _prefs.containsKey(_tokenKey);

  @override
  Future<String?> getUsername() async => _prefs.getString(_usernameKey);
}
