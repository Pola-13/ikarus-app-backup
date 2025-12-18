import 'package:dio/dio.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/network/api_urls.dart';
import 'package:ikarusapp/core/utils/pref_helpers.dart';

import 'api_service.dart';

class DioClient {
  static Dio dio = createDio();

  static Dio createDio() {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl, //Base URL for API requests
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // You can add authorization headers or logging here
          final accessToken = await PrefHelpers.getToken();
          if (options.extra.containsKey(AUTHORIZATION_REQUIRED) &&
              (options.extra[AUTHORIZATION_REQUIRED] as bool) &&
              (accessToken?.isNotEmpty ?? false)) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          return handler.next(options);
        },
      ),
    );
    return _dio;
  }
}
