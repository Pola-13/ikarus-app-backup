import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  Future<void> _handleDeleteAccount(BuildContext context) async {
    print("Account deleted");
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: TextButton(
        onPressed: () => _handleDeleteAccount(context),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          side: BorderSide(color: Colors.grey.shade400, width: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Delete Account",
              style: TextStyle(
                color: AppColors.statusRedColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset("assets/icons/delete.png", width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
