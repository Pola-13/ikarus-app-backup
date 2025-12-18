import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

//this widget used at the more page to define the sections header

class SectionHeader extends StatelessWidget {
  final String title;
  final String iconPath;

  const SectionHeader({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // ~16
        vertical: screenHeight * 0.01,  // ~8
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Icon
          Image.asset(
            iconPath,
            width: screenWidth * 0.055,  // ~22
            height: screenWidth * 0.055, // ~22
            fit: BoxFit.contain,
          ),
          SizedBox(width: screenWidth * 0.02), // ~8

          // Section Title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.040, // ~14
              color: AppColors.primaryColor,
              fontFamily: FontFamily.appFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
