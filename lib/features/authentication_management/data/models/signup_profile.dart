class SignupProfile {
  SignupProfile({
    this.id,
    this.userId,
    this.idTag,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneE164,
    this.countryCode,
    this.country,
    this.cityId,
    this.city,
    this.districtId,
    this.district,
    this.postalCode,
    this.preferredCurrency,
    this.dateOfBirth,
    this.profileImage,
    this.packageId,
    this.packageName,
    this.package,
    this.isBlocked,
    this.blockedAt,
    this.blockedReason,
    this.currentBalance,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? userId;
  final String? idTag;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneE164;
  final String? countryCode;
  final String? country;
  final String? cityId;
  final String? city;
  final String? districtId;
  final String? district;
  final String? postalCode;
  final String? preferredCurrency;
  final DateTime? dateOfBirth;
  final String? profileImage;
  final String? packageId;
  final String? packageName;
  final dynamic package;
  final bool? isBlocked;
  final DateTime? blockedAt;
  final String? blockedReason;
  final double? currentBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SignupProfile.fromJson(Map<String, dynamic> json) {
    return SignupProfile(
      id: json["id"],
      userId: json["user_id"],
      idTag: json["id_tag"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneE164: json["phone_e164"],
      countryCode: json["country_code"],
      country: json["country"],
      cityId: json["city_id"],
      city: json["city"],
      districtId: json["district_id"],
      district: json["district"],
      postalCode: json["postal_code"],
      preferredCurrency: json["preferred_currency"],
      dateOfBirth: json["date_of_birth"] != null
          ? DateTime.tryParse(json["date_of_birth"])
          : null,
      profileImage: json["profile_image"],
      packageId: json["package_id"],
      packageName: json["package_name"],
      package: json["package"],
      isBlocked: json["is_blocked"],
      blockedAt: json["blocked_at"] != null
          ? DateTime.tryParse(json["blocked_at"])
          : null,
      blockedReason: json["blocked_reason"],
      currentBalance: json["current_balance"]?.toDouble(),
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "id_tag": idTag,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_e164": phoneE164,
        "country_code": countryCode,
        "country": country,
        "city_id": cityId,
        "city": city,
        "district_id": districtId,
        "district": district,
        "postal_code": postalCode,
        "preferred_currency": preferredCurrency,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "profile_image": profileImage,
        "package_id": packageId,
        "package_name": packageName,
        "package": package,
        "is_blocked": isBlocked,
        "blocked_at": blockedAt?.toIso8601String(),
        "blocked_reason": blockedReason,
        "current_balance": currentBalance,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}



