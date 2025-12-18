import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmController;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final ValueChanged<String> onChanged;

  const ConfirmPasswordField({
    super.key,
    required this.newPasswordController,
    required this.confirmController,
    required this.obscureText,
    required this.onToggleVisibility,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool notMatching = confirmController.text.isNotEmpty &&
        confirmController.text != newPasswordController.text;

    return TextFormField(
      controller: confirmController,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: const TextStyle(
          color: AppColors.netural600Color,
          fontFamily: FontFamily.appFontFamily,
        ),
        filled: true,
        fillColor: AppColors.neutral50Color,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),

        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.netural600Color,
          ),
          onPressed: onToggleVisibility,
        ),

        //  RED BORDER HANDLING 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: notMatching ? AppColors.statusRedColor : Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: notMatching ? AppColors.statusRedColor : AppColors.tealColor,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
