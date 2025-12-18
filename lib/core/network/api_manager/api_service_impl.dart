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

    ListResponse<T> baseResponse = ListResponse<T>.fromJson(responseData);

    return BaseApiResult<List<T>>(
      data: baseResponse.data,
      successMessage: baseResponse.message,
    );
  }

  @override
  BaseApiResult<T> handleResponse<T>(Response response) {
    var responseData = response.data;

    if (responseData is Map<String, dynamic>) {
      if (responseData['data'] != null) {
        ApiResponse<T> baseResponse = ApiResponse<T>.fromJson(responseData);

        return BaseApiResult<T>(
          data: baseResponse.data,
          successMessage: baseResponse.message,
        );
      } else {
        return BaseApiResult<T>(
          data: responseData.parse<T>(),
          successMessage: responseData['message'],
        );
      }
    }
    return BaseApiResult<T>(errorMessage: "Something went wrong");
  }
}
