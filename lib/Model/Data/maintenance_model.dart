// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MaintenanceModel {
  String? id;
  String? name;
  String? detail;
  int? status;
  MaintenanceModel({
    this.id,
    this.name,
    this.detail,
    this.status,
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
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'status': status,
    };
  }

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceModel.fromJson(String source) =>
      MaintenanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MaintenanceModel(id: $id, name: $name, detail: $detail, status: $status)';
  }

  @override
  bool operator ==(covariant MaintenanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.detail == detail &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ detail.hashCode ^ status.hashCode;
  }
}

MaintenanceModel convertMaintenance(dynamic item, String? id) {
  return MaintenanceModel(
    id: id ?? item.id,
    name: item['name'],
    detail: item['detail'],
    status: item['status'],
  );
}
