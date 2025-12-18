import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/device.dart';

class SessionCard extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;
  final String stationName;
  final String stationAddress;
  final String routeName;

  const SessionCard({
    super.key,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.stationName,
    required this.stationAddress,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.045),
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATE + STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.035,
                    vertical: screenHeight * 0.004,
                  ),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.033,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.01),

            Text(
              stationName,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: screenHeight * 0.006),

            Text(
              stationAddress,
              style: TextStyle(
                fontSize: screenWidth * 0.031,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
