import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/base/presentation/widgets/languageoption.dart';

void showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      int? selectedLanguage = 1; // 0 = Arabic, 1 = English

      return StatefulBuilder(
        builder: (context, setState) {
          final double screenWidth = Device.deviceWidth(context: context);
          final double screenHeight = Device.deviceHeight(context: context);
          final double fontBase = screenWidth * 0.04;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),

                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: AppColors.netural400Color,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Divider(height: 1, color: AppColors.netural100Color),

                    //  OPTIONS 
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          LanguageOption(
                            index: 0,
                            selectedIndex: selectedLanguage,
                            onTap: () => setState(() => selectedLanguage = 0),
                            iconPath: "assets/icons/saudi.png",
                            title: "العربية",
                          ),

                          LanguageOption(
                            index: 1,
                            selectedIndex: selectedLanguage,
                            onTap: () => setState(() => selectedLanguage = 1),
                            iconPath: "assets/icons/UK.png",
                            title: "English",
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed:
                                  selectedLanguage == null
                                      ? null
                                      : () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              selectedLanguage == 0
                                                  ? "Arabic Selected"
                                                  : "English Selected",
                                            ),
                                          ),
                                        );
                                      },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontBase + 1,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.appFontFamily,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
