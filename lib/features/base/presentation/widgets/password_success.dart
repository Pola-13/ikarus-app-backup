import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

void showPasswordSuccessSheet(BuildContext context) {
  final screenWidth = Device.deviceWidth(context: context);
  final screenHeight = Device.deviceHeight(context: context);

  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SUCCESS ICON
            Container(
              width: screenWidth * 0.40,
              height: screenWidth * 0.40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  screenWidth * 0.04,
                ), // keeps spacing inside circle
                child: Image.asset(
                  "assets/icons/rightmark.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // TEXT
            Text(
              "Password Changed\nSuccessfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: FontFamily.appFontFamily,
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // BUTTON
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); 
                  Navigator.pushNamed(context, '/more');
                },
                child: Text(
                  "Back to home",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontFamily: FontFamily.appFontFamily,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      );
    },
  );
}
