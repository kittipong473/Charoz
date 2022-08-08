// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MaintenanceModel {
  final String id;
  final String name;
  final String detail;
  final int status;
  MaintenanceModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.status,
  });

  MaintenanceModel copyWith({
    String? id,
    String? name,
    String? detail,
    int? status,
  }) {
    return MaintenanceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'status': status,
    };
  }

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceModel.fromJson(String source) =>
      MaintenanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MaintenanceModel(id: $id, name: $name, detail: $detail, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaintenanceModel &&
        other.id == id &&
        other.name == name &&
        other.detail == detail &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ detail.hashCode ^ status.hashCode;
  }
}

MaintenanceModel convertMaintenance(dynamic item) {
  return MaintenanceModel(
    id: item.id,
    name: item['name'],
    detail: item['detail'],
    status: item['status'],
  );
}
