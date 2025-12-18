import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/features/base/presentation/widgets/deleteaccount.dart';
import 'package:ikarusapp/features/base/presentation/widgets/logout.dart';

// Reused signup widgets
import 'package:ikarusapp/features/authentication_management/presentation/widgets/readonly_name_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/readonly_email_field.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/readonly_phone_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/readonly_location_section.dart';
import 'package:ikarusapp/features/authentication_management/presentation/widgets/car_model_section.dart';

class ManagePersonalInfoPage extends ConsumerStatefulWidget {
  const ManagePersonalInfoPage({super.key});

  @override
  ConsumerState<ManagePersonalInfoPage> createState() =>
      _ManagePersonalInfoPageState();
}

class _ManagePersonalInfoPageState extends ConsumerState<ManagePersonalInfoPage> {
  // ---------------- IMAGE ---------------- 
  File? _profileImage;

  // ---------------- CONTROLLERS ----------------
  final _carModelCtrl = TextEditingController();

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
  void initState() {
    super.initState();
    // Load profile data when page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).loadProfile();
    });
  }

  @override
  void dispose() {
    _carModelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);
    final profileState = ref.watch(profileViewModelProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Manage Personal Info"),
        body: profileState.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
                ),
              )
            : profileState.error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          profileState.error!,
                          style: TextStyle(color: AppColors.statusRedColor),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(profileViewModelProvider.notifier).loadProfile();
                          },
                          child: Text("Retry"),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    child: Column(
                      children: [
                        avatarSection(screenWidth, screenHeight),
                        SizedBox(height: screenHeight * 0.04),

                        // -------- NAME --------
                        ReadOnlyNameSection(
                          firstName: profileState.profile?.customer?.firstName ?? "",
                          lastName: profileState.profile?.customer?.lastName ?? "",
                        ),
                        SizedBox(height: screenHeight * 0.025),

                        // -------- EMAIL --------
                        ReadOnlyEmailField(
                          email: profileState.profile?.customer?.email ?? "",
                        ),
                        SizedBox(height: screenHeight * 0.025),

                        // -------- PHONE --------
                        ReadOnlyPhoneSection(
                          phoneNumber: profileState.profile?.customer?.phoneE164 ?? "",
                        ),
                        SizedBox(height: screenHeight * 0.025),

                        // -------- LOCATION --------
                        ReadOnlyLocationSection(
                          country: profileState.profile?.customer?.country,
                          city: profileState.profile?.customer?.city,
                          district: profileState.profile?.customer?.district,
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
