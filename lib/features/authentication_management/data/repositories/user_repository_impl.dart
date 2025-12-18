import 'dart:developer';

import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/core/utils/pref_helpers.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_local_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/signup_profile.dart';

class UserRepositoryImpl {
  UserRemoteDataSource userRemoteDataSource;
  UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });

  Future<BaseApiResult<UserData>> login(String email, String password) {
    return userRemoteDataSource.login(email, password);
  }

  Future<BaseApiResult<SignupProfile>> signup(Map<String, dynamic> data) {
    return userRemoteDataSource.signup(data);
  }

  Future<BaseApiResult<Map<String, dynamic>>> logout() async {
    // Call the logout API first
    final result = await userRemoteDataSource.logout();
    
    // Clear local data regardless of API response
    // This ensures user is logged out locally even if API call fails
    userLocalDataSource.removeUser();
    
    // Clear tokens from secure storage
    await PrefHelpers.clearToken();
    
    return result;
  }

  void saveLocalUserData(UserData data) {
    userLocalDataSource.saveUser(data);
  }

  UserData? getLocalUserData() {
    log('getLocalUserData ${userLocalDataSource.getUser()}');
    return userLocalDataSource.getUser();
  }

  // Future<BaseApiResult<ProfileResponse>> fetchProfile() {
  //   return userRemoteDataSource.fetchProfile();
  // }
}
