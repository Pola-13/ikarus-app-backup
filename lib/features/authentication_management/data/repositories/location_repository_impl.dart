import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/data_source/location_remote_data_source.dart';
import 'package:ikarusapp/features/authentication_management/data/models/country_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/city_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/district_model.dart';

class LocationRepositoryImpl {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
  });

  Future<BaseApiResult<List<CountryModel>>> getCountries() {
    return locationRemoteDataSource.getCountries();
  }

  Future<BaseApiResult<List<CityModel>>> getCities(String countryCode) {
    return locationRemoteDataSource.getCities(countryCode);
  }

  Future<BaseApiResult<List<DistrictModel>>> getDistricts(String cityId) {
    return locationRemoteDataSource.getDistricts(cityId);
  }
}

