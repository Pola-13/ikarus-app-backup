import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/signup_form_field.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/signup_header.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.tealColor,
        body: Stack(
          children: [
            const SignupHeader(),
            buildBottomSheet(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheet(double screenWidth, double screenHeight) {
    return DraggableScrollableSheet(
      initialChildSize: 0.81,
      minChildSize: 0.81,
      maxChildSize: 0.92,
      builder: (context, controller) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.045,
            screenHeight * 0.015,
            screenWidth * 0.045,
            screenHeight * 0.03,
          ),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(screenWidth * 0.06),
            ),
          ),
          child: SignupFormFields(scrollController: controller),
        );
      },
    );
  }
}
