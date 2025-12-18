import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/authentication_management/presentation/entities/user_fields.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/features/base/data/entities/form_error.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';
import 'package:ikarusapp/features/base/utils/extensions/strings_validator.dart';
// import 'package:ucar_client_app/core/injection/injection_container.dart' as di;

class LoginViewModel extends StateNotifier<BaseState<List<FormError>>>
    with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  LoginViewModel(this._userRepositoryImpl)
    : super(BaseState(data: [], isFormButtonEnabled: true));

  Future<void> validateLoginUser({
    required String email,
    required String password,
  }) async {
    List<FormError> errors = [];

    if (email.trim().isEmpty) {
      errors.add(
        FormError(
          field: UserFields.email.field,
          message: "Please enter your email address",
        ),
      );
    } else if (!email.trim().isValidEmail()) {
      errors.add(
        FormError(
          field: UserFields.email.field,
          message: "Please enter valid email address",
        ),
      );
    }
    if (password.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.password.field,
          message: "Please enter your password",
        ),
      );
    }
    if (errors.isEmpty) {
      logIn(email: email, password: password);
    } else {
      state = state.copyWith(data: errors);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    _startLoading();

    BaseApiResult<UserData?> result = await _userRepositoryImpl.login(
      email,
      password,
    );
    _hideLoading();

    if (result.data != null) {
      var user = result.data;

      ProviderScope.containerOf(
        AppConstants.navigatorKey.currentContext!,
      ).read(userProvider.notifier).setLocalUserData(user!);
      navigateToScreen(Routes.root, removeTop: true);
    } else {
      // Check if error is related to incorrect password
      bool isPasswordError = false;
      
      // First check errors map for password field errors
      if (result.errors != null && result.errors!.isNotEmpty) {
        final errors = result.errors!;
        // Check if errors contain password-related keys
        isPasswordError = errors.keys.any((key) => 
          key.toLowerCase().contains('password') ||
          key.toLowerCase().contains('credentials')
        );
        
        // Also check error values for password-related messages
        if (!isPasswordError) {
          errors.forEach((key, value) {
            final errorStr = value.toString().toLowerCase();
            if (errorStr.contains('password') ||
                errorStr.contains('incorrect') ||
                errorStr.contains('wrong') ||
                errorStr.contains('invalid') ||
                errorStr.contains('credentials')) {
              isPasswordError = true;
            }
          });
        }
      }
      
      // Also check error message
      if (!isPasswordError) {
        final errorMessage = result.errorMessage?.toLowerCase() ?? "";
        isPasswordError = errorMessage.contains('password') ||
            errorMessage.contains('incorrect') ||
            errorMessage.contains('invalid') ||
            errorMessage.contains('wrong') ||
            errorMessage.contains('credentials');
      }

      if (isPasswordError) {
        // Add password field error
        state = state.copyWith(
          data: [
            FormError(
              field: UserFields.password.field,
              message: "Incorrect password. Please try again",
            ),
          ],
        );
      } 
      // else {
      //   // Show other errors as toast
      //   showToastMessage(result.errorMessage ?? "Something went wrong");
      // }

      // state = state.copyWith(formErrors: result.errors);
      // if (result.errors?.isEmpty ?? true) {
      //   handleError(
      //     errorType: result.errorType ?? ApiErrorType.generalError,
      //     errorMessage: result.errorMessage,
      //   );
      // }
    }
  }

  _startLoading() {
    hideKeyboard();
    state = state.copyWith(isButtonLoading: true, formErrors: []);
  }

  _hideLoading() {
    state = state.copyWith(isButtonLoading: false);
  }
}
