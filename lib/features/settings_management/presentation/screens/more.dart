import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/more_appbar.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/url.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/aboutus.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/chanepassword.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/faq.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/language.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/notifications.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/personalinfo.dart';
import 'package:ikarusapp/features/settings_management/presentation/screens/privacy_policy.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/features/base/presentation/widgets/custom_bottom_nav.dart';
import 'package:ikarusapp/features/base/presentation/widgets/section_element.dart';
import 'package:ikarusapp/features/base/presentation/widgets/section_header.dart';
import 'package:ikarusapp/features/base/presentation/widgets/socialmedia_Icon.dart';
import 'package:ikarusapp/features/base/presentation/widgets/version_text.dart';

final social = SocialMedia();

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: moreAppBar(context), // AppBar
        body: Container(
          margin: EdgeInsets.only(top: 120),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //  MY INFO
                SectionHeader(
                  title: "My Info",
                  iconPath: "assets/icons/myifon.png",
                ),
                SectionElement(
                  title: "Manage Personal Info",
                  page: ManagePersonalInfoPage(),
                ),
                SectionElement(
                  title: "Notifications",
                  page: NotificationsPage(),
                ), // SETTINGS
                SectionHeader(
                  title: "Settings",
                  iconPath: "assets/icons/settings.png",
                ),
                SectionElement(
                  title: "Change Password",
                  page: ChangePasswordPage(),
                ),
                SectionElement(
                  title: "Language",
                  page: SizedBox(),
                  onTap: () => showLanguageSheet(context),
                ),
                // APP INFO
                SectionHeader(
                  title: "App Info",
                  iconPath: "assets/icons/appinfo.png",
                ),
                SectionElement(title: "About Us", page: AboutUsPage()),
                SectionElement(
                  title: "Privacy Policy",
                  page: PrivacyPolicyPage(),
                ),
                SectionElement(title: "FAQ", page: FAQPage()),
                SizedBox(height: screenHeight * 0.01),

                SectionHeader(
                  title: "Contact Us",
                  iconPath: "assets/logo/minilogo.png",
                ),
                SizedBox(height: screenHeight * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SocialIcon(
                      imagePath: "assets/socialmedia/call.png",
                      url: social.call,
                    ),
                    SocialIcon(
                      imagePath: "assets/socialmedia/mail.png",
                      url: social.ikarusMail,
                    ),
                    SocialIcon(
                      imagePath: "assets/socialmedia/whatsup.png",
                      url: social.whatsupUrl,
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),

                //  follow us
                SectionHeader(
                  title: "Follow Us",
                  iconPath: "assets/logo/minilogo.png",
                ),
                SizedBox(height: screenHeight * 0.01),

                //SOCAIL MEDIA ICONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SocialIcon(
                      imagePath: "assets/socialmedia/facebook.png",
                      url: social.facebookUrl,
                    ),
                    SocialIcon(
                      imagePath: "assets/socialmedia/instgram.png",
                      url: social.instagramUrl,
                    ),
                    SocialIcon(
                      imagePath: "assets/socialmedia/linkenin.png",
                      url: social.linkedinUrl,
                    ),
                    SocialIcon(
                      imagePath: "assets/socialmedia/tiktok.png",
                      url: social.tikTok,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                //APP VERSION
                VersionText(version: "0.0.8"),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
