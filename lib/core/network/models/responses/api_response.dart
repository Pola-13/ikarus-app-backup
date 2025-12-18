
import 'package:ikarusapp/core/extensions/json_parser.dart';

class ApiResponse<T> {
  final bool? isSuccessful;
  final String? responseCode;
  final String? message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({
    this.isSuccessful,
    this.responseCode,
    this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // Handle new API response structure
    final isSuccessful = json['is_successful'] as bool?;
    final responseCode = json['response_code'] as String?;
    
    // Extract message - can be string or object with title/message
    String? message;
    if (json['message'] != null) {
      if (json['message'] is Map) {
        message = json['message']['message'] as String?;
      } else if (json['message'] is String) {
        message = json['message'] as String?;
      }
    }
    
    // Extract data
    T? data;
    if (json['data'] != null && json['data'] is Map) {
      data = (json['data'] as Map<String, dynamic>).parse<T>();
    }
    
    // Extract errors
    Map<String, dynamic>? errors;
    if (json['errors'] != null && json['errors'] is Map) {
      errors = json['errors'] as Map<String, dynamic>;
    }

    return ApiResponse<T>(
      isSuccessful: isSuccessful,
      responseCode: responseCode,
      message: message,
      data: data,
      errors: errors,
    );
  }
  
  // Helper method to get error message from errors map
  String? getErrorMessage() {
    if (errors == null || errors!.isEmpty) {
      return message;
    }
    
    // Try to extract error messages from the errors map
    // Common patterns: errors can be Map<String, List<String>> or Map<String, String>
    final errorMessages = <String>[];
    errors!.forEach((key, value) {
      if (value is List) {
        errorMessages.addAll(value.map((e) => e.toString()));
      } else if (value is String) {
        errorMessages.add(value);
      }
    });
    
    return errorMessages.isNotEmpty 
        ? errorMessages.join(', ') 
        : message;
  }
}
