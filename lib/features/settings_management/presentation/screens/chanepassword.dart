import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/settings_management/presentation/widgets/passwordfield.dart';
import 'package:ikarusapp/features/base/presentation/widgets/confirmpassword.dart';
import 'package:ikarusapp/features/base/presentation/widgets/password_success.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldCtrl = TextEditingController();
  final TextEditingController _newCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // MATCH + BUTTON ENABLE LOGIC 
  bool get _passwordsMatch =>
      _newCtrl.text.isNotEmpty && _newCtrl.text == _confirmCtrl.text;

  bool get _canSubmit => _passwordsMatch;

  @override
  Widget build(BuildContext context) {
    final screenHeight = Device.deviceHeight(context: context);
    final screenWidth = Device.deviceWidth(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Change Password"),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.appFontFamily,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
            
              Text(
                "Enter your old password and set new one",
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  color: AppColors.neutral800Color,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              //  OLD PASSWORD 
              Text(
                "Your Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 6),
              PasswordField(
                controller: _oldCtrl,
                obscureText: _obscureOld,
                hint: "Your password",
                onToggle: () {
                  setState(() {
                    _obscureOld = !_obscureOld;
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              //  NEW PASSWORD 
              Text(
                "New Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 6),
              PasswordField(
                controller: _newCtrl,
                obscureText: _obscureNew,
                hint: "Your password",
                onToggle: () {
                  setState(() {
                    _obscureNew = !_obscureNew;
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              //  CONFIRM PASSWORD 
              Text(
                "Confirm New Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 6),

              ConfirmPasswordField(
                newPasswordController: _newCtrl, // new password field
                confirmController: _confirmCtrl,
                obscureText: _obscureConfirm,
                onToggleVisibility: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
                onChanged: (_) => setState(() {}),
              ),

              SizedBox(height: screenHeight * 0.04),

              //  CHANGE BUTTON 
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                  ),
                
                  onPressed:
                      _canSubmit
                          ? () {
                            showPasswordSuccessSheet(context);
                          }
                          : null,
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: FontFamily.appFontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
