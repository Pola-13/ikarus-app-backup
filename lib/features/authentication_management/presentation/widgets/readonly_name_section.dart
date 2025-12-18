import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ReadOnlyNameSection extends StatelessWidget {
  final String firstName;
  final String lastName;

  const ReadOnlyNameSection({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Row(
      children: [
        Expanded(
          child: _buildReadOnlyField(
            label: "First Name",
            value: firstName,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: _buildReadOnlyField(
            label: "Last Name",
            value: lastName,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            fontFamily: FontFamily.appFontFamily,
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
            value,
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

