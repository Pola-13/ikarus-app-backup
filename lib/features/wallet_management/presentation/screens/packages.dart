import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/packageslist.dart';
import 'package:ikarusapp/features/wallet_management/presentation/screens/addfunds.dart';
import 'package:ikarusapp/core/constants/device.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  int? selectedPackage;


  @override
  void initState() {
    super.initState();

    _amountFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);
    final double basePadding = screenWidth * 0.05;
    final double fontBase = screenWidth * 0.04;

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        appBar: buildAppBar(context, "Add Funds"),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.all(basePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  TITLE 
                Text(
                  "Flexible Charging (Free Amount)",
                  style: TextStyle(
                    fontSize: fontBase + 1,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: screenHeight * 0.009),

                //  LABEL 
                Text(
                  "Custom Amount",
                  style: TextStyle(
                    fontSize: fontBase + 1,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: screenHeight * 0.011),

                //  TEXT FIELD 
                TextField(
                  controller: _amountController,
                  focusNode: _amountFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (selectedPackage != null && value.isNotEmpty) {
                      setState(() {
                        selectedPackage = null;
                      });
                    }
                  },
                  style: TextStyle(
                    fontSize: fontBase,
                    color: AppColors.primaryColor,
                    
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Recharge amount",
                    hintStyle: TextStyle(
                      color: AppColors.neutral200Color,
                      fontSize: fontBase,
                    ),
                    filled: true,
                    fillColor: AppColors.neutral50Color,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.018,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.04),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            "EGP",
                            style: TextStyle(
                              color: AppColors.neutral200Color,
                              fontWeight: FontWeight.w600,
                              fontSize: fontBase,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.015),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                //  OR CHOOSE PACKAGE 
                Text(
                  "Or Choose A Package",
                  style: TextStyle(
                    fontSize: fontBase + 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                //  PACKAGE BOXES 
                Column(
                  children:
                      packages.map((pkg) {
                        bool isSelected = selectedPackage == pkg["amount"];

                        // Dim when TextField is focused
                        double opacity = _amountFocusNode.hasFocus ? 0.4 : 1.0;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPackage = pkg["amount"];
                              _amountController.clear();
                              _amountFocusNode.unfocus(); // remove cursor
                            });
                          },
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: opacity,
                            child: Container(
                              height: screenHeight * 0.09,
                              margin: EdgeInsets.only(
                                bottom: screenHeight * 0.015,
                              ),
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? AppColors.tealColor
                                          : const Color(0xFFEEF4E4),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${pkg['amount']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontBase + 2,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.004),
                                      Text(
                                        pkg["desc"],
                                        style: TextStyle(
                                          color: AppColors.neutral800Color,
                                          fontSize: fontBase - 2,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Selection indicator
                                  Container(
                                    width: screenWidth * 0.06,
                                    height: screenWidth * 0.06,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColors.tealColor
                                                : AppColors.netural600Color,
                                        width: 2,
                                      ),
                                    ),
                                    child:
                                        isSelected
                                            ? Center(
                                              child: Container(
                                                width: screenWidth * 0.03,
                                                height: screenWidth * 0.03,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.tealColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            )
                                            : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: AddFunds(),
      ),
    );
  }
}
