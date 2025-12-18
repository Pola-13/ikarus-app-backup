import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class LowBalanceNotification extends StatelessWidget {
  const LowBalanceNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Close button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.netural600Color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Divider(height: 1, color: AppColors.netural100Color),
          SizedBox(height: screenHeight * 0.015),
          // Icon
          Image.asset(
            "assets/icons/station/lowbalance.png",
            width: screenWidth * 0.22,
            height: screenWidth * 0.22,
            fit: BoxFit.contain,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Title
          Text(
            "Low Balance",
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.appFontFamily,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Description
          Text(
            "You Don’t Have Enough Balance\nTo Start Charging. Add Funds\nAnd Try Again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.040,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 1,
              color: AppColors.primaryColor,
              fontFamily: FontFamily.appFontFamily,
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Button
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
                onPressed: () {},
                child: Text(
                  "Add Funds",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}
