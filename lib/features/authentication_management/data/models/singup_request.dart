class SignupRequest {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String phoneE164;
  final String packageName;
  final String country;
  final String city;
  final String street;
  final String postalCode;
  final String? profileImage;

  const SignupRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.phoneE164,
    required this.packageName,
    required this.country,
    required this.city,
    required this.street,
    required this.postalCode,
    this.profileImage,
  });

  /// Converts request to API body
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "first_name": firstName,
      "last_name": lastName,
      "phone_e164": phoneE164,
      "package_name": packageName,
      "country": country,
      "city": city,
      "street": street,
      // "postal_code": postalCode,
      "profile_image": profileImage,
    };
  }
}
