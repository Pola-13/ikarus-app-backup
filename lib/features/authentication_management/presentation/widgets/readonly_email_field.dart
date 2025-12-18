import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ReadOnlyEmailField extends StatelessWidget {
  final String email;

  const ReadOnlyEmailField({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontFamily: FontFamily.appFontFamily,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          height: screenHeight * 0.06,
          decoration: BoxDecoration(
            color: AppColors.neutral50Color,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            email,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: AppColors.primaryColor,
              fontFamily: FontFamily.appFontFamily,
            ),
          ),
        ),
      ],
    );
  }
}

