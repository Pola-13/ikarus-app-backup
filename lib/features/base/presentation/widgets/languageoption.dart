import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class LanguageOption extends StatelessWidget {
  final int index;
  final int? selectedIndex;
  final VoidCallback onTap;
  final String iconPath;
  final String title;

  const LanguageOption({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.08,
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035 , vertical: screenWidth * 0.01  ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.tealColor : const Color(0xFFEEF4E4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // -------- FLAG ICON --------
            Container(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(iconPath, fit: BoxFit.contain),
            ),

            SizedBox(width: screenWidth * 0.04),

            // -------- LANGUAGE TITLE --------
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.045,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ),

            // -------- RADIO INDICATOR --------
            Container(
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.tealColor
                      : AppColors.netural600Color,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: screenWidth * 0.03,
                        height: screenWidth * 0.03,
                        decoration: const BoxDecoration(
                          color: AppColors.tealColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
