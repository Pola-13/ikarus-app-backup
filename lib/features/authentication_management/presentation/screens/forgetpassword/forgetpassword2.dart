import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/otpbox.dart';

class Forgetpassword2 extends StatefulWidget {
  const Forgetpassword2({super.key});

  @override
  State<Forgetpassword2> createState() => _Forgetpassword2State();
}

class _Forgetpassword2State extends State<Forgetpassword2> {
  // ---- OTP Controllers
  final TextEditingController d1 = TextEditingController();
  final TextEditingController d2 = TextEditingController();
  final TextEditingController d3 = TextEditingController();
  final TextEditingController d4 = TextEditingController();

  // ---- FocusNodes
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

  // ---- Auto move logic
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
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
      // When deleting → go back
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
            // ===== HEADER SHAPES =====
            Positioned(
              width: screenWidth * 0.25,
              height: screenHeight * 0.09,
              left: screenWidth * 0.78,
              top: screenHeight * -0.005,
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

            // ===== WHITE CONTENT CONTAINER =====
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
                    // Title
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

                    // Description
                    Text(
                      "We've sent a 4-digit code to your email\nEnter it below to reset your password",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.appFontFamily,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // OTP Fields Row
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

                    // Confirm Button
                    SizedBox(
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgetpass3');
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


