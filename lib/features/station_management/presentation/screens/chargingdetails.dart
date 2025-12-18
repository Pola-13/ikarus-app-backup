import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class ChargingDetails extends StatefulWidget {
  const ChargingDetails({super.key});

  @override
  State<ChargingDetails> createState() => _ChargingDetailsState();
}

class _ChargingDetailsState extends State<ChargingDetails> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Zahraa Almaadai Station"),

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),

              // STATION NAME + COMPLETED BADGE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Zahraa Almaadai Station",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.appFontFamily,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  // COMPLETED STATUS BADGE
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.035,
                      vertical: screenHeight * 0.004,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: AppColors.statusGreenColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: AppColors.statusGreenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.005),

              // STATION LOCATION
              Text(
                "55 Zahraa Almaadai, Cairo 78239",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.netural600Color,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // CHARGING DETAILS CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.netural100Color,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Charging Details",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    _detailRow(context, "Date", "7 Aug 2025"),
                    _detailRow(context, "Start In", "08:12 Pm"),
                    _detailRow(context, "End In", "10:12 Pm"),
                    _detailUnitRow(context, "Energy Charged", "42", "KWH"),
                    _detailRow(context, "Duration", "01:12:56"),
                    _detailUnitRow(context, "Idle Fees", "12", "EGP"),
                    _detailUnitRow(context, "Cost", "206.39", "EGP"),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.15),
            ],
          ),
        ),

        // VIEW RECEIPT BUTTON
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.03,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          child: SizedBox(
            height: screenHeight * 0.055,
            width: screenWidth * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.tealColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.viewreceipt);
              },
              child: Text(
                "View Receipt",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(BuildContext context, String title, String value) {
    final double screenWidth = Device.deviceWidth(context: context);

    // SPLIT TIME INTO NUMBER 
    String numberPart = value;
    String unitPart = "";

    if (value.contains("Pm") || value.contains("pm")) {
      numberPart = value.replaceAll(" Pm", "").replaceAll(" pm", "");
      unitPart = "Pm";
    } else if (value.contains("Am") || value.contains("am")) {
      numberPart = value.replaceAll(" Am", "").replaceAll(" am", "");
      unitPart = "Am";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black87,
            ),
          ),

          // RIGHT SIDE VALUE
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: numberPart,
                  style: TextStyle(
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                if (unitPart.isNotEmpty)
                  TextSpan(
                    text: " $unitPart",
                    style: TextStyle(
                      fontSize: screenWidth * 0.037,
                      fontWeight: FontWeight.w600,
                      color: AppColors.netural600Color, // GRAY
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ROW WITH UNIT
  Widget _detailUnitRow(
    BuildContext context,
    String title,
    String number,
    String unit,
  ) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black87,
            ),
          ),

          // NUMBER + UNIT
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: TextStyle(
                    fontSize: screenWidth * 0.037,
                    fontWeight: FontWeight.w600,
                    color: AppColors.netural600Color,
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
