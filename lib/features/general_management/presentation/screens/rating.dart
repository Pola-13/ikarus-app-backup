import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/features/general_management/presentation/screens/rating_is_submitted.dart';

class RatingFeedbackSheet extends StatefulWidget {
  const RatingFeedbackSheet({super.key});
  @override
  State<RatingFeedbackSheet> createState() => _RatingFeedbackSheetState();
}

class _RatingFeedbackSheetState extends State<RatingFeedbackSheet> {
  int selectedStars = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  HEADER WITH TITLE + CLOSE BTN
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenHeight * 0.02,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Share Your Feedback",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.appFontFamily,
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.netural600Color,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
              ],
            ),
          ),

          Divider(height: 1, color: AppColors.netural100Color),

          SizedBox(height: screenHeight * 0.02),

          //  DESCRIPTION
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              children: [
                Text(
                  "We’d love your feedback on this charging session and the app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    fontFamily: FontFamily.appFontFamily,
                    color: AppColors.netural600Color,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                //  STAR RATING
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    bool isFilled = index < selectedStars;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStars = index + 1;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.015,
                        ),
                        child: Image.asset(
                          isFilled
                              ? "assets/icons/station/selected_star.png"
                              : "assets/icons/station/dimmedstar.png",
                          width: screenWidth * 0.10,
                          height: screenWidth * 0.10,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.03),
                //  COMMENT LABEL
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Comment",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: FontFamily.appFontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                //  COMMENT TEXTFIELD
                Container(
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    color: AppColors.neutral50Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: commentController,
                    maxLines: 4,
                    style: TextStyle(fontFamily: FontFamily.appFontFamily),
                    decoration: InputDecoration(
                      hintText: "Add your comment here",
                      hintStyle: TextStyle(
                        color: AppColors.netural600Color,
                        fontFamily: FontFamily.appFontFamily,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(screenWidth * 0.04),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                //  DONE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.055,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tealColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showFeedbackSubmittedSheet(context);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: AppColors.whiteColor,
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
    );
  }
}

void showFeedbackSubmittedSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const FeedbackSubmittedSheet(),
  );
}
