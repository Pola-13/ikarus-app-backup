class ConnectorData {
  ConnectorData({
    required this.id,
    required this.chargerId,
    required this.stationId,
    required this.connectorNumber,
    required this.identifier,
    required this.status,
    required this.energyType,
    required this.powerKw,
    required this.lastStatusChange,
  });

  final String? id;
  final String? chargerId;
  final String? stationId;
  final int? connectorNumber;
  final String? identifier;
  final String? status;
  final String? energyType;
  final double? powerKw;
  final String? lastStatusChange;

  factory ConnectorData.fromJson(Map<String, dynamic> json) {
    return ConnectorData(
      id: json["id"],
      chargerId: json["charger_id"],
      stationId: json["station_id"],
      connectorNumber: json["connector_number"],
      identifier: json["identifier"],
      status: json["status"],
      energyType: json["energy_type"],
      powerKw: json["power_kw"]?.toDouble(),
      lastStatusChange: json["last_status_change"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "charger_id": chargerId,
    "station_id": stationId,
    "connector_number": connectorNumber,
    "identifier": identifier,
    "status": status,
    "energy_type": energyType,
    "power_kw": powerKw,
    "last_status_change": lastStatusChange,
  };
}

