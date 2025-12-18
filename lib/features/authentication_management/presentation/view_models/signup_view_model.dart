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
import 'package:ikarusapp/features/authentication_management/data/models/signup_profile.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/authentication_management/presentation/entities/user_fields.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/base/data/entities/form_error.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';
import 'package:ikarusapp/features/base/utils/extensions/strings_validator.dart';

class SignupViewModel extends StateNotifier<BaseState<List<FormError>>>
    with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;
  SignupRequest _signupRequest = SignupRequest(
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
  );

  SignupViewModel(this._userRepositoryImpl)
    : super(BaseState(data: [], isFormButtonEnabled: true));

  SignupRequest get signupRequest => _signupRequest;

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

    if (firstName.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.firstName.field,
          message: "enter your first name",
        ),
      );
    }

    if (lastName.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.lastName.field,
          message: "enter your last name",
        ),
      );
    }

    if (phoneE164.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.phone.field,
          message: "enter your phone number",
        ),
      );
    }

    if (country.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.country.field,
          message: "choose your country",
        ),
      );
    }

    if (city.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.city.field,
          message: "choose your city",
        ),
      );
    }

    if (street.isEmpty) {
      errors.add(
        FormError(
          field: UserFields.street.field,
          message: "choose your district",
        ),
      );
    }

    if (errors.isEmpty) {
      _signupRequest = SignupRequest(
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
        postalCode: postalCode ?? '',
      );
      state = state.copyWith(data: []);
      Navigator.pushNamed(
        AppConstants.navigatorKey.currentContext!,
        Routes.createPassword,
      );
    } else {
      state = state.copyWith(data: errors);
    }
  }

  Future<void> SignUp({
    required String password,
    required String confirmPassword,
  }) async {
    _startLoading();
    BaseApiResult<SignupProfile> result = await _userRepositoryImpl.signup({
      // Signup data here
      'first_name': _signupRequest.firstName,
      'last_name': _signupRequest.lastName,
      'email': _signupRequest.email,
      'phoneCode': "",
      'phone_e164': _signupRequest.phoneE164,
      'country': _signupRequest.country,
      'city': _signupRequest.city,
      'street': _signupRequest.street,
      "password": password,
      "confirm_password": confirmPassword,
    }); //call API
    _hideLoading();

    if (result.data != null) {
      // Signup successful - navigate to login page
      // Note: Signup doesn't return tokens, user needs to login
      navigateToScreen(Routes.login, removeTop: true);
    } else {
      showToastMessage(result.errorMessage ?? "Something went wrong");
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
