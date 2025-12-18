import 'package:ikarusapp/features/authentication_management/data/models/user_data.dart';
import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';
import 'package:ikarusapp/features/authentication_management/data/models/signup_profile.dart';
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
      case const (StationData):
        return StationData.fromJson(this) as V;

    }
    return null;
  }
}
