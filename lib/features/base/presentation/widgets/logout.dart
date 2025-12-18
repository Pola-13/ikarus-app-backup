import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';

class LogoutButton extends StatelessWidget with BaseViewModel {
  const LogoutButton({super.key});

  Future<void> _showLogoutPopup(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      // ignore: deprecated_member_use
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Center(
              child: Dialog(
                backgroundColor: AppColors.whiteColor,
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      const Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Message
                      const Text(
                        "Are you sure you want to log out?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),

                      const SizedBox(height: 25),

                      // Buttons Row
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  backgroundColor: AppColors.selectedItemColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    color: AppColors.tealColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Logout Button
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  // Close the dialog first
                                  Navigator.pop(context);
                                  
                                  // Call logout API
                                  try {
                                    await ProviderScope.containerOf(context, listen: false)
                                        .read(userProvider.notifier)
                                        .logout();
                                  } catch (e) {
                                    // Log error but continue with navigation
                                    debugPrint('Logout error: $e');
                                  }
                                  
                                  // Navigate to login screen after logout (regardless of API success/failure)
                                  // Use a small delay to ensure dialog is fully closed
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  
                                  // Navigate to login screen
                                  if (AppConstants.navigatorKey.currentContext != null) {
                                    navigateToScreen(
                                      Routes.login,
                                      removeTop: true,
                                    );
                                  } else {
                                    // Fallback: use the context from the widget
                                    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                                      Routes.login,
                                      (route) => false,
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  backgroundColor: AppColors.statusRedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: TextButton(
        onPressed: () => _showLogoutPopup(context),
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
              "Log Out",
              style: TextStyle(
                color: AppColors.statusRedColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset("assets/icons/logout.png", width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
