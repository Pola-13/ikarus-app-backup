import 'dart:developer';

import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_local_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/station_management/data/data_source/station_remote_data_source.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/models/charger_data.dart';
import 'package:ikarusapp/features/station_management/data/models/connector_data.dart';

class StationRepositoryImpl {
  StationRemoteDataSource stationRemoteDataSource;

  StationRepositoryImpl({required this.stationRemoteDataSource});

  Future<BaseApiResult<List<StationData>>> getStations() {
    return stationRemoteDataSource.getStations( );
  }

  Future<BaseApiResult<List<ChargerData>>> getChargers(String stationId) {
    return stationRemoteDataSource.getChargers(stationId);
  }

  Future<BaseApiResult<List<ConnectorData>>> getConnectors(String chargerId) {
    return stationRemoteDataSource.getConnectors(chargerId);
  }
}
