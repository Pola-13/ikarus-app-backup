import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/models/signup_profile.dart';
import 'package:ikarusapp/features/authentication_management/data/models/country_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/city_model.dart';
import 'package:ikarusapp/features/authentication_management/data/models/district_model.dart';
import 'package:ikarusapp/features/station_management/data/models/station_data.dart';

extension JsonParser on Map<String, dynamic> {
  V? parse<V>() {
    switch (V) {
      case const (UserData):
        return UserData.fromJson(this) as V;
      case const (UserModel):
        return UserModel.fromJson(this) as V;
      case const (SignupProfile):
        return SignupProfile.fromJson(this) as V;
      case const (CountryModel):
        return CountryModel.fromJson(this) as V;
      case const (CityModel):
        return CityModel.fromJson(this) as V;
      case const (DistrictModel):
        return DistrictModel.fromJson(this) as V;
      case const (StationData):
        return StationData.fromJson(this) as V;

    }
    return null;
  }
}
