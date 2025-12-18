

import 'package:ikarusapp/core/network/api_error.dart';

class BaseApiResult<T> {
  int? status;
  T? data;
  final String? successMessage;
  final String? errorMessage;
  final ApiError? apiError;

  BaseApiResult({
    this.data,
    this.status,
    this.successMessage,
    this.errorMessage,
    this.apiError,
  });
}
