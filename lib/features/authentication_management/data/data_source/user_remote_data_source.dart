import 'package:dio/dio.dart';
import 'package:ikarusapp/core/network/api_error.dart';
import 'package:ikarusapp/core/network/api_exception.dart';
import 'package:ikarusapp/core/network/api_manager/api_service.dart';
import 'package:ikarusapp/core/network/api_manager/api_service_impl.dart';
import 'package:ikarusapp/core/network/api_urls.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/core/utils/pref_helpers.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/models/signup_profile.dart';

class UserRemoteDataSource {
  // Example method to demonstrate usage of ApiService

  final ApiService apiService;

  UserRemoteDataSource({required this.apiService});

  // Login method
  Future<BaseApiResult<UserData>> login(String email, String password) async {
    final response = await apiService.post<UserData>(
      ApiUrls.login,
      data: {'email': email, 'password': password},
    );
    final user = response.data;
    if (user?.token != null) {
      await PrefHelpers.saveToken(user!.token!);
    }
    return response;
  }

  // SignUp method
  Future<BaseApiResult<SignupProfile>> signup(Map<String, String> data) async {
    try {
      final response = await apiService.post<SignupProfile>(
        ApiUrls.signup,
        data: data,
      );
      return response;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // get profile data
  Future<dynamic> getProfile() async {
    final response = await apiService.get('/profile');
    return response;
  }

  //update profile data
  Future<dynamic> updateProfile(Map<String, dynamic> profileData) async {}

  // Logout method
  Future<dynamic> logout() async {}
}
