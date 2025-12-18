
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/core/network/api_manager/api_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());


final apiMethodsProvider = Provider<ApiServiceImpl>((ref) {
  return ApiServiceImpl();
});


