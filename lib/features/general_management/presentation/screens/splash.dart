import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with BaseViewModel {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => _navigate());
  }

  _navigate() {
    var userLoggedIn =
        ProviderScope.containerOf(context).read(userProvider) != null;
    navigateToScreen(
      userLoggedIn ? Routes.root : Routes.login,
      removeTop: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Device.deviceHeight(context: context);
    final double screenWidth = Device.deviceWidth(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.tealColor,
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // Logo
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.065,
                width: screenWidth * 0.47,
                height: screenHeight * 0.05,
                child: Image.asset("assets/logo/logo.png"),
              ),

              // Splash image
              Positioned(
                top: screenHeight * 0.1,
                left: screenWidth * -0.06,
                width: screenWidth * 1.13,
                height: screenWidth * 1.13,
                child: Image.asset("assets/splash/splash.png"),
              ),

              // Text section
              Positioned(
                top: screenHeight * 0.57,
                left: screenWidth * 0.055,
                right: screenWidth * 0.055,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main title
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                            height: 1.5,
                          ),
                          children: const [
                            TextSpan(
                              text: "Charge ",
                              style: TextStyle(
                                color: AppColors.yellowGreenColor,
                              ),
                            ),
                            TextSpan(
                              text: "Up ",
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                            TextSpan(
                              text: "The ",
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                            TextSpan(
                              text: "Future ",
                              style: TextStyle(
                                color: AppColors.yellowGreenColor,
                              ),
                            ),
                            TextSpan(
                              text: "!",
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // Subtitle
                      Text(
                        "Power Your Journey With Smarter, Faster,\nAnd Sustainable EV Charging Everywhere",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.039,
                          height: 1.4,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.appFontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button
              Positioned(
                bottom: screenHeight * 0.04,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                   _navigate();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.whiteColor,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Go",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: AppColors.tealColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.tealColor,
                      ),
                    ],
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
