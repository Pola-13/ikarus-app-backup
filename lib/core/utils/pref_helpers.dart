import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefHelpers {
  // Create secure storage instance
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';

  // SAVE TOKEN
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    print('🔐 Secure token saved');
  }

  // GET TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // CLEAR TOKEN
  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    print('🧹 Secure token cleared');
  }
}
