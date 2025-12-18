import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

class Forgetpassword1 extends StatefulWidget {
  const Forgetpassword1({super.key});

  @override
  State<Forgetpassword1> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<Forgetpassword1> {
  final TextEditingController _emailCtrl = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() {
      final valid = RegExp(
        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(_emailCtrl.text);
      setState(() => _isValid = valid);
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Scaffold(
      backgroundColor: AppColors.tealColor,
      body: Stack(
        children: [
          // teal header shapes + logo
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

          // white container
          Positioned.fill(
            top: screenHeight * 0.21,
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                
                  // Email field
                  Text(
                    "Your Email",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                      fontFamily: FontFamily.appFontFamily,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "ex: email@email.com",
                      hintStyle: TextStyle(
                        color: AppColors.netural600Color,
                        fontSize: screenWidth * 0.035,
                        fontFamily: FontFamily.appFontFamily,
                      ),
                      filled: true,
                      fillColor: AppColors.neutral50Color,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.035,
                        vertical: screenHeight * 0.017,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: AppColors.neutral50Color),
                      ),
                      errorText: _emailCtrl.text.isEmpty || _isValid
                          ? null
                          : "Please enter a vaild email address",
                      border: InputBorder.none,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Continue button
                  SizedBox(
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: _isValid
                          ? () {
                              // Navigate to verify email page
                              Navigator.pushNamed(context, '/forgetpass2');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tealColor,
                        disabledBackgroundColor: AppColors.tealColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Send Reset Code",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.appFontFamily,
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
    );
  }
}
