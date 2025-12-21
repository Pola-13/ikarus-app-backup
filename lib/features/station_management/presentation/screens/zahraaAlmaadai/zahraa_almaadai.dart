import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/injection/station_injection.dart';
import 'package:ikarusapp/features/base/presentation/widgets/Appbar/addfunds_appbar.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/models/connector_data.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/DirectionButton.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_station_IMGs.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/googlemaproute.dart';
import 'package:ikarusapp/features/general_management/presentation/screens/rating.dart';
import 'package:ikarusapp/features/base/presentation/widgets/pricing_section.dart';

class ZahraaAlmaadai extends ConsumerStatefulWidget {
  final StationData? station;
  
  const ZahraaAlmaadai({super.key, this.station});

  @override
  ConsumerState<ZahraaAlmaadai> createState() => _ZahraaAlmaadaiState();
}

class _ZahraaAlmaadaiState extends ConsumerState<ZahraaAlmaadai> {
  int segmentIndex = 0;
  List<ConnectorData> connectors = [];
  bool isLoadingConnectors = true;
  String? connectorErrorMessage;
  bool _isDisposed = false;
  
  StationData get station => widget.station ?? StationData(
    id: null,
    name: "Zahraa Almaadai Station",
    address: null,
    country: null,
    governorate: null,
    serviceProvider: null,
    maintenancePartner: null,
    siteOwner: null,
    latitude: 29.96779,
    longitude: 31.29480,
    visibility: null,
    status: null,
    chargersCount: null,
    connectorSummary: null,
    images: [],
  );

  @override
  void initState() {
    super.initState();
    _loadConnectors();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _loadConnectors() async {
    if (station.id == null) {
      if (!mounted || _isDisposed) return;
      setState(() {
        isLoadingConnectors = false;
        connectorErrorMessage = "Station ID is missing";
      });
      return;
    }

    if (!mounted || _isDisposed) return;
    setState(() {
      isLoadingConnectors = true;
      connectorErrorMessage = null;
    });

    try {
      final repository = ref.read(stationRepositoryProvider);
      final stationId = station.id!;
      
      // Fetch chargers for this station
      final chargersResult = await repository.getChargers(stationId);
      
      if (!mounted || _isDisposed) return;
      
      if (chargersResult.data == null || chargersResult.data!.isEmpty) {
        if (!mounted || _isDisposed) return;
        setState(() {
          isLoadingConnectors = false;
          connectors = [];
        });
        return;
      }

      // Fetch connectors for each charger
      List<ConnectorData> allConnectors = [];
      
      for (var charger in chargersResult.data!) {
        if (_isDisposed) return;
        
        if (charger.id != null) {
          final connectorsResult = await repository.getConnectors(charger.id!);
          if (!mounted || _isDisposed) return;
          
          if (connectorsResult.data != null) {
            // Filter connectors to ensure they belong to this station
            final stationConnectors = connectorsResult.data!
                .where((connector) {
                  final connectorStationId = connector.stationId?.toString().trim();
                  final targetStationId = stationId.toString().trim();
                  return connectorStationId == targetStationId;
                })
                .toList();
            allConnectors.addAll(stationConnectors);
          }
        }
      }

      if (!mounted || _isDisposed) return;
      setState(() {
        isLoadingConnectors = false;
        connectors = allConnectors;
      });
    } catch (e) {
      if (!mounted || _isDisposed) return;
      setState(() {
        isLoadingConnectors = false;
        connectorErrorMessage = "Failed to load connectors: $e";
      });
    }
  }

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
        appBar: buildAppBar(context, "${station.name ?? "Station"}"),
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
            openGoogleMapsRoute(station.latitude ?? 0, station.longitude ?? 0);
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
          station.name ?? "Station",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        SizedBox(height: 4),
        Text(
          station.address ?? "",
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
        if (isLoadingConnectors)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
              ),
            ),
          )
        else if (connectorErrorMessage != null)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  connectorErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadConnectors,
                  child: const Text("Retry"),
                ),
              ],
            ),
          )
        else if (connectors.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "No connectors available",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        else
          ...connectors.map((connector) {
            // Map API status to display status
            String displayStatus = connector.status ?? "";
            Color statusColor;
            bool isAvailable = false;
            
            switch (displayStatus.toLowerCase()) {
              case "available":
                statusColor = AppColors.tealColor;
                displayStatus = "Available";
                isAvailable = true;
                break;
              case "charging":
                statusColor = Colors.orange;
                displayStatus = "Charging";
                isAvailable = false;
                break;
              case "preparing":
                statusColor = Colors.orange;
                displayStatus = "Preparing";
                isAvailable = false;
                break;
              case "unavailable":
                statusColor = Colors.red;
                displayStatus = "Unavailable";
                isAvailable = false;
                break;
              case "faulted":
                statusColor = Colors.red;
                displayStatus = "Faulted";
                isAvailable = false;
                break;
              default:
                statusColor = Colors.grey;
                if (displayStatus.isNotEmpty) {
                  displayStatus = displayStatus[0].toUpperCase() + displayStatus.substring(1).toLowerCase();
                }
                isAvailable = false;
            }

            return Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: _connectorCard(
                title: connector.identifier ?? "",
                kwh: "${connector.powerKw ?? 0} Kwh",
                status: displayStatus,
                color: statusColor,
                available: isAvailable,
              ),
            );
          }).toList(),
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
    } else if (status == "Charging" || status == "Preparing") {
      buttonColor = AppColors.netural100Color;
      textColor = AppColors.netural400Color;
      buttonText = status;
      showIcon = false;
    } else {
      // Unavailable, Faulted, or other statuses
      buttonColor = AppColors.netural100Color;
      textColor = AppColors.netural400Color;
      buttonText = status;
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: kwh.split(' ')[0], // The number part
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' ${kwh.split(' ').length > 1 ? kwh.split(' ')[1] : 'Kwh'}', // The "Kwh" part
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.netural600Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
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
