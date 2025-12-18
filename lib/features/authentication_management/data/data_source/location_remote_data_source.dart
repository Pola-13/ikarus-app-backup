import 'package:dio/dio.dart';
import 'package:ikarusapp/core/network/api_error.dart';
import 'package:ikarusapp/core/network/api_exception.dart';
import 'package:ikarusapp/core/network/api_manager/api_service.dart';
import 'package:ikarusapp/core/network/api_urls.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/country_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/city_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/district_model.dart';

class LocationRemoteDataSource {
  final ApiService apiService;

  LocationRemoteDataSource({required this.apiService});

  // Get countries
  Future<BaseApiResult<List<CountryModel>>> getCountries() async {
    try {
      final response = await apiService.getList<CountryModel>(
        ApiUrls.country,
        hasToken: false, // Countries endpoint doesn't require token
      );
      return response;
    } on DioException catch (e) {
      return BaseApiResult<List<CountryModel>>(
        errorMessage: "Failed to load countries. Please try again.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<List<CountryModel>>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // Get cities by country code
  Future<BaseApiResult<List<CityModel>>> getCities(String countryCode) async {
    try {
      final response = await apiService.getList<CityModel>(
        ApiUrls.city,
        params: {'country': countryCode},
        hasToken: false, // Cities endpoint doesn't require token
      );
      return response;
    } on DioException catch (e) {
      return BaseApiResult<List<CityModel>>(
        errorMessage: "Failed to load cities. Please try again.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<List<CityModel>>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // Get districts by city id
  Future<BaseApiResult<List<DistrictModel>>> getDistricts(String cityId) async {
    try {
      final response = await apiService.getList<DistrictModel>(
        ApiUrls.district,
        params: {'city_id': cityId},
        hasToken: false, // Districts endpoint doesn't require token
      );
      return response;
    } on DioException catch (e) {
      return BaseApiResult<List<DistrictModel>>(
        errorMessage: "Failed to load districts. Please try again.",
        apiError: ApiExceptions.handleError(e),
      );
    } catch (e) {
      return BaseApiResult<List<DistrictModel>>(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }
}

