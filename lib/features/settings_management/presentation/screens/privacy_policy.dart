import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Privacy Policy"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03,
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/logo/greenlogo.png",
                  width: screenWidth * 0.4,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.03),

                Text(
                  "Privacy Policy ",
                  style: TextStyle(
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.w800,
                    fontFamily: FontFamily.appFontFamily,
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                Text(
                  "Ikarus Electric for Electric Vehicles Services built the Ikarus Grid app as a Free app. This SERVICE is provided by Ikarus Electric for Electric Vehicles Services at no cost and is intended for use as is..\n\n"
                  "This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\n\n"
                  "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\n "
                  "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Ikarus Grid unless otherwise defined in this Privacy Policy.\n",
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    height: 1.5,
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.appFontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),

                SizedBox(height: screenHeight * 0.015),

                Text(
                  "Information Collection and Use\n ",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w800,
                    fontFamily: FontFamily.appFontFamily,
                    color: AppColors.primaryColor,
                  ),
                ),

                Text(
                  "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.\n\n"
                  "The app does use third party services that may collect information used to identify you.\n\nLink to privacy policy of third party service providers used by the app\n\nApp Store \n\n",
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    height: 1.5,
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.appFontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),

                SizedBox(height: screenHeight * 0.015),

                headline(context, "Log Data\n "),
                description(
                  context,
                  "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Cookies\n"),
                description(
                  context,
                  "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\n\n"
                  "This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Service Providers\n "),
                description(
                  context,
                  "We may employ third-party companies and individuals due to the following reasons:\n\n"
                  "To facilitate our Service;\n\n"
                  "To provide the Service on our behalf;\n\n"
                  "To perform Service-related services; or\n\n"
                  "To assist us in analyzing how our Service is used.\n\n"
                  "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Security\n "),
                description(
                  context,
                  "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Links to Other Sites\n"),
                description(
                  context,
                  "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Children’s Privacy\n"),
                description(
                  context,
                  "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.\n",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Changes to This Privacy Policy\n"),
                description(
                  context,
                  "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page\n"
                  "\nThis policy is effective as of 2030-12-01",
                ),
                SizedBox(height: screenHeight * 0.015),
                headline(context, "Contact Us\n"),
                description(
                  context,
                  "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at dev@ikaruselectric.com.",
                ),
                SizedBox(height: screenHeight * 0.07),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget description(BuildContext context, String text) {
  final double screenWidth = Device.deviceWidth(context: context);

  return Text(
    text,
    style: TextStyle(
      fontSize: screenWidth * 0.038,
      height: 1.5,
      color: AppColors.primaryColor,
      fontFamily: FontFamily.appFontFamily,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    textAlign: TextAlign.start,
    softWrap: true,
  );
}

Widget headline(BuildContext context, String text) {
  final double screenWidth = Device.deviceWidth(context: context);

  return Text(
    text,
    style: TextStyle(
      fontSize: screenWidth * 0.04,
      fontWeight: FontWeight.w800,
      fontFamily: FontFamily.appFontFamily,
      color: AppColors.primaryColor,
    ),

    textAlign: TextAlign.start,
    softWrap: true,
  );
}
