import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ReadOnlyLocationSection extends StatelessWidget {
  final String? country;
  final String? city;
  final String? district;

  const ReadOnlyLocationSection({
    super.key,
    this.country,
    this.city,
    this.district,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      children: [
        // Country
        _buildReadOnlyField(
          label: "Country",
          value: country ?? "",
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.015),
        // Governorate (City)
        _buildReadOnlyField(
          label: "Governorate",
          value: city ?? "",
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.015),
        // District
        _buildReadOnlyField(
          label: "District",
          value: district ?? "",
          screenWidth: screenWidth,
          screenHeight: screenHeight,
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

