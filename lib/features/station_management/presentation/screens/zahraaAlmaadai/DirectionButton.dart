import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class DirectionsButton extends StatelessWidget {
  final bool isOverviewSelected;
  final VoidCallback onPressed;

  const DirectionsButton({
    super.key,
    required this.isOverviewSelected,
    required this.onPressed,
  });

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
        padding: const EdgeInsets.only(bottom: 15),
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.055,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isOverviewSelected
                    ? AppColors.selectedItemColor
                    : AppColors.tealColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: onPressed,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/Directions.png",
                    width: 24,
                    height: 24,
                    color: isOverviewSelected
                        ? AppColors.tealColor
                        : Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Directions",
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.appFontFamily,
                      color: isOverviewSelected
                          ? AppColors.tealColor
                          : Colors.white,
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
