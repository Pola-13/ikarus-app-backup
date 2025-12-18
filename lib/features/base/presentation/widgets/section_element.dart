import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

//this widget used at the more page to define the sections
class SectionElement extends StatelessWidget {
  final String title;
  final Widget page;
  final VoidCallback? onTap;

  const SectionElement({
    super.key,
    required this.title,
    required this.page,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
      child: Container(
        height: screenHeight * 0.066,
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.007,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: const Color(0xFFC6D9A7),
            width: screenWidth * 0.002,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.0008,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.038,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.appFontFamily,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.netural600Color,
            size: screenWidth * 0.06,
          ),


        ),
      ),
    );
  }
}
