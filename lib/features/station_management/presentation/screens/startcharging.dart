import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/station_appbar.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/stopcharg.dart';

class ZahraaStartCharging extends StatefulWidget {
  const ZahraaStartCharging({super.key});

  @override
  State<ZahraaStartCharging> createState() => _ZahraaStartChargingState();
}

class _ZahraaStartChargingState extends State<ZahraaStartCharging> {
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
        appBar: stationAppBar(
          context,
          titleText: "Zahraa Almaadai Station",
          onBack: () {
            Navigator.pushNamed(context, Routes.stations);
          },
        ),

        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              // CHARGING PROGRESS CIRCLE
              SizedBox(
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                child: GradientChargeCircle(
                  // size: screenWidth * 0.60,
                  iconPath: "assets/logo/minilogo.png",
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              Text(
                "My Session",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tealColor,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              // STATION NAME + KWH
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/station/session.png",
                          width: screenWidth * 0.055,
                          height: screenWidth * 0.055,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Zahraa Almaadai 1 (1)",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.appFontFamily,
                          ),
                        ),
                      ],
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "22",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: " Kwh",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w400,
                              color:
                                  AppColors.netural600Color, // your gray color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // CHARGING DETAILS CARD
              Container(
                width: screenWidth * 0.93,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.017,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.neutral200Color,
                    width: 1,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Charging Details",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    _detailRow(
                      context,
                      iconPath: "assets/icons/station/chargingspeed.png",
                      title: "Charging Speed",
                      value: "22 KWH",
                    ),
                    SizedBox(height: screenHeight * 0.005),

                    _detailRow(
                      context,
                      iconPath: "assets/icons/station/energycharged.png",
                      title: "Energy Charged",
                      value: "42 KWH",
                    ),
                    SizedBox(height: screenHeight * 0.005),

                    _detailRow(
                      context,
                      iconPath: "assets/icons/station/duration.png",
                      title: "Duration",
                      value: "24:12:56",
                    ),
                    SizedBox(height: screenHeight * 0.005),

                    _detailRow(
                      context,
                      iconPath: "assets/icons/station/cost.png",
                      title: "Cost",
                      value: "206.39 EGP",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: StopChargingButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.chargingdetails);
          },
        ),
      ),
    );
  }

  Widget _detailRow(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String value,
  }) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    String numberPart = value;
    String unitPart = "";

    if (value.contains("KWH")) {
      numberPart = value.replaceAll(" KWH", "");
      unitPart = "KWH";
    } else if (value.contains("EGP")) {
      numberPart = value.replaceAll(" EGP", "");
      unitPart = "EGP";
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: screenWidth * 0.055,
                height: screenWidth * 0.055,
              ),
              SizedBox(width: screenWidth * 0.025),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.037,
                  fontWeight: FontWeight.w400,
                  color: AppColors.netural600Color,
                ),
              ),
            ],
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: numberPart,
                  style: TextStyle(
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                if (unitPart.isNotEmpty)
                  TextSpan(
                    text: " $unitPart",
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w600,
                      color: AppColors.netural600Color, // GREY
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GradientChargeCircle extends StatelessWidget {
  final String iconPath;

  const GradientChargeCircle({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // CIRCLE - 260
          Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF8FBF4),
            ),
          ),

          // CIRCLE - 220
          Container(
            width: 220,
            height: 220,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEEF4E4),
            ),
          ),

          // CIRCLE - 180
          Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE2EED2),
            ),
          ),

          // ICON + TEXT BELOW
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, width: 52, height: 62),
              const SizedBox(height: 8), // spacing between icon and text
              Text(
                "74%",
                style: TextStyle(
                  color: AppColors.tealColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
