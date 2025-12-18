import 'dart:developer';

import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
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

  Future<BaseApiResult<SignupProfile>> signup(Map<String, String> data) {
    return userRemoteDataSource.signup(data);
  }

  void logout() {
    userLocalDataSource.removeUser();
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
