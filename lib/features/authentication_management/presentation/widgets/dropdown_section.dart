import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/presentation/widgets/dropdowmmenu.dart';

class DropdownSection extends StatelessWidget {
  final String? selectedCountry;
  final String? selectedGovernorate;
  final String? selectedDistrict;
  final String? countryError;
  final String? cityError;
  final String? streetError;

  final ValueChanged<String?> onCountryChanged;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<String?> onDistrictChanged;

  const DropdownSection({
    super.key,
    required this.selectedCountry,
    required this.selectedGovernorate,
    required this.selectedDistrict,
    this.countryError,
    this.cityError,
    this.streetError,
    required this.onCountryChanged,
    required this.onGovernorateChanged,
    required this.onDistrictChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            if (countryError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  countryError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (cityError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  cityError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (streetError != null)
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  top: screenHeight * 0.005,
                ),
                child: Text(
                  streetError!,
                  style: TextStyle(
                    color: AppColors.statusRedColor,
                    fontSize: screenWidth * 0.032,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
