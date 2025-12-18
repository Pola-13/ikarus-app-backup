import 'dart:developer';
import 'package:ikarusapp/core/constants/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/network/api_error.dart';

mixin BaseViewModel {
  void handleError({ApiError? errorType, String? errorMessage}) {
    if (errorType?.statusCode == 403) {
      navigateToScreen(Routes.login, removeTop: true);
    } else {
      showToastMessage(errorMessage ?? '');
    }
  }

  void showToastMessage(
    String message, {
    String? title,
    bool isSuccess = false,
  }) {
    var context = AppConstants.navigatorKey.currentContext!;
    var theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: isSuccess ? Colors.green : theme.colorScheme.error,
      ),
    );
  }

  showFixedToastMessage({
    required String message,
    String? actionButtonTitle,
    Function()? onActionClick,
  }) {
    var context = AppConstants.navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 60),
        action: SnackBarAction(
          label: actionButtonTitle ?? 'Ok',
          onPressed:
              onActionClick ??
              () {
                debugPrint('UNDO action button pressed');
              },
        ),
      ),
    );
  }

  showAppTipsBottomSheet(
    BuildContext context, {
    Widget? tipsBottomSheet,
    VoidCallback? onClose,
  }) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: false,
    elevation: 0,
    showDragHandle: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return tipsBottomSheet ?? Container();
    },
  ).whenComplete(() {
    log('can make action here !!');
    onClose?.call();
  });

  Future<Object?>? navigateToScreen(
    String screenRoute, {
    bool removeTop = false,
    bool replace = false,
    dynamic arguments,
  }) {
    hideKeyboard();
    if (removeTop) {
      return AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        screenRoute,
        (route) => false,
        arguments: arguments,
      );
    } else if (replace) {
      return AppConstants.navigatorKey.currentState?.pushReplacementNamed(
        screenRoute,
        arguments: arguments,
      );
    } else {
      return AppConstants.navigatorKey.currentState?.pushNamed(
        screenRoute,
        arguments: arguments,
      );
    }
  }

  showAppBottomSheet({
    required Widget child,
    bool isScrollControlled = false,
    Color? backgroundColor,
    ShapeBorder? shape,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    showModalBottomSheet(
      context: AppConstants.navigatorKey.currentContext!,
      elevation: 0,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: shape,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      builder: (context) => child,
    );
  }

  void screenPop() {
    AppConstants.navigatorKey.currentState?.pop();
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
