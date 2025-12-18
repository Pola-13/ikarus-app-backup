import 'dart:convert';

import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _CACHED_USER = 'user';

class UserLocalDataSource {
  SharedPreferences preferences;

  UserLocalDataSource(this.preferences);

  void saveUser(UserData user) async {
    String userJson = jsonEncode(UserData.fromJson(user.toJson()));
    preferences.setString(_CACHED_USER, userJson);
  }

  UserData? getUser() {
    var userData = preferences.getString(_CACHED_USER);
    if (userData != null) {
      Map userMap = jsonDecode(userData);
      UserData user = UserData.fromJson(userMap as Map<String, dynamic>);
      return user;
    }
    return null;
  }

  Future<void> removeUser() async {
    preferences.remove(_CACHED_USER);
  }
}
