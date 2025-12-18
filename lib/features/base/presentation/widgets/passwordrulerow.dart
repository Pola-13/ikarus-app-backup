import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';

class PasswordRuleRow extends StatelessWidget {
  final bool ok;
  final String text;

  const PasswordRuleRow({
    super.key,
    required this.ok,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    final Color color = ok ? const Color(0xFF74A42D) : const Color(0xFFE54A4A);
    final IconData icon =
        ok ? Icons.check_circle_outline_rounded : Icons.cancel_rounded;

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.015),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
                color: color,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
