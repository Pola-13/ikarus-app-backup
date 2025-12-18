
import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

//this widget used at the sign up to choose the country & governorate and the district
class DropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const DropdownField({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            height: 1.3,
            fontFamily: FontFamily.appFontFamily,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          decoration: BoxDecoration(
            color: AppColors.neutral50Color,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hint,
                style: TextStyle(
                  color: AppColors.netural600Color,
                  fontSize: screenWidth * 0.035,
                  fontFamily: FontFamily.appFontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              isExpanded: true,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
