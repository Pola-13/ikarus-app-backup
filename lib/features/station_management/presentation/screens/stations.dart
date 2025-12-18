import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/station_data.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/search_bar.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/segment_bar.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/station_list.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/station_map.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/station_map_card.dart';

enum Segment { map, list, favorite }

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  GoogleMapController? mapController;
  Segment segment = Segment.map;

  List<Map<String, dynamic>> filteredStations = stationData;
  final TextEditingController searchCtrl = TextEditingController();

  bool showMapCards = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = Device.deviceWidth(context: context);
    final screenHeight = Device.deviceHeight(context: context);

    return SafeArea(
      top: true,
      child: Stack(
        children: [
          // MAP BACKGROUND (Only in Map Mode)
          if (segment == Segment.map)
            Positioned.fill(
              child: StationMap(
                filtered: filteredStations,
                showCards: showMapCards,
              ),
            ),

          // TOP UI (SearchBar + SegmentBar)
          Positioned(
            top: screenHeight * 0.015,
            left: screenWidth * 0.01,
            right: screenWidth * 0.01,
            child: Column(
              children: [
                // SEARCH BAR
                StationSearchBar(
                  controller: searchCtrl,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  onChanged: (value) {
                    setState(() {
                      filteredStations =
                          stationData
                              .where(
                                (s) => s["name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                              )
                              .toList();

                      showMapCards = segment == Segment.map && value.isNotEmpty;
                    });
                  },
                ),

                SizedBox(height: screenHeight * 0.015),

                // SEGMENT BAR
                SegmentBar(
                  current: segment,
                  onChange: (s) {
                    setState(() {
                      segment = s;
                      if (s != Segment.map) {
                        showMapCards = false;
                      }
                    });
                  },
                ),
              ],
            ),
          ),

          // LIST VIEW
          if (segment == Segment.list)
            Positioned.fill(
              top: screenHeight * 0.16,
              child: Container(
                color: Colors.white,
                child: StationList(
                  // stations: filteredStations,
                  onToggleFavorite: toggleFavorite,
                ),
              ),
            ),

          // FAVORITE VIEW
          if (segment == Segment.favorite)
            Positioned.fill(
              top: screenHeight * 0.16,
              child: StationList(
                // stations: stationData
                //     .where((s) => s["favorite"] == true)
                //     .toList(),
                onToggleFavorite: toggleFavorite,
              ),
            ),

          // BOTTOM CARDS
          if (showMapCards && segment == Segment.map)
            Positioned(
              bottom: screenHeight * 0.025,
              left: 0,
              right: 0,
              child: SizedBox(
                height: screenHeight * 0.22,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: filteredStations.length,
                  itemBuilder: (context, i) {
                    return StationMapCard(station: filteredStations[i]);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // STAR FAVORITE LOGIC
  void toggleFavorite(StationData station) {
    setState(() {
      // station["favorite"] = !(station["favorite"] ?? false);
    });
  }
}
