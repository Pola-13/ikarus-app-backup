import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';

// this widget used at the filter icon to choose the charger type & the power  
class IconCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  final double screenWidth;
  final double screenHeight;

  final bool enabled;

  const IconCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.screenWidth,
    required this.screenHeight,
    this.enabled = true,   // default enabled
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(!value) : null,   // DISABLE TAPS
      child: Opacity(
        opacity: enabled ? 1.0 : 0.35,                   // DIM WHEN DISABLED
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.004),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
                margin: EdgeInsets.only(right: screenWidth * 0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.015),
                  border: Border.all(
                    color: value
                        ? AppColors.tealColor
                        : AppColors.netural600Color,
                    width: 2,
                  ),
                  color: value ? AppColors.tealColor : Colors.transparent,
                ),
                child: value
                    ? Icon(
                        Icons.check,
                        color: AppColors.yellowGreenColor,
                        size: screenWidth * 0.045,
                      )
                    : null,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
