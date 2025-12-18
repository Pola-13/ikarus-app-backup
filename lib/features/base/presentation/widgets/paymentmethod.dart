import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

// this widget used to choose the payment method is it Mobile Wallet or Credit Card

void showPaymentMethodSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      int? selectedMethod;
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);


      return StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenHeight * 0.02,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Payment Method",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.netural400Color,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: AppColors.netural100Color),
              // Payment Options
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    paymentOption(
                      context,
                      index: 0,
                      selectedIndex: selectedMethod,
                      onTap: () => setState(() => selectedMethod = 0),
                      iconPath: "assets/navbar/Wallet.png",
                      title: "Mobile Wallet",
                    ),

                    paymentOption(
                      context,
                      index: 1,
                      selectedIndex: selectedMethod,
                      onTap: () => setState(() => selectedMethod = 1),
                      iconPath: "assets/icons/Credit-Card.png",
                      title: "Credit Card",
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.tealColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            selectedMethod == null
                                ? null
                                : () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        selectedMethod == 0
                                            ? "Mobile Wallet Selected"
                                            : "Credit Card Selected",
                                      ),
                                    ),
                                  );
                                },
                        child: const Text(
                          "Pay",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // Pay Button
            ],
          );
        },
      );
    },
  );
}

//  payment option card
Widget paymentOption(
  BuildContext context, {
  required int index,
  required int? selectedIndex,
  required VoidCallback onTap,
  String? iconPath,
  IconData? icon,
  Color? iconColor,
  required String title,
}) {
  bool isSelected = selectedIndex == index;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isSelected
                  ? AppColors.tealColor
                  : const Color.fromARGB(255, 176, 182, 60).withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                iconPath != null
                    ? Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(iconPath, fit: BoxFit.contain),
                    )
                    : Icon(icon, color: iconColor ?? Colors.black54),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: FontFamily.appFontFamily,
                  ),
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
          Container(
            width: 22,
            height: 22,
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
                        width: 10,
                        height: 10,
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
  );
}
