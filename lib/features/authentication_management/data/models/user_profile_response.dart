class UserProfileResponse {
  final UserProfileUser? user;
  final UserProfileSession? session;
  final String? serverTime;
  final CustomerProfile? customer;

  UserProfileResponse({
    this.user,
    this.session,
    this.serverTime,
    this.customer,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      user: json['user'] != null ? UserProfileUser.fromJson(json['user']) : null,
      session: json['session'] != null ? UserProfileSession.fromJson(json['session']) : null,
      serverTime: json['server_time'] as String?,
      customer: json['customer'] != null ? CustomerProfile.fromJson(json['customer']) : null,
    );
  }
}

class UserProfileUser {
  final String? id;
  final String? email;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? profileImage;
  final bool? isBlocked;
  final String? lastLoginAt;

  UserProfileUser({
    this.id,
    this.email,
    this.role,
    this.firstName,
    this.lastName,
    this.phone,
    this.profileImage,
    this.isBlocked,
    this.lastLoginAt,
  });

  factory UserProfileUser.fromJson(Map<String, dynamic> json) {
    return UserProfileUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'] as String?,
      isBlocked: json['is_blocked'] as bool?,
      lastLoginAt: json['last_login_at'] as String?,
    );
  }
}

class UserProfileSession {
  final String? token;
  final String? expiresAt;
  final String? createdAt;

  UserProfileSession({
    this.token,
    this.expiresAt,
    this.createdAt,
  });

  factory UserProfileSession.fromJson(Map<String, dynamic> json) {
    return UserProfileSession(
      token: json['token'] as String?,
      expiresAt: json['expires_at'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}

class CustomerProfile {
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
  final String? dateOfBirth;
  final String? profileImage;
  final String? packageId;
  final String? packageName;
  final dynamic package;
  final bool? isBlocked;
  final String? blockedAt;
  final String? blockedReason;
  final double? currentBalance;
  final String? createdAt;
  final String? updatedAt;

  CustomerProfile({
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

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      idTag: json['id_tag'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneE164: json['phone_e164'] as String?,
      countryCode: json['country_code'] as String?,
      country: json['country'] as String?,
      cityId: json['city_id'] as String?,
      city: json['city'] as String?,
      districtId: json['district_id'] as String?,
      district: json['district'] as String?,
      postalCode: json['postal_code'] as String?,
      preferredCurrency: json['preferred_currency'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profileImage: json['profile_image'] as String?,
      packageId: json['package_id'] as String?,
      packageName: json['package_name'] as String?,
      package: json['package'],
      isBlocked: json['is_blocked'] as bool?,
      blockedAt: json['blocked_at'] as String?,
      blockedReason: json['blocked_reason'] as String?,
      currentBalance: json['current_balance']?.toDouble(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

