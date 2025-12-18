import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/presentation/entities/user_fields.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/login_view_model.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/base/data/entities/form_error.dart';
import 'package:ikarusapp/features/base/presentation/widgets/app_button.dart';
import 'package:collection/collection.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscure = true;

  final _viewModelProvider =
      StateNotifierProvider<LoginViewModel, BaseState<List<FormError>>>((ref) {
        return LoginViewModel(ref.read(userRepositoryProvider));
      });

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Device.deviceHeight(context: context);
    final double screenWidth = Device.deviceWidth(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.tealColor,
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // Right Corner Decoration
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

              // Main White Section
              Positioned.fill(
                top: screenHeight * 0.20,
                child: Container(
                  width: screenWidth,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            height: 1.2,
                            fontFamily: FontFamily.appFontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Email Label
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontFamily: FontFamily.appFontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.008),

                        // Email Field
                        Consumer(
                          builder: (context, ref, _) {
                            var errors = ref.watch(
                              _viewModelProvider.select((value) => value.data),
                            );

                            return TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "ex: email@email.com",
                                hintStyle: TextStyle(
                                  color: AppColors.netural600Color,
                                  fontSize: screenWidth * 0.035,
                                ),
                                filled: true,
                                fillColor: AppColors.neutral50Color,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.035,
                                  vertical: screenHeight * 0.016,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                errorText:
                                    errors
                                        .firstWhereOrNull(
                                          (error) =>
                                              error.field ==
                                              UserFields.email.field,
                                        )
                                        ?.message,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Password Label
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontFamily: FontFamily.appFontFamily,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.008),

                        // Password Field
                        Consumer(
                          builder: (context, ref, _) {
                            var errors = ref.watch(
                              _viewModelProvider.select((value) => value.data),
                            );

                            return TextFormField(
                              obscureText: _obscure,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Your Password here",
                                hintStyle: TextStyle(
                                  color: AppColors.netural600Color,
                                  fontSize: screenWidth * 0.035,
                                ),
                                filled: true,
                                fillColor: AppColors.neutral50Color,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.035,
                                  vertical: screenHeight * 0.016,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.netural600Color,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                errorText:
                                    errors
                                        .firstWhereOrNull(
                                          (error) =>
                                              error.field ==
                                              UserFields.password.field,
                                        )
                                        ?.message,
                              ),
                            );
                          },
                        ),

                        SizedBox(height: screenHeight * 0.01),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgetpass1');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColors.tealColor,
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.035,
                                fontFamily: FontFamily.appFontFamily,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.015),

                        // Login Button
                        AppButton(
                          text: "Login",
                          screenProvider: _viewModelProvider,
                          isEnabled: true,

                          onPressed: () {
                            ProviderScope.containerOf(context, listen: false)
                                .read(_viewModelProvider.notifier)
                                .validateLoginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                        ),

                        // SizedBox(
                        //   height: screenHeight * 0.06,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       ProviderScope.containerOf(context, listen: false)
                        //           .read(_viewModelProvider.notifier)
                        //           .logIn(
                        //             email: "pola.thabet@ikarus.com",
                        //             password: "Ikarus123!",
                        //           );
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: AppColors.tealColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       elevation: 0,
                        //     ),
                        //     child: Text(
                        //       "Login",
                        //       style: TextStyle(
                        //         fontSize: screenWidth * 0.038,
                        //         fontWeight: FontWeight.w600,
                        //         color: AppColors.whiteColor,
                        //         fontFamily: FontFamily.appFontFamily,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: screenHeight * 0.018),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Color(0xFFE8E8E8)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.025,
                              ),
                              child: Text(
                                "Or",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth * 0.035,
                                  fontFamily: FontFamily.appFontFamily,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFE8E8E8), Colors.white],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.018),

                        // Google Login
                        SizedBox(
                          height: screenHeight * 0.07,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.whiteColor,
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/splash/google.svg",
                                  height: screenHeight * 0.025,
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    color: const Color(0xFF121212),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.appFontFamily,
                                    fontSize: screenWidth * 0.037,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.07),

                        // Sign Up Section
                        Column(
                          children: [
                            Text(
                              "Don't have account ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.035,
                                fontFamily: FontFamily.appFontFamily,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.9,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.35,
                                  ),
                                  backgroundColor: AppColors.selectedItemColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.tealColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.038,
                                    fontFamily: FontFamily.appFontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
