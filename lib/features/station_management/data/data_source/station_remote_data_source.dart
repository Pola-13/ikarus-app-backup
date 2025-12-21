import 'package:dio/dio.dart';
import 'package:ikarusapp/core/network/api_error.dart';
import 'package:ikarusapp/core/network/api_exception.dart';
import 'package:ikarusapp/core/network/api_manager/api_service.dart';
import 'package:ikarusapp/core/network/api_manager/api_service_impl.dart';
import 'package:ikarusapp/core/network/api_urls.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/core/utils/pref_helpers.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/models/charger_data.dart';
import 'package:ikarusapp/features/station_management/data/models/connector_data.dart';

class StationRemoteDataSource {
  // Example method to demonstrate usage of ApiService

  final ApiService apiService;

  StationRemoteDataSource({required this.apiService});

  // Get stations method
  Future<BaseApiResult<List<StationData>>> getStations({
    String? governorate,
    String? status,
    String? service_provider,
    String? search,
    String? page,
    String? page_size,
  }) async {
    final response = await apiService.getList<StationData>(ApiUrls.stations,
    hasToken: true
    );

    return response;
  }

  // Get chargers for a station
  Future<BaseApiResult<List<ChargerData>>> getChargers(String stationId) async {
    final response = await apiService.getList<ChargerData>(
      ApiUrls.chargers,
      params: {"station": stationId},
      hasToken: true,
    );
    return response;
  }

  // Get connectors for a charger
  Future<BaseApiResult<List<ConnectorData>>> getConnectors(String chargerId) async {
    final response = await apiService.getList<ConnectorData>(
      ApiUrls.connectors,
      params: {"charger_id": chargerId},
      hasToken: true,
    );
    return response;
  }
}
