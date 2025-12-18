import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_almaadai.dart';
import 'package:ikarusapp/features/general_management/presentation/screens/rating.dart';

class StopChargingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StopChargingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Container(
      width: double.infinity,
      height: screenHeight * 0.1,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.055,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.statusRedColor, // RED COLOR
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                showRatingFeedback(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ICON BEFORE TEXT
                  Image.asset(
                    "assets/icons/station/stop.png",
                    width: screenWidth * 0.055,
                    height: screenWidth * 0.055,
                    color: Colors.white,
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  Text(
                    "Stop Charging",
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.appFontFamily,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
