import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/features/base/presentation/widgets/deleteaccount.dart';
import 'package:ikarusapp/features/base/presentation/widgets/logout.dart';

// Reused signup widgets
import 'package:ikarusapp/features/authentication_management/presentation/widgets/name_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/phone_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/dropdown_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/car_model_section.dart';

class ManagePersonalInfoPage extends StatefulWidget {
  const ManagePersonalInfoPage({super.key});

  @override
  State<ManagePersonalInfoPage> createState() =>
      _ManagePersonalInfoPageState();
}

class _ManagePersonalInfoPageState extends State<ManagePersonalInfoPage> {
  // ---------------- IMAGE ----------------
  File? _profileImage;

  // ---------------- CONTROLLERS ----------------
  final _firstNameCtrl = TextEditingController(text: "Ahmed");
  final _lastNameCtrl = TextEditingController(text: "Ali");
  final _emailCtrl = TextEditingController(text: "Ahmed@gmail.com");
  final _phoneCtrl = TextEditingController(text: "1206018529");
  final _carModelCtrl = TextEditingController(text: "Nissan Sunny 2016");

  // ---------------- DROPDOWN STATE ----------------
  String? _selectedCountry = "egypt";
  String? _selectedGovernorate = "cairo";
  String? _selectedDistrict = "mokatam";

  // ---------------- IMAGE PICK ----------------
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint("IMAGE PICK ERROR: $e");
    }
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _carModelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Manage Personal Info"),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            children: [
              avatarSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.04),

              // -------- NAME --------
              NameSection(
                firstNameController: _firstNameCtrl,
                lastNameController: _lastNameCtrl,
              ),
              SizedBox(height: screenHeight * 0.025),

              // -------- EMAIL --------
              _emailField(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.025),

              // -------- PHONE --------
              PhoneSection(phoneController: _phoneCtrl),
              SizedBox(height: screenHeight * 0.025),

              // -------- LOCATION --------
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

              // -------- CAR MODEL --------
              CarModelSection(carModelController: _carModelCtrl),
              SizedBox(height: screenHeight * 0.05),

              // -------- ACTIONS --------
              LogoutButton(),
              SizedBox(height: screenHeight * 0.02),
              DeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- AVATAR ----------------
  Widget avatarSection(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        GestureDetector(
          onTap: showPhotoOptions,
          child: Container(
            width: screenWidth * 0.26,
            height: screenWidth * 0.26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEAF5F7),
            ),
            clipBehavior: Clip.hardEdge,
            child: _profileImage == null
                ? const Icon(
                    Icons.person,
                    size: 55,
                    color: Color(0xFF6AA9AF),
                  )
                : Image.file(_profileImage!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: showPhotoOptions,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                Icons.edit,
                size: screenWidth * 0.035,
                color: AppColors.tealColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- EMAIL FIELD ----------------
  Widget _emailField(double screenWidth, double screenHeight) {
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
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.neutral50Color,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- IMAGE OPTIONS ----------------
  void showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Change Profile Photo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.photo, color: Colors.teal),
                  title: const Text("Choose from Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
