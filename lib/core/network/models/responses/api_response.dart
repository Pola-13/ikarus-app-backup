import 'package:flutter/material.dart';
import 'package:ikarusapp/core/extensions/json_parser.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_profile_response.dart';

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
    String? messageTitle;
    if (json['message'] != null) {
      if (json['message'] is Map) {
        final messageMap = json['message'] as Map<String, dynamic>;
        message = messageMap['message'] as String?;
        messageTitle = messageMap['title'] as String?;
      } else if (json['message'] is String) {
        message = json['message'] as String?;
      }
    }
    
    // Extract data
    T? data;
    if (json['data'] != null) {
      if (json['data'] is Map) {
        final dataMap = json['data'] as Map<String, dynamic>;
        
        // Check if T is UserData, UserProfileResponse or UserData? and parse directly
        final typeString = T.toString();
        if (typeString.contains('UserProfileResponse')) {
          try {
            debugPrint('🔍 Parsing UserProfileResponse directly from: ${dataMap.keys.toList()}');
            data = UserProfileResponse.fromJson(dataMap) as T?;
            debugPrint('🔍 Parsed UserProfileResponse: customer=${(data as UserProfileResponse?)?.customer?.email}');
          } catch (e, stackTrace) {
            debugPrint('❌ Error parsing UserProfileResponse directly: $e');
            debugPrint('❌ Stack trace: $stackTrace');
          }
        } else if (typeString.contains('UserData') && !typeString.contains('UserProfileResponse')) {
          try {
            debugPrint('🔍 Parsing UserData directly from: ${dataMap.keys.toList()}');
            data = UserData.fromJson(dataMap) as T?;
            debugPrint('🔍 Parsed UserData: token=${(data as UserData?)?.token}, user=${(data as UserData?)?.user?.email}');
          } catch (e, stackTrace) {
            debugPrint('❌ Error parsing UserData directly: $e');
            debugPrint('❌ Stack trace: $stackTrace');
          }
        } else {
          // Try generic parsing for other types
          try {
            data = dataMap.parse<T>();
            if (data == null) {
              debugPrint('⚠️ Generic parse returned null for type: $typeString');
            }
          } catch (e) {
            debugPrint('⚠️ Error in generic parsing: $e');
            // Fallback for UserProfileResponse
            if (typeString.contains('UserProfileResponse')) {
              try {
                data = UserProfileResponse.fromJson(dataMap) as T?;
              } catch (e2) {
                debugPrint('❌ Fallback parsing UserProfileResponse also failed: $e2');
              }
            }
          }
        }
      } else if (json['data'] is List && T.toString().contains('List')) {
        // Handle list data if needed
        data = json['data'] as T?;
      }
    } else {
      debugPrint('⚠️ json[data] is null');
    }
    
    // Extract errors
    Map<String, dynamic>? errors;
    if (json['errors'] != null) {
      if (json['errors'] is Map) {
        errors = json['errors'] as Map<String, dynamic>;
      }
    }

    return ApiResponse<T>(
      isSuccessful: isSuccessful,
      responseCode: responseCode,
      message: message ?? messageTitle,
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
