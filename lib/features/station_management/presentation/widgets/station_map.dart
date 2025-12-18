import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ikarusapp/core/constants/colors.dart';
import 'package:ikarusapp/core/injection/station_injection.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/presentation/view_models/stations_view_model.dart';
import 'package:ikarusapp/features/station_management/presentation/widgets/stations_Pop_Up.dart';

class StationMap extends StatefulWidget {
  final List<Map<String, dynamic>> filtered;
  final bool showCards;

  const StationMap({
    super.key,
    required this.filtered,
    required this.showCards,
  });

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
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

    Future.delayed(const Duration(seconds: 0), () async {
      await ProviderScope.containerOf(context, listen: false)
          .read(_viewModelProvider.notifier)
          .getStations(onSuccess: () => loadMarkers());
    });
  }

  Future<BitmapDescriptor> markerIcon() async {
    return BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(42, 55)),
      "assets/icons/station_icon3_2.png",
    );
  }

  Future<void> loadMarkers() async {
    final icon = await markerIcon();
    if (context.mounted) {
      List<StationData> stationData =
          ProviderScope.containerOf(
            context,
            listen: false,
          ).read(_viewModelProvider).data;

      final newMarkers =
          stationData.map((s) {
            return Marker(
              markerId: MarkerId(s.id ?? ''),
              position: LatLng(s.latitude ?? 0, s.longitude ?? 0),
              icon: icon,
              onTap: () => showStationSheet(s),
            );
          }).toSet();

      setState(() => markers = newMarkers);
    }
  }

  void showStationSheet(StationData station) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.52,
          minChildSize: 0.52,
          maxChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) {
            return StationDetailsSheet(
              station: station,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) {
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
        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(29.96779, 31.29480),
            zoom: 8,
          ),
          markers: markers,
          onMapCreated: (controller) {
            if (!_controller.isCompleted) _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        );
      },
    );
  }
}
