import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

AppBar moreAppBar(BuildContext context) {
  final screenWidth = Device.deviceWidth(context: context);
  final screenHeight = Device.deviceHeight(context: context);

  return AppBar(
    backgroundColor: AppColors.tealColor,
    toolbarHeight: screenHeight * 0.15,
    automaticallyImplyLeading: false,
    flexibleSpace: Stack(
      clipBehavior: Clip.none,
      children: [
        //  LEFT CORNER IMAGE
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset(
            'assets/logo/more_leftcorner.png',
            // width: screenWidth * 0.25,
            height: screenHeight * 0.1,
          ),
        ),

        //  RIGHT CORNER IMAGE
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset(
            'assets/logo/more_rightcorner.png',
            // height: screenHeight * 0.09,
            width: screenWidth * 0.12,
          ),
        ),

        //  PROFILE + NAME + EMAIL
        Positioned(
          bottom: -screenHeight * 0.12,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile picture
              CircleAvatar(
                radius: screenWidth * 0.13,
                backgroundImage: AssetImage("assets/icons/user-circle.png"),
                backgroundColor: Colors.transparent,
              ),

              SizedBox(height: screenHeight * 0.008),

              // NAME
              Text(
                "Mohamed Hany",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: screenWidth * 0.047,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),

              SizedBox(height: screenHeight * 0.003),

              // EMAIL
              Text(
                "Mohamed.Hany@gmail.com",
                style: TextStyle(
                  color: AppColors.netural600Color,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
