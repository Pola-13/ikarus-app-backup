import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';

class VersionText extends StatelessWidget {
  final String version;

  const VersionText({
    super.key,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Version $version",
        style: const TextStyle(
          color: AppColors.tealColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
