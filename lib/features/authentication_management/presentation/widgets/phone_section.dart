import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class PhoneSection extends StatefulWidget {
  final TextEditingController phoneController;
  final String? errorMessage;
  final ValueChanged<String>? onCountryCodeChanged;

  const PhoneSection({
    super.key,
    required this.phoneController,
    this.errorMessage,
    this.onCountryCodeChanged,
  });

  @override
  State<PhoneSection> createState() => _PhoneSectionState();
}

class _PhoneSectionState extends State<PhoneSection> {
  String _selectedCountryCode = "+20"; // Default to Egypt

  final Map<String, String> _countryCodes = {
    "+20": "🇪🇬", // Egypt
    // "+962": "🇯🇴", // Jordan
    // "+965": "🇰🇼", // Kuwait
    // "+966": "🇸🇦", // Saudi Arabia
  };

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone",
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
            fontFamily: FontFamily.appFontFamily,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),

        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                color: AppColors.neutral50Color,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountryCode,
                  isDense: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.03,
                  ),
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  items:
                      _countryCodes.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entry.value,
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                entry.key,
                                style: TextStyle(fontSize: screenWidth * 0.03),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCountryCode = newValue;
                      });
                      widget.onCountryCodeChanged?.call(newValue);
                    }
                  },
                ),
              ),
            ),

            SizedBox(width: screenWidth * 0.03),

            Expanded(
              child: SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(
                  controller: widget.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "1xxxxxxxxx",
                    filled: true,
                    fillColor: AppColors.neutral50Color,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                    errorText: null,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.errorMessage != null)
          Padding(
            padding: EdgeInsets.only(left: 0, top: screenHeight * 0.005),
            child: Text(
              widget.errorMessage!,
              style: TextStyle(
                color: AppColors.statusRedColor,
                fontSize: screenWidth * 0.032,
                fontFamily: FontFamily.appFontFamily,
              ),
            ),
          ),
      ],
    );
  }
}
