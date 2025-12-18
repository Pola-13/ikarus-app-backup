import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/features/base/presentation/widgets/filter.dart';

class StationSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double screenWidth;
  final double screenHeight;
  final Function(String) onChanged;

  const StationSearchBar({
    super.key,
    required this.controller,
    required this.screenWidth,
    required this.screenHeight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
          //  SEARCH FIELD
          Expanded(
            child: Container(
              height: screenHeight * 0.054,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.035),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: "Search by Station name or address",
                  hintStyle: TextStyle(fontSize: screenWidth * 0.035),
                  prefixIcon: Icon(
                    Icons.search,
                    size: screenWidth * 0.06,
                    color: Colors.black54,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.025),

          //  FILTER ICON
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const FilterSheet(),
              );
            },
            borderRadius: BorderRadius.circular(screenWidth * 0.035),
            child: Container(
              height: screenHeight * 0.055,
              width: screenHeight * 0.055,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.035),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Image.asset(
                  'assets/icons/Filter.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
