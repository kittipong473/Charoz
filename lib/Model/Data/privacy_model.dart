// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrivacyModel {
  String? id;
  String? name;
  String? detail;
  int? number;
  PrivacyModel({
    this.id,
    this.name,
    this.detail,
    this.number,
  });

  PrivacyModel copyWith({
    String? id,
    String? name,
    String? detail,
    int? number,
  }) {
    return PrivacyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'number': number,
    };
  }

  factory PrivacyModel.fromMap(Map<String, dynamic> map) {
    return PrivacyModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      number: map['number'] != null ? map['number'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivacyModel.fromJson(String source) =>
      PrivacyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrivacyModel(id: $id, name: $name, detail: $detail, number: $number)';
  }

  @override
  bool operator ==(covariant PrivacyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.detail == detail &&
        other.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ detail.hashCode ^ number.hashCode;
  }
}

PrivacyModel convertPrivacy(dynamic item, String? id) {
  return PrivacyModel(
    id: id ?? item.id,
    name: item['name'],
    detail: item['detail'],
    number: item['number'],
  );
}
