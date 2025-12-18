import 'dart:developer';

import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_local_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/station_management/data/data_source/station_remote_data_source.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';

class StationRepositoryImpl {
  StationRemoteDataSource stationRemoteDataSource;

  StationRepositoryImpl({required this.stationRemoteDataSource});

  Future<BaseApiResult<List<StationData>>> getStations() {
    return stationRemoteDataSource.getStations( );
  }
}
