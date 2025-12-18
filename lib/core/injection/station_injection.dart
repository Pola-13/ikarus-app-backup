import 'package:flutter_riverpod/legacy.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_local_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/user_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/singup_request.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/signup_view_model.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/user_view_model.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';
import 'package:ikarusapp/features/station_management/data/data_source/station_remote_data_source.dart';
import 'package:ikarusapp/features/station_management/data/repositories/station_repository_impl.dart';

import 'base_injection.dart';



final stationRepositoryProvider = Provider<StationRepositoryImpl>((ref) {
  return StationRepositoryImpl(
    stationRemoteDataSource: ref.read(stationRemoteDataSourceProvider),
  );
});

final stationRemoteDataSourceProvider = Provider<StationRemoteDataSource>((ref) {
  return StationRemoteDataSource(apiService: ref.read(apiMethodsProvider));
});


