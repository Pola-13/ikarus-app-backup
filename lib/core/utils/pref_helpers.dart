import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  // Create secure storage instance
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _splashShownKey = 'splash_shown';

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
    await _storage.delete(key: _refreshTokenKey);
    print('🧹 Secure token cleared');
  }

  // SAVE REFRESH TOKEN
  static Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    print('🔐 Refresh token saved');
  }

  // GET REFRESH TOKEN
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // SPLASH SCREEN HELPERS
  static Future<bool> isSplashShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_splashShownKey) ?? false;
  }

  static Future<void> setSplashShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_splashShownKey, true);
  }
}
