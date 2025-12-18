import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/constants/device.dart';

// This widget is used on the FAQ page to show the question and answer
class FaqElement extends StatefulWidget {
  final String title;
  final String expandedText;

  const FaqElement({
    super.key,
    required this.title,
    required this.expandedText,
  });

  @override
  State<FaqElement> createState() => _FaqElementState();
}

class _FaqElementState extends State<FaqElement> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.03), // ~12
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(31, 97, 97, 97),
            blurRadius: 6,
            offset: Offset(1, 6),
          ),
        ],
        border: Border.all(
          color: AppColors.whiteColor,
          width: screenWidth * 0.0025, // ~0.8
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.appFontFamily,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() => isExpanded = !isExpanded);
              },
              child: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more_sharp,
                color: AppColors.tealColor,
                size: screenWidth * 0.07,
              ),
            ),
          ),

          // Expanded section
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                right: screenWidth * 0.1,
                top: screenHeight * 0.006,
                bottom: screenHeight * 0.012,
              ),
              child: Text(
                widget.expandedText,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  color: AppColors.primaryColor,
                  fontFamily: FontFamily.appFontFamily,
                ),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
