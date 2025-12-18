class CityModel {
  final String id;
  final String name;
  final String countryCode;

  CityModel({
    required this.id,
    required this.name,
    required this.countryCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] as String,
      name: json["name"] as String,
      countryCode: json["country_code"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
      };
}

