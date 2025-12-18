import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/constants/device.dart';
import 'package:ikarusapp/core/constants/font_family.dart';
import 'package:ikarusapp/core/injection/station_injection.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_almaadai.dart';
import 'package:ikarusapp/features/station_management/presentation/view_models/stations_view_model.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/connectors_data.dart';

class StationList extends StatefulWidget {
  // final List<Map<String, dynamic>> stations;
  final Function(StationData) onToggleFavorite;

  const StationList({
    super.key,
    // required this.stations,
    required this.onToggleFavorite,
  });

  @override
  State<StationList> createState() => _StationListState();
}

class _StationListState extends State<StationList> {
  final _viewModelProvider =
      StateNotifierProvider<StationsViewModel, BaseState<List<StationData>>>((
        ref,
      ) {
        return StationsViewModel(ref.read(stationRepositoryProvider));
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      ProviderScope.containerOf(
        context,
        listen: false,
      ).read(_viewModelProvider.notifier).getStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Device.deviceWidth(context: context);

    bool expanded = false;

    return Consumer(
      builder: (ctx, ref, _) {
        List<StationData> stationData = ref.watch(
          _viewModelProvider.select((value) => value.data),
        );
        bool isLoading = ref.watch(
          _viewModelProvider.select((value) => value.isLoading),
        );
        if (isLoading) {
          return Center(
            child: SizedBox(
              key: const ValueKey('loader'),
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primaryColor, //loading
              ),
            ),
          );
        }
        if (stationData.isEmpty) {
          return Center(
            child: Text(
              "No Stations Yet",
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(screenWidth * 0.04),
          itemCount: stationData.length,
          itemBuilder: (context, i) {
            final station = stationData[i];

            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  margin: EdgeInsets.only(bottom: screenWidth * 0.04),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  NAME / ADDRESS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Text(
                                  station.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                station.address ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.netural600Color,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              // OPEN
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ZahraaAlmaadai(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child:  Text(
                                  station.status ?? "",
                                  style: TextStyle(
                                    color: AppColors.tealColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: FontFamily.appFontFamily,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 6),

                              // FAVORITE ICON
                              GestureDetector(
                                onTap: () => widget.onToggleFavorite(station),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.01,
                                  ),
                                  child: Image.asset(
                                    station.name == "true"
                                        ? "assets/icons/station/selected_star.png"
                                        : "assets/icons/station/dimmedstar.png",
                                    width: screenWidth * 0.07,
                                    height: screenWidth * 0.07,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      //  DISTANCE + STATUS
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 10,
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.circle,
                                  color: Colors.orange,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Connectors",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                "${connectorsDummyData.length}/2",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.netural600Color,
                                ),
                              ),

                              SizedBox(width: 6),

                              GestureDetector(
                                onTap:
                                    () => setState(() => expanded = !expanded),
                                child: Icon(
                                  expanded
                                      // ignore: dead_code
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      if (expanded) ...[
                        // Divider(),
                        SizedBox(height: 6),
                        ...connectorsDummyData.map((c) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/station/session.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      c["name"],
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),

                                Text(
                                  "${c['kw']} Kwh",
                                  style: TextStyle(fontSize: 13),
                                ),

                                Text(
                                  c["status"],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        c["status"] == "Available"
                                            ? AppColors.statusGreenColor
                                            : c["status"] == "Charging"
                                            ? AppColors.statusChargingColor
                                            : AppColors.statusRedColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
