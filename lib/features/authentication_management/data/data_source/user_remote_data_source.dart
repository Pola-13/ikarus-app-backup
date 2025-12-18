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
    try {
      final response = await apiService.post<UserData>(
        ApiUrls.login,
        data: {'email': email, 'password': password},
        hasToken: false, // Login doesn't require token
      );
      
      // Save token and refresh token if login is successful
      final user = response.data;
      if (user?.token != null) {
        await PrefHelpers.saveToken(user!.token!);
        // Save refresh token if available
        if (user.refreshToken != null) {
          await PrefHelpers.saveRefreshToken(user.refreshToken!);
        }
      }
      
      return response;
    } on DioException catch (e) {
      // Dio exceptions are already handled by ApiService, but we can add additional handling here if needed
      return BaseApiResult<UserData>(
        errorMessage: "Login failed. Please check your credentials.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<UserData>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // SignUp method
  Future<BaseApiResult<SignupProfile>> signup(Map<String, String> data) async {
    try {
      final response = await apiService.post<SignupProfile>(
        ApiUrls.signup,
        data: data,
        hasToken: false, // Signup doesn't require token
      );
      return response;
    } on DioException catch (e) {
      return BaseApiResult<SignupProfile>(
        errorMessage: "Signup failed. Please try again.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<SignupProfile>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
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
  Future<BaseApiResult<Map<String, dynamic>>> logout() async {
    try {
      final response = await apiService.post<Map<String, dynamic>>(
        ApiUrls.logout,
        data: {}, // Empty body for logout
        hasToken: true, // Logout requires authentication token
      );
      
      return response;
    } on DioException catch (e) {
      return BaseApiResult<Map<String, dynamic>>(
        errorMessage: "Logout failed. Please try again.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<Map<String, dynamic>>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}
