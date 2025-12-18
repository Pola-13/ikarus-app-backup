import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';

class AppButton extends StatefulWidget {
  final String? text;
  final Function()? onPressed;
  final StateNotifierProvider<dynamic, BaseState>? screenProvider;
  final bool? isEnabled;
  final Color? backgroundColor;
  final Widget? content;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.screenProvider,
    this.isEnabled,
    this.backgroundColor,
  }) : content = null;

  const AppButton.withCustomContent({
    super.key,
    required this.content,
    required this.onPressed,
    this.screenProvider,
    this.isEnabled,
    this.backgroundColor,
  }) : text = null;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Device.deviceHeight(context: context);
    final double screenWidth = Device.deviceWidth(context: context);
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (_, ref, __) {
        final bool isEnabled =
            widget.screenProvider != null
                ? ref.watch(
                  widget.screenProvider!.select(
                    (state) => state.isFormButtonEnabled,
                  ),
                )
                : true;

        final bool isLoading =
            widget.screenProvider != null
                ? ref.watch(
                  widget.screenProvider!.select(
                    (state) => state.isButtonLoading,
                  ),
                )
                : false;

        return SizedBox(
          width: double.infinity,
          height: screenHeight * 0.06,
          child: ElevatedButton(
            onPressed:
                (widget.isEnabled ?? isEnabled) && !isLoading
                    ? widget.onPressed
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  (widget.isEnabled ?? isEnabled)
                      ? (widget.backgroundColor ?? AppColors.tealColor)
                      : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 370),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child:
                  isLoading
                      ? SizedBox(
                        key: const ValueKey('loader'),
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColors.whiteColor,//loading
                        ),
                      )
                      : widget.content ??
                          Text(
                            widget.text ?? '',
                            key: const ValueKey('text'),
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                              fontFamily: FontFamily.appFontFamily,
                            ),
                          ),
            ),
          ),
        );
      },
    );
  }
}
