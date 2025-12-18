import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class DownloadReceiptButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadReceiptButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Container(
      padding: EdgeInsets.only(
        bottom: screenHeight * 0.02,
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      color: Colors.transparent,
      child: SizedBox(
        height: screenHeight * 0.055,
        width: screenWidth * 0.9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.tealColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/station/download.png",
                width: screenWidth * 0.04,
                height: screenWidth * 0.04,
                color:
                    Colors
                        .white,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                "Download Receipt",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
