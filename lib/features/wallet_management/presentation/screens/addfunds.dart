import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/presentation/widgets/paymentmethod.dart';

class AddFunds extends StatelessWidget {
  const AddFunds({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);
    final double fontBase = screenWidth * 0.04;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.1,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            height: screenHeight * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.tealColor,
                maximumSize: Size(screenWidth * 0.6, screenHeight * 0.055),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showPaymentMethodSheet(context); 
              },
              child: Text(
                "Add Funds",
                style: TextStyle(
                  fontSize: fontBase + 1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
