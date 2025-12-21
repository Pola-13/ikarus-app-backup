import 'dart:io';
import 'package:flutter/foundation.dart';
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
          message: "Please enter a valid email address",
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

    try {
      BaseApiResult<UserData?> result = await _userRepositoryImpl.login(
        email,
        password,
      );
      _hideLoading();

      // Debug logging
      debugPrint('🔍 Login Result - Status: ${result.status}');
      debugPrint('🔍 Login Result - Has Data: ${result.data != null}');
      debugPrint('🔍 Login Result - Has Token: ${result.data?.token != null}');
      debugPrint('🔍 Login Result - Error Message: ${result.errorMessage}');
      debugPrint('🔍 Login Result - Success Message: ${result.successMessage}');
      debugPrint('🔍 Login Result - API Error: ${result.apiError?.message}');

      if (result.data != null && result.data!.token != null) {
        var user = result.data!;

        // Save user data to local storage and state
        ProviderScope.containerOf(
          AppConstants.navigatorKey.currentContext!,
        ).read(userProvider.notifier).setLocalUserData(user);
        
        // Don't show success toast message - just navigate directly
        // if (result.successMessage != null) {
        //   showToastMessage(result.successMessage!, isSuccess: true);
        // }
        
        // Navigate to root/home screen
        navigateToScreen(Routes.root, removeTop: true);
      } else {
        // Debug: Log why login failed
        if (result.data == null) {
          debugPrint('❌ Login failed: result.data is null');
        } else if (result.data!.token == null) {
          debugPrint('❌ Login failed: token is null');
        }
        
        // Handle error response
        _handleLoginError(result);
      }
    } catch (e, stackTrace) {
      _hideLoading();
      debugPrint('❌ Login Exception: $e');
      debugPrint('❌ Stack Trace: $stackTrace');
      showToastMessage("An unexpected error occurred. Please try again.");
    }
  }

  void _handleLoginError(BaseApiResult<UserData?> result) {
    bool isPasswordError = false;
    bool isEmailError = false;
    List<FormError> errors = [];
    
    // Helper function to extract error message from value
    String _extractErrorMessage(dynamic value) {
      if (value is List) {
        return value.isNotEmpty ? value.first.toString() : value.toString();
      } else {
        return value.toString();
      }
    }
    
    // Check errors map for field-specific errors
    if (result.errors != null && result.errors!.isNotEmpty) {
      final errorMap = result.errors!;
      
      errorMap.forEach((key, value) {
        final keyLower = key.toLowerCase();
        final errorMessage = _extractErrorMessage(value);
        final errorLower = errorMessage.toLowerCase();
        
        // Check for email errors
        if (keyLower.contains('email') || 
            keyLower.contains('user') ||
            errorLower.contains('email') ||
            errorLower.contains('user not found') ||
            errorLower.contains('user does not exist')) {
          isEmailError = true;
          errors.add(FormError(
            field: UserFields.email.field,
            message: errorMessage,
          ));
        }
        
        // Check for password errors
        if (keyLower.contains('password') ||
            keyLower.contains('credentials') ||
            errorLower.contains('password') ||
            errorLower.contains('incorrect') ||
            errorLower.contains('wrong') ||
            errorLower.contains('invalid credentials')) {
          isPasswordError = true;
          errors.add(FormError(
            field: UserFields.password.field,
            message: errorMessage,
          ));
        }
      });
    }
    
    // If no specific field errors found, check error message
    if (!isPasswordError && !isEmailError && result.errorMessage != null) {
      final errorMessage = result.errorMessage!.toLowerCase();
      
      if (errorMessage.contains('password') ||
          errorMessage.contains('incorrect') ||
          errorMessage.contains('wrong') ||
          errorMessage.contains('invalid credentials')) {
        isPasswordError = true;
        errors.add(FormError(
          field: UserFields.password.field,
          message: result.errorMessage!,
        ));
      } else if (errorMessage.contains('email') ||
          errorMessage.contains('user not found') ||
          errorMessage.contains('user does not exist')) {
        isEmailError = true;
        errors.add(FormError(
          field: UserFields.email.field,
          message: result.errorMessage!,
        ));
      } else {
        // Generic error - show as toast
        showToastMessage(result.errorMessage!);
      }
    }
    
    // Update state with form errors if any
    if (errors.isNotEmpty) {
      state = state.copyWith(data: errors);
    } else if (result.errorMessage != null && !isPasswordError && !isEmailError) {
      // Show generic error as toast if no field-specific errors
      showToastMessage(result.errorMessage!);
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
