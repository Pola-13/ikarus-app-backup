  import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget dot(Color color) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  static Widget featureIcon(String path) {
    return Image.asset(
      path,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
    );
  }
}
