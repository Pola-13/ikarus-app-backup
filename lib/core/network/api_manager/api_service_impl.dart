import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ikarusapp/core/extensions/json_parser.dart';
import 'package:ikarusapp/core/network/api_manager/dio_client.dart';
import 'package:ikarusapp/core/network/models/responses/api_response.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/core/network/models/responses/list_response.dart';

import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  ApiServiceImpl() : super(requesterDio: DioClient.dio);

  @override
  BaseApiResult<List<T>> handleListResponse<T>(Response response) {
    var responseData = response.data;
    if (responseData == null) {
      return BaseApiResult<List<T>>(errorMessage: "Something went wrong");
    }

    if (responseData is Map<String, dynamic>) {
      // New structure with is_successful and data.results
      if (responseData.containsKey('is_successful')) {
        ListResponse<T> baseResponse = ListResponse<T>.fromJson(responseData);

        if (baseResponse.isSuccessful == true) {
          return BaseApiResult<List<T>>(
            data: baseResponse.data,
            successMessage: baseResponse.message,
            status: 200,
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
      ListResponse<T> baseResponse = ListResponse<T>.fromJson(responseData);

      return BaseApiResult<List<T>>(
        data: baseResponse.data,
        successMessage: baseResponse.message,
      );
    }

    return BaseApiResult<List<T>>(errorMessage: "Something went wrong");
  }

  @override
  BaseApiResult<T> handleResponse<T>(Response response) {
    var responseData = response.data;

    if (responseData is Map<String, dynamic>) {
      // Check if response has the new structure with is_successful
      if (responseData.containsKey('is_successful')) {
        ApiResponse<T> baseResponse = ApiResponse<T>.fromJson(responseData);
        
        if (baseResponse.isSuccessful == true) {
          return BaseApiResult<T>(
            data: baseResponse.data,
            successMessage: baseResponse.message,
            status: 200,
          );
        } else {
          // Handle error case
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
        );
      } else {
        return BaseApiResult<T>(
          data: responseData.parse<T>(),
          successMessage: responseData['message'] is String 
              ? responseData['message'] as String?
              : responseData['message']?['message'] as String?,
        );
      }
    }
    return BaseApiResult<T>(errorMessage: "Something went wrong");
  }
}
