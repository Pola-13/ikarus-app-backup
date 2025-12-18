

import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';

class NaserCity extends StatelessWidget {
  const NaserCity({super.key});

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
        appBar: buildAppBar(context, "Nasr City Station"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03, 
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
