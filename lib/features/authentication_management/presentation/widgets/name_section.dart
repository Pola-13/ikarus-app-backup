import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/label.dart';

class NameSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const NameSection({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    return Row(
      children: [
        Expanded(
          child: LabeledField(
            label: "First Name",
            hint: "ahmed",
            controller: firstNameController,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: LabeledField(
            label: "Last Name",
            hint: "ali",
            controller: lastNameController,
          ),
        ),
      ],
    );
  }
}
