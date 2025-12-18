import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/generated/l10n.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "About Us"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03, // ~25
              horizontal: screenWidth * 0.05, // ~20
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  "assets/logo/greenlogo.png",
                  width: screenWidth * 0.4, 
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.03),

                // Title
                Text(
                  S.of(context).about_title ,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w800,
                    fontFamily: FontFamily.appFontFamily,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // Description
                Text(
                  "Ikarus EV is a leading provider of smart electric vehicle charging solutions in Egypt.\n\n"
                  "We are committed to supporting the transition to sustainable mobility by offering reliable, accessible, and user-friendly charging infrastructure.\n\n"
                  "Our mission is to make EV charging simple and convenient for everyone — whether at home, work, or on the go. "
                  "With a growing network of chargers and a seamless digital experience, Ikarus EV helps drivers stay powered up and confident on the road.\n\n"
                  "Key Focus Areas:\n\n"
                  "Wide network of public and private charging stations.\n\n"
                  "Smart payment and charging management through our mobile app.\n\n"
                  "Commitment to green energy and reducing carbon emissions.\n\n"
                  "Dedicated customer support for drivers and partners.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.038, // ~14
                    height: 1.5, 
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.appFontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
