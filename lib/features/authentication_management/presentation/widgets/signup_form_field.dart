import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/car_model_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/dropdown_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/name_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/phone_section.dart';

class SignupFormFields extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const SignupFormFields({super.key, required this.scrollController});

  @override
  ConsumerState<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends ConsumerState<SignupFormFields> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  String? _selectedCountry;
  String? _selectedGovernorate;
  String? _selectedDistrict;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _carModelController.dispose();

    super.dispose();
  }

  // final _firstNameCtrl = TextEditingController();
  // final _lastNameCtrl = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  // String? _selectedCountry;
  // String? _selectedGovernorate;
  // String? _selectedDistrict;

  // class _SignupFormFieldsState extends State<SignupFormFields> {
  //   @override
  //   void dispose() {
  //     _firstNameCtrl.dispose();
  //     _lastNameCtrl.dispose();
  //     _emailController.dispose();
  //     _phoneController.dispose();

  //     super.dispose();
  //   }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return ListView(
      controller: widget.scrollController,
      children: [
        //  TITLE
        Text(
          "Sign Up",
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
            fontFamily: FontFamily.appFontFamily,
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        //  NAME SECTION
        NameSection(
          firstNameController: _firstNameCtrl,
          lastNameController: _lastNameCtrl,
        ),

        SizedBox(height: screenHeight * 0.02),

        //  EMAIL FIELD
        _emailField(screenWidth, screenHeight, _emailController),
        SizedBox(height: screenHeight * 0.02),

        //  PHONE SECTION
        PhoneSection(phoneController: _phoneController),
        SizedBox(height: screenHeight * 0.02),

        //  DROPDOWN SECTION
        DropdownSection(
          selectedCountry: _selectedCountry,
          selectedGovernorate: _selectedGovernorate,
          selectedDistrict: _selectedDistrict,
          onCountryChanged: (val) {
            setState(() {
              _selectedCountry = val;
              _selectedGovernorate = null;
              _selectedDistrict = null;
            });
          },
          onGovernorateChanged: (val) {
            setState(() => _selectedGovernorate = val);
          },
          onDistrictChanged: (val) {
            setState(() => _selectedDistrict = val);
          },
        ),
        SizedBox(height: screenHeight * 0.03),

        //  CAR MODEL
        CarModelSection(carModelController: _carModelController),
        SizedBox(height: screenHeight * 0.03),

        //  SIGN UP BUTTON
        _signUpButton(screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.02),

        //  DIVIDER
        _divider(screenWidth),
        SizedBox(height: screenHeight * 0.02),

        //  GOOGLE BUTTON
        _googleButton(screenWidth, screenHeight),
        SizedBox(height: screenHeight * 0.10),

        //  LOGIN FOOTER
        _loginFooter(screenWidth, screenHeight),
      ],
    );
  }

  // EMAIL FIELD
  Widget _emailField(
    double screenWidth,
    double screenHeight,
    TextEditingController emailController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontSize: screenWidth * 0.042,
            fontFamily: FontFamily.appFontFamily,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "email@email.com",
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide(color: AppColors.tealColor, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }

  // SIGN UP BUTTON
  Widget _signUpButton(double screenWidth, double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.06,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ref
              .read(signupViewModelProvider.notifier)
              .validateSignUpUser(
                email: _emailController.text.trim(),
                firstName: _firstNameCtrl.text.trim(),
                lastName: _lastNameCtrl.text.trim(),
                phoneE164: "+20${_phoneController.text.trim()}",
                country: _selectedCountry ?? "",
                city: _selectedGovernorate ?? "",
                street: _selectedDistrict ?? "",
                postalCode: "", // add later if needed
              );

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          elevation: 0,
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: screenWidth * 0.041,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // DIVIDER "OR"
  Widget _divider(double screenWidth) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 2, color: Color(0xFFE8E8E8))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Text(
            "Or",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: screenWidth * 0.035,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 2, color: Color(0xFFE8E8E8))),
      ],
    );
  }

  // GOOGLE BUTTON
  Widget _googleButton(double screenWidth, double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.065,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
    );
  }

  // LOGIN FOOTER

  Widget _loginFooter(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Text(
          "Already have account?",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: screenWidth * 0.038,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.06,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.selectedItemColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
            ),
            child: Text(
              "Login",
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
    );
  }
}
