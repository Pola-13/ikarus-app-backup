import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    return SafeArea(
      top: true,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image to click
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.sessionshistory);
                },
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: Image.asset(
                    "assets/icons/nosessions.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
