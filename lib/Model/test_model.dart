import 'dart:convert';

class TestModel {
  final int id;
  final String name;
  final String url;
  final String time;
  TestModel({
    required this.id,
    required this.name,
    required this.url,
    required this.time,
  });

  TestModel copyWith({
    int? id,
    String? name,
    String? url,
    String? time,
  }) {
    return TestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'time': time,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestModel(id: $id, name: $name, url: $url, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TestModel &&
      other.id == id &&
      other.name == name &&
      other.url == url &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      url.hashCode ^
      time.hashCode;
  }
}
