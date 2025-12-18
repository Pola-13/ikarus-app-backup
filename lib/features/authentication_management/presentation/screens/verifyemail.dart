import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/otpbox.dart';

class Verifyemail extends StatefulWidget {
  const Verifyemail({super.key});

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {
  // Controllers
  final TextEditingController d1 = TextEditingController();
  final TextEditingController d2 = TextEditingController();
  final TextEditingController d3 = TextEditingController();
  final TextEditingController d4 = TextEditingController();

  // FocusNodes
  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();

  @override
  void dispose() {
    d1.dispose();
    d2.dispose();
    d3.dispose();
    d4.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move forward
      switch (index) {
        case 1:
          FocusScope.of(context).requestFocus(f2);
          break;
        case 2:
          FocusScope.of(context).requestFocus(f3);
          break;
        case 3:
          FocusScope.of(context).requestFocus(f4);
          break;
        case 4:
          FocusScope.of(context).unfocus();
          break;
      }
    } else {
      // Move backward when deleting
      switch (index) {
        case 2:
          FocusScope.of(context).requestFocus(f1);
          break;
        case 3:
          FocusScope.of(context).requestFocus(f2);
          break;
        case 4:
          FocusScope.of(context).requestFocus(f3);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Scaffold(
      backgroundColor: AppColors.tealColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // HEADER
            Positioned(
              width: screenWidth * 0.25,
              height: screenHeight * 0.09,
              left: screenWidth * 0.77,
              top: screenHeight * -0.015,
              child: Image.asset("assets/splash/right corner.png"),
            ),
            Positioned(
              width: screenWidth * 0.43,
              height: screenHeight * 0.045,
              left: screenWidth * 0.29,
              top: screenHeight * 0.08,
              child: Image.asset("assets/logo/logo.png"),
            ),
            Positioned(
              width: screenWidth * 0.55,
              height: screenHeight * 0.22,
              left: screenWidth * -0.16,
              top: screenHeight * 0.08,
              child: Image.asset("assets/splash/left corner.png"),
            ),

            // WHITE CONTENT
            Positioned.fill(
              top: screenHeight * 0.21,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.045,
                  screenHeight * 0.03,
                  screenWidth * 0.045,
                  screenHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        height: 1.2,
                        fontFamily: FontFamily.appFontFamily,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // DESCRIPTION
                    Text(
                      "We've sent a 4-digit code to your email\nEnter it below to reset your password",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.appFontFamily,
                        height: 2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // OTP BOXES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OtpBox(
                          controller: d1,
                          focusNode: f1,
                          onChanged: (v) => _onOtpChanged(v, 1),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        OtpBox(
                          controller: d2,
                          focusNode: f2,
                          onChanged: (v) => _onOtpChanged(v, 2),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        OtpBox(
                          controller: d3,
                          focusNode: f3,
                          onChanged: (v) => _onOtpChanged(v, 3),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        OtpBox(
                          controller: d4,
                          focusNode: f4,
                          onChanged: (v) => _onOtpChanged(v, 4),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // CONFIRM BUTTON
                    SizedBox(
                      height: screenHeight * 0.06,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/createpassword');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.tealColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: screenWidth * 0.043,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

