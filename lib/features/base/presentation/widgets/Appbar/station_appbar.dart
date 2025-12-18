import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

AppBar stationAppBar(
  BuildContext context, {
  required String titleText,
  required VoidCallback onBack,
}) {
  final double screenWidth = Device.deviceWidth(context: context);
  final double screenHeight = Device.deviceHeight(context: context);

  return AppBar(
    toolbarHeight: screenHeight * .091,
    backgroundColor: AppColors.tealColor,
    centerTitle: true,

    title: Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Text(
        titleText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
          fontSize: 15,
          fontFamily: FontFamily.appFontFamily,
        ),
      ),
    ),

    // Back Button
    leading: Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: GestureDetector(
        onTap: onBack,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Image.asset(
            "assets/icons/arrowback.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),

    flexibleSpace: Builder(
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/logo/appbar_left.png',
                width: screenWidth * 0.25,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/logo/appbar_right.png',
                width: screenWidth * 0.09,
              ),
            ),
          ],
        );
      },
    ),
  );
}
