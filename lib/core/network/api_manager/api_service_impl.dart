import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ikarusapp/core/extensions/json_parser.dart';
import 'package:ikarusapp/core/network/api_manager/dio_client.dart';
import 'package:ikarusapp/core/network/models/responses/api_response.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/core/network/models/responses/list_response.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_profile_response.dart';

import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  ApiServiceImpl() : super(requesterDio: DioClient.dio);

  @override
  BaseApiResult<List<T>> handleListResponse<T>(Response response) {
    var responseData = response.data;
    
    debugPrint('🔍 ListResponse Status: ${response.statusCode}');
    debugPrint('🔍 ListResponse Data Type: ${responseData.runtimeType}');
    
    if (responseData == null) {
      debugPrint('❌ ListResponse: responseData is null');
      return BaseApiResult<List<T>>(errorMessage: "Something went wrong");
    }

    if (responseData is Map<String, dynamic>) {
      debugPrint('🔍 ListResponse: Data is Map');
      debugPrint('🔍 ListResponse Keys: ${responseData.keys.toList()}');
      
      // Check if data is directly a list
      if (responseData['data'] != null && responseData['data'] is List) {
        debugPrint('🔍 ListResponse: data is directly a List with ${(responseData['data'] as List).length} items');
      }
      
      // New structure with is_successful and data (as list or data.results)
      if (responseData.containsKey('is_successful')) {
        debugPrint('🔍 ListResponse: has is_successful flag');
        ListResponse<T> baseResponse = ListResponse<T>.fromJson(responseData);

        debugPrint('🔍 ListResponse: isSuccessful = ${baseResponse.isSuccessful}');
        debugPrint('🔍 ListResponse: data count = ${baseResponse.data?.length ?? 0}');

        if (baseResponse.isSuccessful == true) {
          return BaseApiResult<List<T>>(
            data: baseResponse.data,
            successMessage: baseResponse.message,
            status: response.statusCode ?? 200,
          );
        } else {
          return BaseApiResult<List<T>>(
            errorMessage: baseResponse.message ?? "Something went wrong",
            errors: baseResponse.errors,
            status: response.statusCode,
          );
        }
      }

      // Fallback to old structure (results at root)
      debugPrint('🔍 ListResponse: No is_successful flag, using fallback');
      ListResponse<T> baseResponse = ListResponse<T>.fromJson(responseData);

      return BaseApiResult<List<T>>(
        data: baseResponse.data,
        successMessage: baseResponse.message,
        status: response.statusCode ?? 200,
      );
    }

    debugPrint('❌ ListResponse: responseData is not a Map');
    return BaseApiResult<List<T>>(errorMessage: "Invalid response format");
  }

  @override
  BaseApiResult<T> handleResponse<T>(Response response) {
    var responseData = response.data;
    
    // Debug logging
    debugPrint('🔍 Response Status: ${response.statusCode}');
    debugPrint('🔍 Response Data Type: ${responseData.runtimeType}');
    
    // Handle redirect responses - if we get a 3xx, it means redirect wasn't followed properly
    if (response.statusCode != null && response.statusCode! >= 300 && response.statusCode! < 400) {
      debugPrint('⚠️ Redirect response received (${response.statusCode})');
      debugPrint('⚠️ Response data: $responseData');
      
      // If response data is a string (redirect location), try to extract it
      if (responseData is String) {
        debugPrint('⚠️ Redirect location (from data): $responseData');
        // Check if it's a JSON string that can be parsed
        try {
          // Sometimes redirect responses contain JSON in the body
          // Try to parse it if it looks like JSON
          if (responseData.trim().startsWith('{')) {
            // This might be JSON, try to parse it
            // But typically redirects don't have JSON in the body
            debugPrint('⚠️ Response looks like JSON, but it\'s a redirect');
          }
        } catch (e) {
          debugPrint('⚠️ Could not parse redirect response: $e');
        }
      }
      
      return BaseApiResult<T>(
        errorMessage: "Server redirected the request (${response.statusCode}). The redirect should be followed automatically. Please check the API configuration.",
        status: response.statusCode,
      );
    }
    
    if (responseData is Map) {
      debugPrint('🔍 Response Keys: ${responseData.keys.toList()}');
      debugPrint('🔍 is_successful: ${responseData['is_successful']}');
    }

    if (responseData is Map<String, dynamic>) {
      // Check if response has the new structure with is_successful
      if (responseData.containsKey('is_successful')) {
        ApiResponse<T> baseResponse = ApiResponse<T>.fromJson(responseData);
        
        debugPrint('🔍 Parsed isSuccessful: ${baseResponse.isSuccessful}');
        debugPrint('🔍 Parsed data: ${baseResponse.data}');
        debugPrint('🔍 Parsed message: ${baseResponse.message}');
        
        if (baseResponse.isSuccessful == true) {
          // Check if data was parsed successfully
          if (baseResponse.data == null) {
            debugPrint('⚠️ Warning: is_successful is true but data is null');
            debugPrint('🔍 Response data structure: ${responseData['data']}');
            // Try to parse data manually if it failed
            if (responseData['data'] != null && responseData['data'] is Map) {
              try {
                final dataMap = responseData['data'] as Map<String, dynamic>;
                debugPrint('🔍 Attempting manual parse with data keys: ${dataMap.keys.toList()}');
                
                // Check if T is UserData or UserProfileResponse and parse directly
                final typeString = T.toString();
                T? parsedData;
                
                if (typeString.contains('UserData') && !typeString.contains('UserProfileResponse')) {
                  debugPrint('🔍 Manual parsing UserData directly');
                  parsedData = UserData.fromJson(dataMap) as T?;
                } else if (typeString.contains('UserProfileResponse')) {
                  debugPrint('🔍 Manual parsing UserProfileResponse directly');
                  parsedData = UserProfileResponse.fromJson(dataMap) as T?;
                } else {
                  parsedData = dataMap.parse<T>();
                }
                
                debugPrint('🔍 Manually parsed data: $parsedData');
                if (parsedData != null) {
                  return BaseApiResult<T>(
                    data: parsedData,
                    successMessage: baseResponse.message,
                    status: response.statusCode ?? 200,
                  );
                } else {
                  debugPrint('❌ Manual parse also returned null for type: $typeString');
                }
              } catch (e, stackTrace) {
                debugPrint('❌ Error parsing data manually: $e');
                debugPrint('❌ Stack trace: $stackTrace');
              }
            }
            // If we still don't have data, return error
            return BaseApiResult<T>(
              errorMessage: "Failed to parse response data",
              status: response.statusCode ?? 200,
            );
          }
          
          return BaseApiResult<T>(
            data: baseResponse.data,
            successMessage: baseResponse.message,
            status: response.statusCode ?? 200,
          );
        } else {
          // Handle error case
          debugPrint('❌ API returned error: ${baseResponse.getErrorMessage()}');
          return BaseApiResult<T>(
            errorMessage: baseResponse.getErrorMessage() ?? "Something went wrong",
            status: response.statusCode,
            errors: baseResponse.errors,
          );
        }
      } else if (responseData['data'] != null) {
        // Fallback to old structure
        ApiResponse<T> baseResponse = ApiResponse<T>.fromJson(responseData);

        return BaseApiResult<T>(
          data: baseResponse.data,
          successMessage: baseResponse.message,
          status: response.statusCode,
        );
      } else {
        return BaseApiResult<T>(
          data: responseData.parse<T>(),
          successMessage: responseData['message'] is String 
              ? responseData['message'] as String?
              : responseData['message']?['message'] as String?,
          status: response.statusCode,
        );
      }
    }
    
    debugPrint('❌ Invalid response format - not a Map');
    return BaseApiResult<T>(
      errorMessage: "Invalid response format",
      status: response.statusCode,
    );
  }
}
