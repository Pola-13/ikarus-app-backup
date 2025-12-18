import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/label.dart';

class CarModelSection extends StatelessWidget {
  final TextEditingController carModelController;

  const CarModelSection({
    super.key,
    required this.carModelController,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: "Car Model",
      hint: "Nissan Sunny 2016",
      controller: carModelController,
    );
  }
}
