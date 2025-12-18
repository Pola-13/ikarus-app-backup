import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/singup_request.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/base/data/entities/form_error.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';

class SignupViewModel extends StateNotifier<BaseState<SignupRequest>>
    with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  SignupViewModel(this._userRepositoryImpl)
    : super(
        BaseState(
          data: SignupRequest(
            email: '',
            password: '',
            confirmPassword: '',
            firstName: '',
            lastName: '',
            phoneE164: '',
            packageName: '',
            country: '',
            city: '',
            street: '',
            postalCode: '',
          ),
          isFormButtonEnabled: true,
        ),
      );

  Future<void> validateSignUpUser({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneE164,
    required String country,
    required String city,
    required String street,
    final String? postalCode,
    final String? profileImage,
    final String? password,
    final String? confirmPassword,
  }) async {
    if (email.trim().isEmpty) {
      showToastMessage("Please enter your email address");
    } else if (firstName.isEmpty) {
      showToastMessage("Please enter your first name ");
    } else if (lastName.isEmpty) {
      showToastMessage("Please enter your last name ");
    } else if (phoneE164.isEmpty) {
      showToastMessage("Please enter your phone number ");
    } else if (country.isEmpty) {
      showToastMessage("Please enter your country ");
    } else if (city.isEmpty) {
      showToastMessage("Please enter your city ");
    } else {
      SignupRequest signupRequest = SignupRequest(
        email: email,
        password: '',
        confirmPassword: '',
        firstName: firstName,
        lastName: lastName,
        phoneE164: phoneE164,
        packageName: '',
        country: country,
        city: city,
        street: street,
        postalCode: '',
      );
      state = state.copyWith(data: signupRequest);
      Navigator.pushNamed(
        AppConstants.navigatorKey.currentContext!,
        Routes.createPassword,
      );
    }
  }

  Future<void> SignUp({
    required String password,
    required String confirmPassword,
  }) async {
    _startLoading();
    SignupRequest signupRequest = state.data;
    BaseApiResult<UserData?> result = await _userRepositoryImpl.signup({
      // Signup data here
      'first_name': signupRequest.firstName,
      'last_name': signupRequest.lastName,
      'email': signupRequest.email,
      'phoneCode': "",
      'phone_e164': signupRequest.phoneE164,
      'country': signupRequest.country,
      'city': signupRequest.city,
      'street': signupRequest.street,
      "password": password,
      "confirm_password": confirmPassword,
    }); //call API
    _hideLoading();

    if (result.data != null) {
      // var user = result.data;
      // ProviderScope.containerOf(
      //   AppConstants.navigatorKey.currentContext!,
      // ).read(userProvider.notifier).setLocalUserData(user!);
      navigateToScreen(Routes.login, removeTop: true);
    } else {
      showToastMessage(result.errorMessage ?? "");

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

/// STEP 1 – signup page
// void setSignupInfo({
//   required String email,
//   required String firstName,
//   required String lastName,
//   required String phoneE164,
//   required String country,
//   required String city,
//   required String street,
//   required String postalCode,
// }) {
//   state = state.copyWith(
//     formErrors: [],
//     data: state.data.copyWith(
//       email: email,
//       firstName: firstName,
//       lastName: lastName,
//       phoneE164: phoneE164,
//       country: country,
//       city: city,
//       street: street,
//       postalCode: postalCode,
//     ),
//   );
// }

// /// STEP 2 – create password page
// void setPassword({
//   required String password,
//   required String confirmPassword,
// }) {
//   state = state.copyWith(
//     formErrors: [],
//     data: state.data.copyWith(
//       password: password,
//       confirmPassword: confirmPassword,
//     ),
//   );
// }

// /// FINAL STEP – call signup API
// Future<void> submitSignup() async {
//   final data = state.data;

//   // -------- Validation --------
//   if (data.email.isEmpty ||
//       data.firstName.isEmpty ||
//       data.lastName.isEmpty ||
//       data.phoneE164.isEmpty ||
//       data.country.isEmpty ||
//       data.city.isEmpty) {
//     state = state.copyWith(
//       formErrors: [
//         FormError(field: '', message: 'Please fill all required fields'),
//       ],
//     );
//     return;
//   }

//   if (data.password != data.confirmPassword) {
//     state = state.copyWith(
//       formErrors: [
//         FormError(
//           field: 'confirmPassword',
//           message: 'Passwords do not match',
//         ),
//       ],
//     );
//     return;
//   }

//   // -------- API Call --------
//   state = state.copyWith(isButtonLoading: true, actionSucceeded: false);

//   final request = SignupRequest(
//     email: data.email,
//     password: data.password,
//     confirmPassword: data.confirmPassword,
//     firstName: data.firstName,
//     lastName: data.lastName,
//     phoneE164: data.phoneE164,
//     packageName: "ikarus_app",
//     country: data.country,
//     city: data.city,
//     street: data.street,
//     postalCode: data.postalCode,
//   );
// }
