import 'package:dio/dio.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/network/api_error.dart';

// this class will handle Dio errors and convert them to ApiError

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    print(error.requestOptions.path);
    print(error);

    if (statusCode != null) {
      if (data is Map<String, dynamic> && data['detail'] != null) {
        return ApiError(message: data['detail'], statusCode: statusCode);
      }
    }

    if (statusCode == 302) {
      throw ApiError(message: 'This Email Already Taken');
    }

    print(statusCode);
    print(data);
    // Here you can customize how to handle different types of errors
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiError(message: "Request was cancelled");
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout with server");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout in connection with server");
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        final message = error.response?.data['message'] ?? "Server error";
        return ApiError(message: message, statusCode: status);

      default:
        return ApiError(message: "Something went wrong");
    }
  }
}
