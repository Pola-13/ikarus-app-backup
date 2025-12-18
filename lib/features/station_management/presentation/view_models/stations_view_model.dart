import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ikarusapp/core/constants/app_constants.dart';
import 'package:ikarusapp/core/constants/app_routs.dart';
import 'package:ikarusapp/core/injection/user_injection.dart';
import 'package:ikarusapp/core/network/models/responses/base_api_result.dart';
import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/repositories/user_repository_impl.dart';
import 'package:ikarusapp/features/base/data/entities/base_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikarusapp/features/base/data/entities/form_error.dart';
import 'package:ikarusapp/features/base/presentation/view_models/base_view_model.dart';
import 'package:ikarusapp/features/station_management/data/data_source/station_remote_data_source.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';
import 'package:ikarusapp/features/station_management/data/repositories/station_repository_impl.dart';
// import 'package:ucar_client_app/core/injection/injection_container.dart' as di;

class StationsViewModel extends StateNotifier<BaseState<List<StationData>>>
    with BaseViewModel {
  final StationRepositoryImpl _stationRepositoryImpl;

  StationsViewModel(this._stationRepositoryImpl) : super(BaseState(data: []));

  Future<void> getStations({Function? onSuccess}) async {
    _startLoading();

    BaseApiResult<List<StationData>> result =
        await _stationRepositoryImpl.getStations();
    _hideLoading();

    if (result.data != null) {
      state = state.copyWith(data: result.data ?? []);
      if (onSuccess != null) {
        await onSuccess();
      }
    } else {
      handleError(
        errorType: result.apiError,
        errorMessage: result.errorMessage,
      );
    }
  }

  _startLoading() {
    hideKeyboard();
    state = state.copyWith(isLoading: true);
  }

  _hideLoading() {
    state = state.copyWith(isLoading: false);
  }
}
