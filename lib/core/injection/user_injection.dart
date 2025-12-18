import 'package:flutter_riverpod/legacy.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_local_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/singup_request.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/signup_view_model.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/user_view_model.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';

import 'base_injection.dart';

final userProvider = StateNotifierProvider<UserViewModel, UserData?>((ref) {
  return UserViewModel(ref.read(userRepositoryProvider));
});

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl(
    userRemoteDataSource: ref.read(userRemoteDataSourceProvider),
    userLocalDataSource: ref.read(userLocalDataSourceProvider),
  );
});

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(apiService: ref.read(apiMethodsProvider));
});

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource(ref.read(sharedPreferencesProvider));
});

final signupViewModelProvider =
    StateNotifierProvider<SignupViewModel, BaseState<SignupRequest>>((ref) {
      return SignupViewModel(ref.read(userRepositoryProvider));
    });
