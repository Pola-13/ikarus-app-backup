import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/presentation/widgets/label.dart';

class NameSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String? firstNameError;
  final String? lastNameError;

  const NameSection({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    this.firstNameError,
    this.lastNameError,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledField(
                label: "First Name",
                hint: "ahmed",
                controller: firstNameController,
              ),
              if (firstNameError != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    top: screenHeight * 0.005,
                  ),
                  child: Text(
                    firstNameError!,
                    style: TextStyle(
                      color: AppColors.statusRedColor,
                      fontSize: screenWidth * 0.032,
                      fontFamily: FontFamily.appFontFamily,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledField(
                label: "Last Name",
                hint: "ali",
                controller: lastNameController,
              ),
              if (lastNameError != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    top: screenHeight * 0.005,
                  ),
                  child: Text(
                    lastNameError!,
                    style: TextStyle(
                      color: AppColors.statusRedColor,
                      fontSize: screenWidth * 0.032,
                      fontFamily: FontFamily.appFontFamily,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
