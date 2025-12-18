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
    debugPrint(url);
    debugPrint(data.toString());
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

      debugPrint(response.toString());
      return handleResponse<T>(response);
    } on DioException catch (error) {
      return catchError(error);
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
    return BaseApiResult(
      errorMessage: ApiExceptions.handleError(dioError).message,
      apiError: ApiExceptions.handleError(dioError),
    );
  }

  BaseApiResult<T> handleResponse<T>(Response response);

  BaseApiResult<List<T>> handleListResponse<T>(Response response);
}
