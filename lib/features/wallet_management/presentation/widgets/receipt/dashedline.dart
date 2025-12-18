import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedLine({
    super.key,
    this.height = 1,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.color = const Color(0xFFE5E5E5),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final dashCount = (width / (dashWidth + dashSpace)).floor();

        return Row(
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: height,
              margin: EdgeInsets.only(right: dashSpace),
              color: color,
            );
          }),
        );
      },
    );
  }
}
