import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
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
        // Allow redirects (3xx status codes) to be handled automatically
        followRedirects: true,
        maxRedirects: 5,
        // For POST requests, Dio may not follow redirects automatically
        // We need to validate status codes to allow redirects to be processed
        validateStatus: (status) {
          // Allow all status codes < 500
          // This allows Dio to process redirects (3xx) and follow them
          // Dio will follow redirects if followRedirects is true
          return status != null && status < 500;
        },
        // HTTPS certificate validation
        // For development: allow bad certificates (self-signed)
        // For production: use proper certificate validation
      ),
    );
    
    // Handle SSL certificate validation for Android/iOS
    if (Platform.isAndroid || Platform.isIOS) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          // For development: allow self-signed certificates
          // TODO: In production, implement proper certificate validation
          debugPrint('⚠️ SSL Certificate validation bypassed for: $host:$port');
          return true; // Allow all certificates (development only)
        };
        return client;
      };
    }
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
        onResponse: (response, handler) async {
          // Handle redirect responses
          if (response.statusCode != null && 
              response.statusCode! >= 300 && 
              response.statusCode! < 400) {
            final location = response.headers.value('location');
            if (location != null) {
              debugPrint('🔄 Redirect detected to: $location');
              // Dio should handle this automatically with followRedirects: true
              // But if it doesn't, we can manually follow it here
            }
          }
          return handler.next(response);
        },
      ),
    );
    return _dio;
  }
}
