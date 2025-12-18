import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/custom_bottom_nav.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/receipt.dart';
import 'package:ikarusapp/features/base/presentation/widgets/session_card.dart';

class SessionsHistory extends StatelessWidget {
  const SessionsHistory({super.key});

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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),

              SessionCard(
                date: "7 Aug 2025, 08:12 PM",
                status: "Charging",
                statusColor: Colors.orange,
                stationName: "Zahraa Almaadai Station",
                stationAddress: "55 Zahraa Almaadai, Cairo 78239",
                routeName: Routes.chargingdetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
