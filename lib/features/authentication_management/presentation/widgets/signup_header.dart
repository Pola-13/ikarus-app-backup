import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Stack(
      children: [
        Positioned(
          width: screenWidth * 0.25,
          height: screenHeight * 0.1,
          left: screenWidth * 0.78,
          top: -screenHeight * 0.005,
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
      ],
    );
  }
}
