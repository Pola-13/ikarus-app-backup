import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';

class TransactionCard extends StatelessWidget {
  final Map<String, dynamic> tx;
  const TransactionCard(this.tx, {super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    // 4-STATUS LOGIC 
    late Color statusColor;
    late String iconAsset;

    switch (tx["status"]) {
      case "Successful":
        statusColor = AppColors.statusGreenColor;
        iconAsset = "assets/card/successful.png";
        break;

      case "Failed":
        statusColor = AppColors.statusRedColor;
        iconAsset = "assets/card/failed.png";
        break;

      case "Gift":
        statusColor = AppColors.statusGreenColor;
        iconAsset = "assets/card/gift.png"; 
        break;

      case "Deducted":
        statusColor = Color(0xff0088ff);
        iconAsset = "assets/card/deducted.png"; 
        break;

      // default:
      //   statusColor = AppColors.netural400Color;
      //   iconAsset = "assets/card/other.png"; 
    }

    return Container(
      height: screenHeight * 0.115,
      margin: EdgeInsets.only(bottom: screenHeight * 0.012),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.netural100Color, width: 1.5),
        boxShadow: [
          // ignore: deprecated_member_use
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          // Status Icon
          Container(
            width: screenWidth * 0.13,
            height: screenWidth * 0.13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neutral50Color,
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: Image.asset(iconAsset, fit: BoxFit.contain),
            ),
          ),

          SizedBox(width: screenWidth * 0.03),

          // Info section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //amount
                    Text(
                      "${tx['amount']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),

                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.025,
                        vertical: screenHeight * 0.004,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tx["status"],
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                //description
                Text(
                  tx["desc"],
                  style: TextStyle(
                    color: AppColors.neutral800Color,
                    fontSize: 12,
                  ),
                ),
                //date
                Text(
                  tx["date"],
                  style: TextStyle(
                    color: AppColors.netural600Color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
