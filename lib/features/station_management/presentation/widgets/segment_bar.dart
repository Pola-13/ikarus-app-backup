import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/stations.dart';

class SegmentBar extends StatelessWidget {
  final Segment current;
  final Function(Segment) onChange;

  const SegmentBar({super.key, required this.current, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            item("Map", Segment.map),
            item("List", Segment.list),
            item("Favorite", Segment.favorite),
          ],
        ),
      ),
    );
  }

  Widget item(String text, Segment seg) {
    final selected = seg == current;

    return Expanded(
      child: InkWell(
        onTap: () => onChange(seg),
        child: Container(
          alignment: Alignment.center,
          decoration:
              selected
                  ? BoxDecoration(
                    color: AppColors.tealColor,
                    borderRadius: BorderRadius.circular(20),
                  )
                  : null,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.primaryColor,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
