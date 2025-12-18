import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class FeedbackSubmittedSheet extends StatelessWidget {
  const FeedbackSubmittedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header (Title + Close Button)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenHeight * 0.02,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Share Your Feedback",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.appFontFamily,
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.netural600Color,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.netural100Color),

          SizedBox(height: screenHeight * 0.03),
          // Success Icon
          Image.asset(
            "assets/icons/station/rating_is_done.png",
            width: screenWidth * 0.40,
            height: screenWidth * 0.40,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Title
          Text(
            "Feedback Submitted",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.appFontFamily,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Description
          Text(
            "Your feedback has been recorded\nsuccessfully. Thank you for helping us\nimprove your charging experience.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              height: 1.4,
              fontFamily: FontFamily.appFontFamily,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Back to home button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.055,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.stations);
                },
                child: Text(
                  "Back to home",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }
}
