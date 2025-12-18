import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

AppBar buildAppBar(BuildContext context, String titleText) {
  final double screenWidth = Device.deviceWidth(context: context);
  final double screenHeight = Device.deviceHeight(context: context);

  String iconAsset = 'assets/icons/arrowback.png';

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
    // back button
    leading: Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Image.asset(iconAsset, fit: BoxFit.contain),
        ),
      ),
    ),

    //the corner images :
    flexibleSpace: Builder(
      builder: (context) {
        return Stack(
          children: [
            // left image
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/logo/appbar_left.png',
                width: screenWidth * 0.25,
              ),
            ),
            // right image
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
