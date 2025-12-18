class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.isBlocked,
    required this.lastLoginAt,
  });

  final String? id;
  final String? email;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool? isBlocked;
  final DateTime? lastLoginAt;

  UserModel copyWith({
    String? id,
    String? email,
    String? role,
    String? firstName,
    String? lastName,
    String? phone,
    bool? isBlocked,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      isBlocked: isBlocked ?? this.isBlocked,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["id"],
      email: json["email"],
      role: json["role"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
      isBlocked: json["is_blocked"],
      lastLoginAt: DateTime.tryParse(json["last_login_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "is_blocked": isBlocked,
    "last_login_at": lastLoginAt?.toIso8601String(),
  };

}
