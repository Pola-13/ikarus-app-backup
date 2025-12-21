import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/injection/station_injection.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/models/connector_data.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_almaadai.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/googlemaproute.dart';
import 'package:url_launcher/url_launcher.dart';

class StationDetailsSheet extends ConsumerStatefulWidget {
  final StationData station;
  final ScrollController scrollController;

  const StationDetailsSheet({
    super.key,
    required this.station,
    required this.scrollController,
  });

  @override
  ConsumerState<StationDetailsSheet> createState() => _StationDetailsSheetState();
}

class _StationDetailsSheetState extends ConsumerState<StationDetailsSheet> {
  List<ConnectorData> connectors = [];
  bool isLoading = true;
  String? errorMessage;
  bool _isDisposed = false;

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
    if (widget.station.id == null) {
      if (!mounted || _isDisposed) return;
      setState(() {
        isLoading = false;
        errorMessage = "Station ID is missing";
      });
      return;
    }

    if (!mounted || _isDisposed) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final repository = ref.read(stationRepositoryProvider);
      final stationId = widget.station.id!;
      
      debugPrint("🔍 Loading connectors for station: $stationId (${widget.station.name})");
      
      // Fetch chargers for this station
      final chargersResult = await repository.getChargers(stationId);
      
      if (!mounted || _isDisposed) return;
      
      debugPrint("🔍 Chargers API Response:");
      debugPrint("   - Status: ${chargersResult.status}");
      debugPrint("   - Error: ${chargersResult.errorMessage}");
      debugPrint("   - Found ${chargersResult.data?.length ?? 0} chargers for station $stationId");
      
      if (chargersResult.errorMessage != null) {
        if (!mounted || _isDisposed) return;
        setState(() {
          isLoading = false;
          errorMessage = "Error loading chargers: ${chargersResult.errorMessage}";
        });
        return;
      }
      
      if (chargersResult.data == null || chargersResult.data!.isEmpty) {
        if (!mounted || _isDisposed) return;
        debugPrint("⚠️ No chargers found for station $stationId");
        setState(() {
          isLoading = false;
          connectors = [];
          errorMessage = "No chargers found for this station";
        });
        return;
      }

      // Fetch connectors for each charger
      List<ConnectorData> allConnectors = [];
      
      for (var charger in chargersResult.data!) {
        if (_isDisposed) return;
        
        if (charger.id != null) {
          debugPrint("🔍 Fetching connectors for charger: ${charger.id} (${charger.name})");
          final connectorsResult = await repository.getConnectors(charger.id!);
          if (!mounted || _isDisposed) return;
          
          debugPrint("🔍 Connectors API Response for charger ${charger.id}:");
          debugPrint("   - Status: ${connectorsResult.status}");
          debugPrint("   - Error: ${connectorsResult.errorMessage}");
          debugPrint("   - Found ${connectorsResult.data?.length ?? 0} connectors");
          
          if (connectorsResult.data != null && connectorsResult.data!.isNotEmpty) {
            debugPrint("🔍 Connectors for charger ${charger.id}:");
            for (var connector in connectorsResult.data!) {
              debugPrint("   - Connector: ${connector.identifier}, Station ID: ${connector.stationId}, Power: ${connector.powerKw}, Status: ${connector.status}");
            }
            
            // Filter connectors to ensure they belong to this station
            // Note: Since we're fetching connectors for chargers that belong to this station,
            // all connectors should already belong to this station, but we filter to be safe
            final stationConnectors = connectorsResult.data!
                .where((connector) {
                  final connectorStationId = connector.stationId?.toString().trim();
                  final targetStationId = stationId.toString().trim();
                  final matches = connectorStationId == targetStationId;
                  
                  if (!matches) {
                    debugPrint("   ⚠️ Connector ${connector.identifier} filtered out");
                    debugPrint("      Expected stationId: '$targetStationId'");
                    debugPrint("      Got stationId: '$connectorStationId'");
                  }
                  return matches;
                })
                .toList();
            debugPrint("🔍 Filtered to ${stationConnectors.length} connectors for station $stationId");
            allConnectors.addAll(stationConnectors);
          } else if (connectorsResult.errorMessage != null) {
            debugPrint("⚠️ Error fetching connectors for charger ${charger.id}: ${connectorsResult.errorMessage}");
          } else {
            debugPrint("⚠️ No connectors returned for charger ${charger.id}");
          }
        }
      }
      
      debugPrint("🔍 Total connectors for station $stationId: ${allConnectors.length}");

      if (!mounted || _isDisposed) return;
      setState(() {
        isLoading = false;
        connectors = allConnectors;
        if (allConnectors.isEmpty && errorMessage == null) {
          errorMessage = "No connectors available for this station";
        }
      });
    } catch (e, stackTrace) {
      debugPrint("❌ Exception in _loadConnectors: $e");
      debugPrint("❌ Stack trace: $stackTrace");
      if (!mounted || _isDisposed) return;
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load connectors: $e";
      });
    }
  }

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
                controller: widget.scrollController,
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
              widget.station.name??"",
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
            widget.station.name??"",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            widget.station.address??"",
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ZahraaAlmaadai(station: widget.station),
                ),
              );
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
              openGoogleMapsRoute(widget.station.latitude??0, widget.station.longitude??0);
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

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.tealColor),
                ),
              ),
            )
          else if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    errorMessage!,
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
              ),
            )
          else
            ...connectors.map((c) {
              // Map API status to display status
              String displayStatus = c.status ?? "";
              Color statusColor;
              
              switch (displayStatus.toLowerCase()) {
                case "available":
                  statusColor = Colors.green;
                  displayStatus = "Available";
                  break;
                case "charging":
                  statusColor = Colors.orange;
                  displayStatus = "Charging";
                  break;
                case "preparing":
                  statusColor = Colors.orange;
                  displayStatus = "Preparing";
                  break;
                case "unavailable":
                  statusColor = Colors.red;
                  displayStatus = "Unavailable";
                  break;
                case "faulted":
                  statusColor = Colors.red;
                  displayStatus = "Faulted";
                  break;
                default:
                  statusColor = Colors.grey;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.002,
                      ),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        "assets/icons/station/session.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    Expanded(
                      child: Text(
                        c.identifier ?? "",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      "${c.powerKw ?? 0} Kwh",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      displayStatus,
                      style: TextStyle(
                        color: statusColor,
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
