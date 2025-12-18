import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/packages.dart';
import 'package:ikarusapp/features/base/presentation/widgets/transctioncard.dart';
import 'package:ikarusapp/core/constants/device.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);
    final double horizontalMargin = screenWidth * 0.002;
    final double verticalMargin = screenHeight * 0.05;

    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Balance Card
            Container(
              width: double.infinity,
              height: screenHeight * 0.223,
              margin: EdgeInsets.only(
                left: horizontalMargin / 2,
                right: horizontalMargin / 2,
                top: verticalMargin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.tealColor,
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    width: screenWidth * 0.18,
                    child: Image.asset(
                      "assets/card/cardright.png",
                      width: screenWidth * 0.25,
                    ),
                  ),
                  Positioned(
                    left: -screenWidth * 0.02,
                    bottom: -screenHeight * 0.02,
                    width: screenWidth * 0.32,
                    height: screenWidth * 0.32,
                    child: Image.asset("assets/card/cardleft.png"),
                  ),

                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Balance",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "2100.90 EGP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

            //  Transactions Title + Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealColor,
                    foregroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeight * 0.01,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Packages(),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, size: screenWidth * 0.065),
                  label: Text(
                    "Add Funds",
                    style: TextStyle(
                      fontSize: screenWidth * 0.037,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.015),

            //  Transactions List
            ..._transactions.map((tx) => TransactionCard(tx)).toList(),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _transactions = [
  {
    "amount": 100,
    "desc": "Funds Added To Your Wallet",
    "date": "12 Aug · 12:15 PM",
    "status": "Successful",
    "type": "add",
  },
  {
    "amount": 100,
    "desc": "Amount Refunded Back To Your Wallet",
    "date": "12 Aug · 12:15 PM",
    "status": "Failed",
    "type": "add",
  },
  {
    "amount": 50,
    "desc": "Gift Sent To You",
    "date": "13 Aug · 3:20 PM",
    "status": "Gift",
    "type": "add",
  },
  {
    "amount": 200,
    "desc": "Deducted For Subscription",
    "date": "14 Aug · 10:00 AM",
    "status": "Deducted",
    "type": "deduct",
  },
  {
    "amount": 100,
    "desc": "Payment Deducted For Your Charging",
    "date": "12 Aug · 12:15 PM",
    "status": "Successful",
    "type": "deduct",
  },
];
