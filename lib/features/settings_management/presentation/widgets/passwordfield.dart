// lib/widgets/password_field.dart
import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;
  final String hint;
  final bool isError;

  const PasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
    required this.hint,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.netural600Color,
          fontFamily: FontFamily.appFontFamily,
        ),
        filled: true,
        fillColor: AppColors.neutral50Color,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.netural600Color,
          ),
          onPressed: onToggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isError ? AppColors.statusRedColor : Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isError ? AppColors.statusRedColor : AppColors.tealColor,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
