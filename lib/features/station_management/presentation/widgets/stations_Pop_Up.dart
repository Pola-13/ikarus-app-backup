import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/googlemaproute.dart';
import 'package:url_launcher/url_launcher.dart';

class StationDetailsSheet extends StatelessWidget {
  final StationData station;
  final ScrollController scrollController;

  StationDetailsSheet({
    super.key,
    required this.station,
    required this.scrollController,
  });

  // Dummy connectors
  final List<Map<String, dynamic>> connectors = const [
    {"name": "Zahraa Almaadai 1 (1)", "kw": 22, "status": "Available"},
    {"name": "Zahraa Almaadai 2 (1)", "kw": 22, "status": "Charging"},
    {"name": "Zahraa Almaadai 2 (2)", "kw": 22, "status": "Unavailable"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _notch(),
                    _titleBar(context),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.008,
                      ),
                      child: Divider(
                        height: 1,
                        color: AppColors.netural100Color,
                      ),
                    ),
                    _imageSection(),
                    _nameAndAddress(),
                    _featureIconsRow(context),
                    // Connector Section
                    _connectorsSection(context),
                  ],
                ),
              ),
            ),

            // FIXED BOTTOM ACTION BUTTONS
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 12,
                top: 6,
              ),
              child: _actionsRow(context),
            ),
          ],
        ),
      ),
    );
  }

  // UI SECTIONS
  Widget _notch() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 4),
      child: Center(
        child: Container(
          width: 48,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _titleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // CENTERED TEXT
          Center(
            child: Text(
              station.name??"",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),

          // CLOSE ICON ON LEFT
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.netural400Color),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
         "assets/icons/charger.png",
          height: 190,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _nameAndAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name??"",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            station.address??"",
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.netural600Color,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureIconsRow(context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _dot(Colors.green),
              const SizedBox(width: 6),
              _dot(Colors.orange),
              const SizedBox(width: 6),
              _dot(Colors.red),
            ],
          ),
          Row(
            children: [
              _featureIcon("assets/icons/station/mosque.png"),
              const SizedBox(width: 14),
              _featureIcon("assets/icons/station/Fork-Knife.png"),
              const SizedBox(width: 14),
              _featureIcon("assets/icons/station/bathroom.png"),
              const SizedBox(width: 14),
              _featureIcon("assets/icons/station/Coffee.png"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.zahraaAlmaadai);
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.selectedItemColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  "More",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.tealColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              openGoogleMapsRoute(station.latitude??0, station.longitude??0);
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.tealColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/Directions.png", width: 20),
                    const SizedBox(width: 6),
                    const Text(
                      "Directions",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _connectorsSection(context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Connectors",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),

          ...connectors.map((c) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.002,
                    ),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/icons/station/session.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.005),
                  Expanded(
                    child: Text(
                      c["name"],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    "${c["kw"]} Kwh",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    c["status"],
                    style: TextStyle(
                      color:
                          c["status"] == "Available"
                              ? Colors.green
                              : c["status"] == "Charging"
                              ? Colors.orange
                              : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // HELPERS
  Widget _dot(Color color) => Container(
    width: 11,
    height: 11,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _featureIcon(String path) => Image.asset(path, width: 24, height: 24);
}
