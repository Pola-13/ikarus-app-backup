class CountryModel {
  final String code;
  final String name;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;

  CountryModel({
    required this.code,
    required this.name,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json["code"] as String,
      name: json["name"] as String,
      currencyCode: json["currency_code"] as String,
      currencyName: json["currency_name"] as String,
      currencySymbol: json["currency_symbol"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "currency_code": currencyCode,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
      };
}

