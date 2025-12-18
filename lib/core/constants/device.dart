import 'package:flutter/material.dart';

class Device {

  static double deviceHeight({
    required BuildContext context,
    double percent = 1,
  }) {
    return MediaQuery.of(context).size.height * percent;
  }

  static double deviceWidth({
    required BuildContext context,
    double percent = 1,
  }) {
    return MediaQuery.of(context).size.width * percent;
  }
}
