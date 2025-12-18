import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/DirectionButton.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_station_IMGs.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/googlemaproute.dart';
import 'package:ikarusapp/features/general_management/presentation/screens/rating.dart';
import 'package:ikarusapp/features/base/presentation/widgets/pricing_section.dart';

class ZahraaAlmaadai extends StatefulWidget {
  const ZahraaAlmaadai({super.key});

  @override
  State<ZahraaAlmaadai> createState() => _ZahraaAlmaadaiState();
}

class _ZahraaAlmaadaiState extends State<ZahraaAlmaadai> {
  int segmentIndex = 0;
  final Map<String, dynamic> station = {'lat': 29.96779, 'lng': 31.29480};

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
        appBar: buildAppBar(context, "Zahraa Almaadai Station"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Multiple Images of the sataion are displayed in an auto-swipe
                CarouselSlider.builder(
                  itemCount: items.length,
                  itemBuilder:
                      (
                        BuildContext context,
                        int itemIndex,
                        int pageViewIndex,
                      ) => Image.asset(items[itemIndex]),
                  options: CarouselOptions(
                    height: screenHeight * 0.23,
                    aspectRatio: 1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),

                //  SEGMENT BAR
                Container(
                  height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      _segmentButton("Overview", 0, screenWidth),
                      _segmentButton("Pricing", 1, screenWidth),
                      _segmentButton("Nearby", 2, screenWidth),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                //  SEGMENT CONTENT
                if (segmentIndex == 0)
                  _buildOverview(screenWidth, screenHeight),
                if (segmentIndex == 1) PricingSection(),
                if (segmentIndex == 2) _buildNearby(),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: DirectionsButton(
          isOverviewSelected: segmentIndex == 0,
          onPressed: () {
            openGoogleMapsRoute(station['lat'], station['lng']);
          },
        ),
      ),
    );
  }

  //  SEGMENT BUTTON
  Widget _segmentButton(String text, int index, double screenWidth) {
    bool selected = segmentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => segmentIndex = index),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? AppColors.tealColor : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.038,
              fontWeight: selected ? FontWeight.bold : FontWeight.w400,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  // OVERVIEW CONTENT
  Widget _buildOverview(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Station Title
        Text(
          "Zahraa Almaadai Station",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "55 Zahraa Almaadai, Cairo 78239",
          style: TextStyle(
            color: Colors.black54,
            fontSize: screenWidth * 0.035,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Dots + Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _dot(Colors.green),
                SizedBox(width: 6),
                _dot(Colors.orange),
                SizedBox(width: 6),
                _dot(Colors.red),
              ],
            ),
            Row(
              children: [
                _featureIcon("assets/icons/station/mosque.png"),
                SizedBox(width: 14),
                _featureIcon("assets/icons/station/Fork-Knife.png"),
                SizedBox(width: 14),
                _featureIcon("assets/icons/station/bathroom.png"),
                SizedBox(width: 14),
                _featureIcon("assets/icons/station/Coffee.png"),
              ],
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.03),

        // Connector Cards
        _connectorCard(
          title: "Zahraa Almaadai 1 (1)",
          kwh: "22 kWh",
          status: "Available",
          color: AppColors.tealColor,
          available: true,
        ),
        SizedBox(height: screenHeight * 0.02),
        _connectorCard(
          title: "Zahraa Almaadai 2 (1)",
          kwh: "22 kWh",
          status: "Charging",
          color: Colors.orange,
          available: false,
        ),
        SizedBox(height: screenHeight * 0.02),
        _connectorCard(
          title: "Zahraa Almaadai 2 (2)",
          kwh: "22 kWh",
          status: "Unavailable",
          color: Colors.red,
          available: false,
        ),
      ],
    );
  }

  // NEARBY
  Widget _buildNearby() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        // Description Text
        const Text(
          "Discover Nearby Places To Eat, Drink, And Shop During Charging",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 18),

        // Cards
        _nearbyCard(
          imagePath: "assets/icons/station/circuleK.png",
          title: "Circle K",
        ),

        const SizedBox(height: 12),

        _nearbyCard(
          imagePath: "assets/icons/station/mcdonals.png",
          title: "Mcdonalds",
        ),

        const SizedBox(height: 12),

        _nearbyCard(
          imagePath: "assets/icons/station/dunkin.png",
          title: "Dunkin",
        ),

        const SizedBox(height: 12),

        _nearbyCard(
          imagePath: "assets/icons/station/ontherun.png",
          title: "On The Run",
        ),
      ],
    );
  }

  Widget _nearbyCard({required String imagePath, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        // Thin border, no shadow
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          // Logo Image
          Image.asset(imagePath, width: 45, height: 45, fit: BoxFit.contain),

          const SizedBox(width: 16),

          // Store Name
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // SHARED WIDGETS
  Widget _dot(Color color) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _featureIcon(String path) {
    return Image.asset(path, width: 24, height: 24, fit: BoxFit.contain);
  }

  Widget _connectorCard({
    required String title,
    required String kwh,
    required String status,
    required Color color,
    required bool available,
  }) {
    final double screenWidth = Device.deviceWidth(context: context);
    final double screenHeight = Device.deviceHeight(context: context);

    // Button Style by Status
    late Color buttonColor;
    late Color textColor;
    late String buttonText;
    late bool showIcon;

    if (status == "Available") {
      buttonColor = AppColors.tealColor;
      textColor = Colors.white;
      buttonText = "Start Charge";
      showIcon = true;
    } else if (status == "Charging") {
      buttonColor = AppColors.netural100Color;
      textColor = AppColors.netural400Color;
      buttonText = "Charging";
      showIcon = false;
    } else {
      // Unavailable
      buttonColor = AppColors.netural100Color;
      textColor = AppColors.netural400Color;
      buttonText = "Unavailable";
      showIcon = false;
    }

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/station/session.png",
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                kwh,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // BUTTON
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.055,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed:
                  status == "Available"
                      ? () => Navigator.pushNamed(context, Routes.startcharge)
                      : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // button text
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.04,
                      color: textColor,
                    ),
                  ),

                  // spacing & icon only if available
                  if (showIcon) ...[
                    SizedBox(width: 8),
                    Image.asset(
                      "assets/icons/station/chargingspeed.png",
                      width: screenWidth * 0.05,
                      color: textColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showRatingFeedback(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) => const RatingFeedbackSheet(),
  );
}
