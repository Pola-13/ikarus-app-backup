import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';

class UserViewModel extends StateNotifier<UserData?> {
  final UserRepositoryImpl _userRepositoryImpl;

  UserViewModel(
    this._userRepositoryImpl,
  ) : super(_userRepositoryImpl.getLocalUserData());

  void setLocalUserData(UserData user) {
    _userRepositoryImpl.saveLocalUserData(user);
    state = user;
  }

  Future<void> logout() async {
    // Call logout API and clear local data
    await _userRepositoryImpl.logout();
    // Clear state
    state = null;
  }

  void updateLocalUser(UserData user) {
    state = user;
    _userRepositoryImpl.saveLocalUserData(state??UserData());
  }

  updateToken(String newToken) {
    state = state?.copyWith(token: newToken);
    _userRepositoryImpl.saveLocalUserData(state??UserData());
  }

  saveTokenInStateOnlyWithoutCache(String? newToken) {
    state = UserData(token: newToken);
  }
}
