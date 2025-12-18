import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class PhoneSection extends StatelessWidget {
  final TextEditingController phoneController;
  final String? errorMessage;

  const PhoneSection({
    super.key,
    required this.phoneController,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

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
                  const Text("🇪🇬", style: TextStyle(fontSize: 18)),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    "+20",
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
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "1xxxxxxxxx",
                  filled: true,
                  fillColor: AppColors.neutral50Color,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  errorText: null,
                ),
              ),
            ),
          ],
        ),
        if (errorMessage != null)
          Padding(
            padding: EdgeInsets.only(
              left: 0,
              top: screenHeight * 0.005,
            ),
            child: Text(
              errorMessage!,
              style: TextStyle(
                color: AppColors.statusRedColor,
                fontSize: screenWidth * 0.032,
                fontFamily: FontFamily.appFontFamily,
              ),
            ),
          ),
      ],
    );
  }
}
