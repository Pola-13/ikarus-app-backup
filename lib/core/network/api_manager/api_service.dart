import 'package:dio/dio.dart';
import 'package:ikarusapp/core/network/api_exception.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';

const String DO_NOT_INTERCEPT_KEY = "do_not_intercept";
const String AUTHORIZATION_REQUIRED = "authorization_required";
const String IS_GENERAL_REQUEST = "is_general_request";
const String IS_FORM_DATA = "is_form_data";

abstract class ApiService {
  final Dio requesterDio;

  ApiService({required this.requesterDio});

  Future<BaseApiResult<T>> get<T>(
    String url, {
    Map<String, dynamic>? params,
    bool hasToken = false,
    bool intercept = true,
    bool isGeneral = false,
  }) async {
    try {
      debugPrint(params.toString());

      Response response = await requesterDio.get(
        url,
        queryParameters: params,
        options: getOptions(
          hasToken: hasToken,
          intercept: intercept,
          isGeneral: isGeneral,
        ),
      );

      log(response.toString());
      return handleResponse<T>(response);
    } on DioException catch (error) {
      return catchError(error);
    }
  }

  Future<BaseApiResult<T>> post<T>(
    String url, {
    data,
    bool hasToken = false,
    bool isGeneral = false,
    double Function(double)? onSendProgress,
    bool isFormData = false,
  }) async {
    debugPrint('📤 POST Request to: $url');
    debugPrint('📤 Request data: $data');
    try {
      Response response = await requesterDio.post(
        url,
        data: isFormData ? FormData.fromMap(data) : data,
        onSendProgress: (sent, total) {
          double percentage = (sent / total) * 100;
          debugPrint("Upload Progress: ${percentage.toStringAsFixed(2)}%");

          onSendProgress?.call(sent / total);
        },
        options: getOptions(
          hasToken: hasToken,
          isGeneral: isGeneral,
          isFormData: isFormData,
        ),
      );

      debugPrint('✅ Response received - Status: ${response.statusCode}');
      debugPrint('✅ Response data type: ${response.data.runtimeType}');
      if (response.data is Map) {
        debugPrint('✅ Response keys: ${(response.data as Map).keys.toList()}');
      }
      return handleResponse<T>(response);
    } on DioException catch (error) {
      debugPrint('❌ DioException caught in post method');
      debugPrint('❌ Exception type: ${error.type}');
      debugPrint('❌ Response status: ${error.response?.statusCode}');
      debugPrint('❌ Response data: ${error.response?.data}');
      debugPrint('❌ Error message: ${error.message}');
      return catchError(error);
    } catch (e, stackTrace) {
      debugPrint('❌ Unexpected error in post: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      return BaseApiResult<T>(
        errorMessage: "Unexpected error: ${e.toString()}",
      );
    }
  }

  Future<BaseApiResult<T>> put<T>(
    String url, {
    data,
    Map<String, String>? params,
    bool hasToken = false,
    bool isFormData = false,
  }) async {
    debugPrint(url);
    debugPrint(data.toString());
    try {
      Response response = await requesterDio.put(
        url,
        queryParameters: params,
        data: isFormData ? FormData.fromMap(data) : data,
        options: getOptions(hasToken: hasToken, isFormData: isFormData),
      );

      debugPrint(response.toString());
      return handleResponse<T>(response);
    } on DioException catch (error) {
      return catchError(error);
    }
  }

  Future<BaseApiResult<T>> delete<T>(
    String url, {
    data,
    bool hasToken = false,
  }) async {
    try {
      Response response = await requesterDio.delete(
        url,
        data: data,
        options: getOptions(hasToken: hasToken),
      );

      debugPrint(response.toString());
      return handleResponse<T>(response);
    } on DioException catch (error) {
      return catchError(error);
    }
  }

  Future<BaseApiResult<List<T>>> getList<T>(
    String url, {
    Map<String, dynamic>? params,
    bool hasToken = false,
    bool isGeneral = false,
  }) async {
    try {
      Response response = await requesterDio.get(
        url,
        queryParameters: params,
        options: getOptions(hasToken: hasToken, isGeneral: isGeneral),
      );
      debugPrint(response.toString());
      return handleListResponse<T>(response);
    } on DioException catch (error) {
      return catchError(error);
    }
  }

  Options getOptions({
    bool hasToken = false,
    bool intercept = true,
    bool isGeneral = false,
    bool isFormData = false,
  }) {
    Map<String, dynamic> extras = {};
    extras[AUTHORIZATION_REQUIRED] = hasToken;
    extras[IS_GENERAL_REQUEST] = isGeneral;
    extras[IS_FORM_DATA] = isFormData;
    extras[DO_NOT_INTERCEPT_KEY] = !intercept;
    var options = Options(extra: extras);

    return options;
  }

  BaseApiResult<E> catchError<E>(DioException dioError) {
    // Check if this is actually a successful response that was caught as an error
    final statusCode = dioError.response?.statusCode;
    final responseData = dioError.response?.data;
    
    debugPrint('🔍 DioException caught - Type: ${dioError.type}');
    debugPrint('🔍 DioException Status Code: $statusCode');
    debugPrint('🔍 DioException Response Data Type: ${responseData.runtimeType}');
    debugPrint('🔍 DioException Response Data: $responseData');
    
    // If we have a response with data, check if it's actually successful
    if (responseData != null && responseData is Map<String, dynamic>) {
      // Check if the response indicates success
      final isSuccessful = responseData['is_successful'] == true;
      final hasData = responseData['data'] != null;
      
      debugPrint('🔍 Response is_successful: $isSuccessful');
      debugPrint('🔍 Response has data: $hasData');
      
      // If the response is successful (either by status code or is_successful flag), try to parse it
      if ((statusCode != null && statusCode >= 200 && statusCode < 300) || isSuccessful) {
        debugPrint('⚠️ Successful response caught as DioException, attempting to parse...');
        
        final response = Response(
          data: responseData,
          statusCode: statusCode ?? 200,
          requestOptions: dioError.requestOptions,
        );
        
        // Try to parse as successful response
        try {
          final result = handleResponse<E>(response);
          debugPrint('🔍 Parse result - Has data: ${result.data != null}');
          debugPrint('🔍 Parse result - Error message: ${result.errorMessage}');
          
          if (result.data != null) {
            debugPrint('✅ Successfully parsed response from DioException');
            return result;
          } else if (isSuccessful && hasData) {
            // If is_successful is true but data is null, it means parsing failed
            debugPrint('⚠️ is_successful is true but data parsing returned null');
            // Return the result anyway, let the view model handle it
            return result;
          }
        } catch (e, stackTrace) {
          debugPrint('❌ Failed to parse response from DioException: $e');
          debugPrint('❌ Stack trace: $stackTrace');
        }
      }
    }
    
    // If we couldn't parse it as successful, return the error
    final apiError = ApiExceptions.handleError(dioError);
    debugPrint('❌ Returning error: ${apiError.message}');
    return BaseApiResult(
      errorMessage: apiError.message,
      apiError: apiError,
    );
  }

  BaseApiResult<T> handleResponse<T>(Response response);

  BaseApiResult<List<T>> handleListResponse<T>(Response response);
}
