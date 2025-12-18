import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

// this is widget used at the sign up page as input for first name and last name

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const LabeledField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            height: 1.3,
            fontFamily: FontFamily.appFontFamily,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.netural600Color,
              fontSize: screenWidth * 0.035,
            ),
            filled: true,
            fillColor: AppColors.neutral50Color,
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.035,
              vertical: screenHeight * 0.014,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide(color: AppColors.tealColor, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
