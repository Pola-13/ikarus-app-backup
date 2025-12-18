class DistrictModel {
  final String id;
  final String name;
  final String? cityId;

  DistrictModel({
    required this.id,
    required this.name,
    this.cityId,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json["id"] as String,
      name: json["name"] as String,
      cityId: json["city_id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city_id": cityId,
      };
}

