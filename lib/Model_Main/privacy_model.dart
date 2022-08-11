import 'dart:convert';

class PrivacyModel {
  final String id;
  final String name;
  final String detail;
  final int number;
  PrivacyModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.number,
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
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'number': number,
    };
  }

  factory PrivacyModel.fromMap(Map<String, dynamic> map) {
    return PrivacyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      detail: map['detail'] ?? '',
      number: map['number']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivacyModel.fromJson(String source) =>
      PrivacyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrivacyModel(id: $id, name: $name, detail: $detail, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrivacyModel &&
        other.id == id &&
        other.name == name &&
        other.detail == detail &&
        other.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ detail.hashCode ^ number.hashCode;
  }
}

PrivacyModel convertPrivacy(dynamic item) {
  return PrivacyModel(
    id: item.id,
    name: item['name'],
    detail: item['detail'],
    number: item['number'],
  );
}
