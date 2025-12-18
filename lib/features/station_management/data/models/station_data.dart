class StationData {
  StationData({
    required this.id,
    required this.name,
    required this.address,
    required this.country,
    required this.governorate,
    required this.serviceProvider,
    required this.maintenancePartner,
    required this.siteOwner,
    required this.latitude,
    required this.longitude,
    required this.visibility,
    required this.status,
    required this.chargersCount,
    required this.connectorSummary,
    required this.images,
  });

  final String? id;
  final String? name;
  final String? address;
  final dynamic country;
  final String? governorate;
  final String? serviceProvider;
  final String? maintenancePartner;
  final String? siteOwner;
  final double? latitude;
  final double? longitude;
  final String? visibility;
  final String? status;
  final int? chargersCount;
  final ConnectorSummary? connectorSummary;
  final List<dynamic> images;

  StationData copyWith({
    String? id,
    String? name,
    String? address,
    dynamic? country,
    String? governorate,
    String? serviceProvider,
    String? maintenancePartner,
    String? siteOwner,
    double? latitude,
    double? longitude,
    String? visibility,
    String? status,
    int? chargersCount,
    ConnectorSummary? connectorSummary,
    List<dynamic>? images,
  }) {
    return StationData(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      country: country ?? this.country,
      governorate: governorate ?? this.governorate,
      serviceProvider: serviceProvider ?? this.serviceProvider,
      maintenancePartner: maintenancePartner ?? this.maintenancePartner,
      siteOwner: siteOwner ?? this.siteOwner,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      visibility: visibility ?? this.visibility,
      status: status ?? this.status,
      chargersCount: chargersCount ?? this.chargersCount,
      connectorSummary: connectorSummary ?? this.connectorSummary,
      images: images ?? this.images,
    );
  }

  factory StationData.fromJson(Map<String, dynamic> json) {
    return StationData(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      country: json["country"],
      governorate: json["governorate"],
      serviceProvider: json["service_provider"],
      maintenancePartner: json["maintenance_partner"],
      siteOwner: json["site_owner"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      visibility: json["visibility"],
      status: json["status"],
      chargersCount: json["chargers_count"],
      connectorSummary:
          json["connector_summary"] == null
              ? null
              : ConnectorSummary.fromJson(json["connector_summary"]),
      images:
          json["images"] == null
              ? []
              : List<dynamic>.from(json["images"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "country": country,
    "governorate": governorate,
    "service_provider": serviceProvider,
    "maintenance_partner": maintenancePartner,
    "site_owner": siteOwner,
    "latitude": latitude,
    "longitude": longitude,
    "visibility": visibility,
    "status": status,
    "chargers_count": chargersCount,
    "connector_summary": connectorSummary?.toJson(),
    "images": images.map((x) => x).toList(),
  };
}

class ConnectorSummary {
  ConnectorSummary({
    required this.planned,
    required this.charging,
    required this.available,
    required this.unavailable,
    required this.faulted,
    required this.preparing,
  });

  final int? planned;
  final int? charging;
  final int? available;
  final int? unavailable;
  final int? faulted;
  final int? preparing;

  ConnectorSummary copyWith({
    int? planned,
    int? charging,
    int? available,
    int? unavailable,
    int? faulted,
    int? preparing,
  }) {
    return ConnectorSummary(
      planned: planned ?? this.planned,
      charging: charging ?? this.charging,
      available: available ?? this.available,
      unavailable: unavailable ?? this.unavailable,
      faulted: faulted ?? this.faulted,
      preparing: preparing ?? this.preparing,
    );
  }

  factory ConnectorSummary.fromJson(Map<String, dynamic> json) {
    return ConnectorSummary(
      planned: json["planned"],
      charging: json["charging"],
      available: json["available"],
      unavailable: json["unavailable"],
      faulted: json["faulted"],
      preparing: json["preparing"],
    );
  }

  Map<String, dynamic> toJson() => {
    "planned": planned,
    "charging": charging,
    "available": available,
    "unavailable": unavailable,
    "faulted": faulted,
    "preparing": preparing,
  };
}
