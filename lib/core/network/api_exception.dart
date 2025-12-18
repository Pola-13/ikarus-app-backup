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

    if (statusCode != null && data is Map<String, dynamic>) {
      // Handle new API response structure with is_successful
      if (data.containsKey('is_successful') && data['is_successful'] == false) {
        // Extract error message from new structure
        String? errorMessage;
        
        // Try to get message from message object
        if (data['message'] != null) {
          if (data['message'] is Map) {
            errorMessage = data['message']['message'] as String?;
          } else if (data['message'] is String) {
            errorMessage = data['message'] as String?;
          }
        }
        
        // If no message, try to extract from errors map
        if (errorMessage == null && data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              errorMessage = firstError.first.toString();
            } else if (firstError is String) {
              errorMessage = firstError;
            } else {
              errorMessage = firstError.toString();
            }
          }
        }
        
        return ApiError(
          message: errorMessage ?? "Operation failed",
          statusCode: statusCode,
        );
      }
      
      // Handle detail field (legacy)
      if (data['detail'] != null) {
        return ApiError(message: data['detail'], statusCode: statusCode);
      }
    }

    if (statusCode == 302) {
      return ApiError(message: 'This Email Already Taken', statusCode: statusCode);
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
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout in connection with server");
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        String? message = "Server error";
        
        // Handle redirect status codes (3xx)
        if (status != null && status >= 300 && status < 400) {
          print('⚠️ Redirect response (${status}) - This should be handled automatically by Dio');
          return ApiError(
            message: "Server redirected the request. Please try again.",
            statusCode: status,
          );
        }
        
        // Check if this is actually a successful response that was caught as an error
        if (data is Map<String, dynamic> && data['is_successful'] == true) {
          // This shouldn't happen, but if it does, it means the response was successful
          // but Dio threw an exception for some reason (maybe status code issue)
          print('⚠️ Warning: Successful response caught as DioException');
          print('⚠️ Status Code: $status');
          print('⚠️ Response Data: $data');
          // Return a more specific error message
          return ApiError(
            message: "Response parsing error - successful response caught as exception. Status: $status",
            statusCode: status,
          );
        }
        
        if (data is Map<String, dynamic>) {
          // Try to extract message from new structure
          if (data['message'] != null) {
            if (data['message'] is Map) {
              message = data['message']['message'] as String?;
            } else if (data['message'] is String) {
              message = data['message'] as String?;
            }
          } else if (data['detail'] != null) {
            message = data['detail'] as String?;
          } else if (data['errors'] != null && data['errors'] is Map) {
            final errors = data['errors'] as Map<String, dynamic>;
            if (errors.isNotEmpty) {
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                message = firstError.first.toString();
              } else if (firstError is String) {
                message = firstError;
              }
            }
          }
        }
        
        print('❌ BadResponse - Status: $status, Message: $message');
        return ApiError(message: message ?? "Server error", statusCode: status);
      case DioExceptionType.connectionError:
        return ApiError(message: "No internet connection");
      case DioExceptionType.badCertificate:
        return ApiError(message: "Certificate error");
      case DioExceptionType.unknown:
        final errorMessage = error.message ?? '';
        final errorString = error.error?.toString() ?? '';
        
        // Check for SSL/certificate errors
        if (errorMessage.contains('Certificate') ||
            errorMessage.contains('SSL') ||
            errorMessage.contains('TLS') ||
            errorString.contains('Certificate')) {
          return ApiError(
            message: "SSL certificate error. Please check the server certificate configuration.",
            statusCode: statusCode,
          );
        }
        // Check for connection errors
        if (errorMessage.contains('SocketException') ||
            errorMessage.contains('Failed host lookup') ||
            errorMessage.contains('Network is unreachable')) {
          return ApiError(message: "No internet connection");
        }
        // Check for timeout errors
        if (errorMessage.contains('timeout') ||
            errorMessage.contains('TimeoutException')) {
          return ApiError(message: "Connection timeout. Please try again.");
        }
        // Generic unknown error with more details
        final errorDetails = errorMessage.isNotEmpty ? errorMessage : errorString;
        print('❌ Unknown DioException: $errorDetails');
        print('❌ Error type: ${error.type}');
        print('❌ Error response: ${error.response}');
        return ApiError(
          message: "Connection error: ${errorDetails.isNotEmpty ? errorDetails : 'Please check your internet connection and try again'}",
          statusCode: statusCode,
        );
      default:
        return ApiError(message: "Something went wrong");
    }
  }
}
