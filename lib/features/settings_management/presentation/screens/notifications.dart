import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    // Fake notifications data
    final List<Map<String, String>> notifications = [
      {
        "title": "Your payment of 120 EGP was completed",
        "time": "Now",
      },
      {
        "title": "Your payment of 120 EGP was completed",
        "time": "11:00 PM",
      },
      {
        "title": "Your wallet has been topped up with 200 EGP",
        "time": "11:00 PM",
      },
      {
        "title": "Get the latest version for new features and improvements",
        "time": "11:00 PM",
      },
      {
        "title": "Your wallet has been topped up with 200 EGP",
        "time": "11:00 PM",
      },
      {
        "title": "Your wallet has been topped up with 200 EGP",
        "time": "11:00 PM",
      },
    ];

    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(context, "Notifications"),

        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];

            // alternate row color
            final bool isEven = index % 2 == 0;
            final Color rowColor =
                isEven ? Colors.white : const Color(0xFFEFF7E6);

            return Container(
              color: rowColor,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ICON
                  Container(
                    width: screenWidth * 0.11,
                    height: screenWidth * 0.11,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDF0C3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/icons/notifications.png",
                        width: screenWidth * 0.06,
                      ),
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.04),

                  // TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["time"]!,
                          style: TextStyle(
                            color: AppColors.netural600Color,
                            fontSize: screenWidth * 0.032,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
