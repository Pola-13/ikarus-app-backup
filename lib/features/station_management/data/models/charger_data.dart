class ChargerData {
  ChargerData({
    required this.id,
    required this.name,
    required this.station,
    required this.status,
    required this.visibility,
    required this.brand,
    required this.serialNumber,
    required this.ocppIdentifier,
    required this.kwhLimit,
    required this.lastHeartbeatAt,
    required this.connectorSummary,
    required this.connectorCount,
    required this.restricted,
  });

  final String? id;
  final String? name;
  final ChargerStation? station;
  final String? status;
  final String? visibility;
  final String? brand;
  final String? serialNumber;
  final String? ocppIdentifier;
  final double? kwhLimit;
  final String? lastHeartbeatAt;
  final Map<String, dynamic>? connectorSummary;
  final int? connectorCount;
  final bool? restricted;

  factory ChargerData.fromJson(Map<String, dynamic> json) {
    return ChargerData(
      id: json["id"],
      name: json["name"],
      station: json["station"] == null
          ? null
          : ChargerStation.fromJson(json["station"]),
      status: json["status"],
      visibility: json["visibility"],
      brand: json["brand"],
      serialNumber: json["serial_number"],
      ocppIdentifier: json["ocpp_identifier"],
      kwhLimit: json["kwh_limit"]?.toDouble(),
      lastHeartbeatAt: json["last_heartbeat_at"],
      connectorSummary: json["connector_summary"],
      connectorCount: json["connector_count"],
      restricted: json["restricted"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "station": station?.toJson(),
    "status": status,
    "visibility": visibility,
    "brand": brand,
    "serial_number": serialNumber,
    "ocpp_identifier": ocppIdentifier,
    "kwh_limit": kwhLimit,
    "last_heartbeat_at": lastHeartbeatAt,
    "connector_summary": connectorSummary,
    "connector_count": connectorCount,
    "restricted": restricted,
  };
}

class ChargerStation {
  ChargerStation({
    required this.id,
    required this.name,
    required this.governorate,
    required this.latitude,
    required this.longitude,
  });

  final String? id;
  final String? name;
  final String? governorate;
  final double? latitude;
  final double? longitude;

  factory ChargerStation.fromJson(Map<String, dynamic> json) {
    return ChargerStation(
      id: json["id"],
      name: json["name"],
      governorate: json["governorate"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "governorate": governorate,
    "latitude": latitude,
    "longitude": longitude,
  };
}

