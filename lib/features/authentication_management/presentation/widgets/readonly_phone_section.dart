import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ReadOnlyPhoneSection extends StatelessWidget {
  final String phoneNumber;

  const ReadOnlyPhoneSection({
    super.key,
    required this.phoneNumber,
  });

  String _extractCountryCode(String phone) {
    // Extract country code from phone number (e.g., +20, +962, +965, +966)
    if (phone.startsWith('+20')) return '+20';
    if (phone.startsWith('+962')) return '+962';
    if (phone.startsWith('+965')) return '+965';
    if (phone.startsWith('+966')) return '+966';
    // Default to +20 if no match
    return '+20';
  }

  String _extractPhoneNumber(String phone) {
    // Remove country code to get just the phone number
    if (phone.startsWith('+20')) return phone.substring(3);
    if (phone.startsWith('+962')) return phone.substring(4);
    if (phone.startsWith('+965')) return phone.substring(4);
    if (phone.startsWith('+966')) return phone.substring(4);
    // If no known prefix, return as is
    return phone;
  }

  String _getCountryFlag(String countryCode) {
    switch (countryCode) {
      case '+20':
        return '🇪🇬';
      case '+962':
        return '🇯🇴';
      case '+965':
        return '🇰🇼';
      case '+966':
        return '🇸🇦';
      default:
        return '🇪🇬';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);
    
    final countryCode = _extractCountryCode(phoneNumber);
    final phoneWithoutCode = _extractPhoneNumber(phoneNumber);
    final flag = _getCountryFlag(countryCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone",
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            fontFamily: FontFamily.appFontFamily,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: AppColors.neutral50Color,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Row(
                children: [
                  Text(flag, style: const TextStyle(fontSize: 18)),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    countryCode,
                    style: TextStyle(
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.neutral50Color,
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  phoneWithoutCode,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

