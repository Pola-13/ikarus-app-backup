import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/injection/base_injection.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/location_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/location_repository_impl.dart';
import 'package:ikarusapp/features/authentication_management/presentation/view_models/location_view_model.dart';

final locationRemoteDataSourceProvider = Provider<LocationRemoteDataSource>((ref) {
  return LocationRemoteDataSource(apiService: ref.read(apiMethodsProvider));
});

final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  return LocationRepositoryImpl(
    locationRemoteDataSource: ref.read(locationRemoteDataSourceProvider),
  );
});

final locationViewModelProvider = StateNotifierProvider<LocationViewModel, LocationState>((ref) {
  return LocationViewModel(ref.read(locationRepositoryProvider));
});

