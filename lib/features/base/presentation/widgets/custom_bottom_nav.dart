import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(
                index: 0,
                label: "Stations",
                selected: currentIndex == 0,
                icon: "assets/navbar/unselected_station.png",
                selectedIcon: "assets/navbar/stations.png",
              ),
              _buildItem(
                index: 1,
                label: "Wallet",
                selected: currentIndex == 1,
                icon: "assets/navbar/unselected_Wallet.png",
                selectedIcon: "assets/navbar/Wallet.png",
              ),
              _buildItem(
                index: 2,
                label: "Sessions",
                selected: currentIndex == 2,
                icon: "assets/navbar/unselected_Sessions.png",
                selectedIcon: "assets/navbar/Sessions.png",
              ),
              _buildItem(
                index: 3,
                label: "More",
                selected: currentIndex == 3,
                icon: "assets/navbar/unselected_more.png",
                selectedIcon: "assets/navbar/more.png",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required int index,
    required String label,
    required bool selected,
    required String icon,
    required String selectedIcon,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            selected ? selectedIcon : icon,
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color:
                  selected ? AppColors.tealColor : AppColors.netural600Color,
            ),
          ),
        ],
      ),
    );
  }
}
