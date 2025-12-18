import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/features/base/presentation/widgets/faq_element.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      top: true,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "FAQ"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.038,
              bottom: screenHeight * 0.1,
            ),
            child: Column(
              children: [
                FaqElement(
                  title: "What is an electric vehicle charging app?",
                  expandedText:
                      "An Electric Vehicle Charging App Is A Mobile Application That Helps EV Owners Find, Access, And Pay For Charging Services For Their Electric Vehicles.",
                ),

                FaqElement(
                  title: "Do I Need A Subscription To Use The App?",
                  expandedText: "No, It's Free To Use.",
                ),

                FaqElement(
                  title:
                      "Do I Need An Internet Connection To Use The App For Charging?",
                  expandedText:
                      "An Internet Connection Is Usually Required To Find And Initiate Charging Sessions.",
                ),

                FaqElement(
                  title: "How Do I Find Charging Stations Using The App?",
                  expandedText:
                      "The App Typically Provides A Map Showing Nearby Charging Stations. You Can Search By Location Or Filter By Station Type, Connector Type, And More.",
                ),

                FaqElement(
                  title:
                      "What Are The Different Connector Types, And How Do I Know Which One I Need For My EV?",
                  expandedText: "no answer ",
                ),

                FaqElement(
                  title: "How Do I Start The Charging Session With The App?",
                  expandedText:
                      "Select The Charge Station Port You Want To Use.\nConnect The Charger Gun To Your Car Socket.\nPress The Start Button On The App To Start The Charging Session.",
                ),

                FaqElement(
                  title: "How Do I Stop A Charging Session With The App?",
                  expandedText:
                      "Open The App; The App Will Open At The Charge Session Page.\nPress The Stop Button, And The Charger Will Stop Charging.\nRemove The Charge Plug And Replace It In The Holder.",
                ),

                FaqElement(
                  title:
                      "What Happens If I Encounter A Problem During A Charging Session?",
                  expandedText:
                      "You Can Contact Us Directly Through Our Hotline 15274.",
                ),

                FaqElement(
                  title:
                      "How Can I Report A Non-Functional Charging Station In The App?",
                  expandedText:
                      "Please Report Any Non-Functional Charger To Us Through The Contact Us Section.",
                ),

                FaqElement(
                  title: "How Much Will A Charge Cost?",
                  expandedText:
                      "Prices Vary Depending On Charger Type: Fast DC Charger Or Slow AC Charger.\nThe Rate Is Charged Per kWh Consumption.\nAll Fees And Costs Are Displayed On Each Charge Station In The App.",
                ),

                FaqElement(
                  title: "How Do I Pay For A Charge Session?",
                  expandedText:
                      "1. To Use Our Services, You Must Have A Valid Credit Card Linked To Your Account.\n2. Each Charge Session Is Charged To Your Credit Card On The App.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
