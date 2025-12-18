import 'package:flutter/widgets.dart';

import 'form_error.dart';

class BaseState<T> {
  bool isLoading;
  bool isPerformingRequest;
  bool isFormButtonEnabled;
  bool isButtonLoading;
  bool actionSucceeded;
  String? successMessage;
  bool hasNoConnection;
  bool hasNoData;
  List<FormError> formErrors;
  T data;

  BaseState(
      {this.isLoading = false,
      this.isPerformingRequest = false,
      this.isButtonLoading = false,
      this.isFormButtonEnabled = false,
      this.actionSucceeded = false,
      this.successMessage,
      this.hasNoConnection = false,
      this.hasNoData = false,
      this.formErrors = const [],
      required this.data});

  BaseState<T> copyWith(
      {bool? isLoading,
      bool? isPerformingRequest,
      bool? actionSucceeded,
      bool? isButtonLoading,
      bool? isFormButtonEnabled,
      String? successMessage,
      bool? hasNoConnection,
      bool? hasNoData,
      String? noDataMessage,
      IconData? noDataIcon,
      List<FormError>? formErrors,
      T? data}) {
    return BaseState(
        isLoading: isLoading ?? this.isLoading,
        isPerformingRequest: isPerformingRequest ?? this.isPerformingRequest,
        actionSucceeded: actionSucceeded ?? this.actionSucceeded,
        successMessage: successMessage ?? this.successMessage,
        isButtonLoading: isButtonLoading ?? this.isButtonLoading,
        isFormButtonEnabled: isFormButtonEnabled ?? this.isFormButtonEnabled,
        hasNoConnection: hasNoConnection ?? this.hasNoConnection,
        hasNoData: hasNoData ?? this.hasNoData,
        formErrors: formErrors ?? this.formErrors,
        data: data ?? this.data);
  }
}
