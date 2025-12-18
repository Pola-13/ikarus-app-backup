import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/base/presentation/widgets/confirmpassword.dart';
import 'package:ikarusapp/features/base/presentation/widgets/passwordrulerow.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<ResetPassword> {
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _showRules = false;

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(() {
      setState(() {
        _showRules = _passwordFocus.hasFocus || _passwordCtrl.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // password rule checks
  bool get _hasMinLen => _passwordCtrl.text.length >= 8;
  bool get _hasUpper => RegExp(r'[A-Z]').hasMatch(_passwordCtrl.text);
  bool get _hasLower => RegExp(r'[a-z]').hasMatch(_passwordCtrl.text);
  bool get _hasDigit => RegExp(r'[0-9]').hasMatch(_passwordCtrl.text);
  bool get _hasSpecial => RegExp(
    r'[!@#\$%^&*(),.?":{}|<>_\-\[\]\\;/+=~`]',
  ).hasMatch(_passwordCtrl.text);

  bool get _allRulesOk =>
      _hasMinLen && _hasUpper && _hasLower && _hasDigit && _hasSpecial;
  bool get _passwordsMatch =>
      _passwordCtrl.text.isNotEmpty && _passwordCtrl.text == _confirmCtrl.text;
  bool get _canSubmit => _allRulesOk && _passwordsMatch;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Scaffold(
      backgroundColor: AppColors.tealColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // ===== HEADER SHAPES (same as Forgetpassword1 & 2) =====
            Positioned(
              width: screenWidth * 0.25,
              height: screenHeight * 0.09,
              left: screenWidth * 0.78,
              top: screenHeight * -0.005,
              child: Image.asset("assets/splash/right corner.png"),
            ),
            Positioned(
              width: screenWidth * 0.43,
              height: screenHeight * 0.045,
              left: screenWidth * 0.29,
              top: screenHeight * 0.08,
              child: Image.asset("assets/logo/logo.png"),
            ),
            Positioned(
              width: screenWidth * 0.55,
              height: screenHeight * 0.22,
              left: screenWidth * -0.16,
              top: screenHeight * 0.08,
              child: Image.asset("assets/splash/left corner.png"),
            ),

            // ===== WHITE CARD =====
            Positioned.fill(
              top: screenHeight * 0.21, // same top as Forgetpassword1
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.045,
                  screenHeight * 0.03,
                  screenWidth * 0.045,
                  screenHeight * 0.03,
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title
                      Text(
                        "Set Your New Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                          height: 1.2,
                          fontFamily: FontFamily.appFontFamily,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Text(
                        "Set a strong password to secure your account\nand complete the reset",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontFamily: FontFamily.appFontFamily,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Password label
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontFamily: FontFamily.appFontFamily,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      // Password field
                      TextFormField(
                        controller: _passwordCtrl,
                        focusNode: _passwordFocus,
                        obscureText: _obscure1,
                        onChanged: (_) => setState(() => _showRules = true),
                        decoration: InputDecoration(
                          hintText: "Your Password ",
                          hintStyle: TextStyle(
                            color: AppColors.netural600Color,
                            fontSize: screenWidth * 0.038,
                            fontFamily: FontFamily.appFontFamily,
                          ),
                          filled: true,
                          fillColor: AppColors.neutral50Color,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.035,
                            vertical: screenHeight * 0.017,
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                () => setState(() => _obscure1 = !_obscure1),
                            icon: Icon(
                              _obscure1
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.netural600Color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Password rules
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child:
                            _showRules
                                ? Column(
                                  key: const ValueKey("rules-visible"),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PasswordRuleRow(
                                      ok: _hasUpper,
                                      text: "At least 1 uppercase letter (A–Z)",
                                    ),
                                    PasswordRuleRow(
                                      ok: _hasLower,
                                      text: "At least 1 lowercase letter (a–z)",
                                    ),
                                    PasswordRuleRow(
                                      ok: _hasDigit,
                                      text: "At least 1 number (0–9)",
                                    ),
                                    PasswordRuleRow(
                                      ok: _hasSpecial,
                                      text:
                                          "At least 1 special character (! @ # \$ % …)",
                                    ),

                                    SizedBox(height: screenHeight * 0.03),
                                  ],
                                )
                                : const SizedBox(key: ValueKey("rules-hidden")),
                      ),

                      // Confirm Password label
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontFamily: FontFamily.appFontFamily,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      // Confirm Password field
                      ConfirmPasswordField(
                        newPasswordController: _passwordCtrl,
                        confirmController: _confirmCtrl,
                        obscureText: _obscure2,
                        onToggleVisibility: () {
                          setState(() => _obscure2 = !_obscure2);
                        },
                        onChanged: (_) => setState(() {}),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Confirm Password button
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed:
                              _canSubmit
                                  ? () {
                                    Navigator.pushNamed(context, '/stations');
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tealColor,
                            disabledBackgroundColor: AppColors.tealColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.appFontFamily,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
