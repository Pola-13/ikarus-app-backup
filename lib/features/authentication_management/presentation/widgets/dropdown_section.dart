import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/dropdowmmenu.dart';

class DropdownSection extends StatelessWidget {
  final String? selectedCountry;
  final String? selectedGovernorate;
  final String? selectedDistrict;

  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<String?> onDistrictChanged;

  const DropdownSection({
    super.key,
    required this.selectedCountry,
    required this.selectedGovernorate,
    required this.selectedDistrict,
    required this.onCountryChanged,
    required this.onGovernorateChanged,
    required this.onDistrictChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownField(
          label: "Country",
          hint: "Egypt",
          value: selectedCountry,
          items: const [
            DropdownMenuItem(value: "egypt", child: Text("Egypt")),
            DropdownMenuItem(value: "uae", child: Text("UAE")),
            DropdownMenuItem(value: "ksa", child: Text("Saudi Arabia")),
          ],
          onChanged: onCountryChanged,
        ),

        const SizedBox(height: 15),

        DropdownField(
          label: "Governorate",
          hint: "Cairo",
          value: selectedGovernorate,
          items: const [
            DropdownMenuItem(value: "cairo", child: Text("Cairo")),
            DropdownMenuItem(value: "giza", child: Text("Giza")),
            DropdownMenuItem(value: "alex", child: Text("Alexandria")),
          ],
          onChanged: onGovernorateChanged,
        ),

        const SizedBox(height: 15),

        DropdownField(
          label: "District",
          hint: "Mokatam",
          value: selectedDistrict,
          items: const [
            DropdownMenuItem(value: "mokatam", child: Text("Mokatam")),
            DropdownMenuItem(value: "nasr", child: Text("Nasr City")),
            DropdownMenuItem(value: "heliopolis", child: Text("Heliopolis")),
          ],
          onChanged: onDistrictChanged,
        ),
      ],
    );
  }
}
