import 'package:ikarusapp/features/authentication_management/data/models/usermodel.dart';

class UserData {
  UserData({
     this.token,
     this.expiresAt,
     this.user,
     this.refreshToken,
  });

  final String? token;
  final DateTime? expiresAt;
  final UserModel? user;
  final String? refreshToken;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json["token"],
      expiresAt: DateTime.tryParse(json["expires_at"] ?? ""),
      user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      refreshToken: json["refresh_token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
    "expires_at": expiresAt?.toIso8601String(),
    "user": user?.toJson(),
    "refresh_token": refreshToken,
  };

  UserData copyWith({
    String? token,
    DateTime? expiresAt,
    UserModel? user,
    String? refreshToken,
  }) {
    return UserData(
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      user: user ?? this.user,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
