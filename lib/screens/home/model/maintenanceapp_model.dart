import 'dart:convert';

class MaintenanceApp {
  final String id;
  final String shopid;
  final String status;
  MaintenanceApp({
    required this.id,
    required this.shopid,
    required this.status,
  });

  MaintenanceApp copyWith({
    String? id,
    String? shopid,
    String? status,
  }) {
    return MaintenanceApp(
      id: id ?? this.id,
      shopid: shopid ?? this.shopid,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopid': shopid,
      'status': status,
    };
  }

  factory MaintenanceApp.fromMap(Map<String, dynamic> map) {
    return MaintenanceApp(
      id: map['id'] ?? '',
      shopid: map['shopid'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceApp.fromJson(String source) => MaintenanceApp.fromMap(json.decode(source));

  @override
  String toString() => 'MaintenanceApp(id: $id, shopid: $shopid, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MaintenanceApp &&
      other.id == id &&
      other.shopid == shopid &&
      other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ shopid.hashCode ^ status.hashCode;
}
