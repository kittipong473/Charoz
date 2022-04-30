import 'dart:convert';

class DeviceModel {
  final String deviceId;
  final String deviceIdentify;
  final String deviceName;
  final String deviceVersion;
  final String deviceCount;
  final String deviceDate;
  DeviceModel({
    required this.deviceId,
    required this.deviceIdentify,
    required this.deviceName,
    required this.deviceVersion,
    required this.deviceCount,
    required this.deviceDate,
  });

  DeviceModel copyWith({
    String? deviceId,
    String? deviceIdentify,
    String? deviceName,
    String? deviceVersion,
    String? deviceCount,
    String? deviceDate,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      deviceIdentify: deviceIdentify ?? this.deviceIdentify,
      deviceName: deviceName ?? this.deviceName,
      deviceVersion: deviceVersion ?? this.deviceVersion,
      deviceCount: deviceCount ?? this.deviceCount,
      deviceDate: deviceDate ?? this.deviceDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'deviceIdentify': deviceIdentify,
      'deviceName': deviceName,
      'deviceVersion': deviceVersion,
      'deviceCount': deviceCount,
      'deviceDate': deviceDate,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      deviceId: map['deviceId'] ?? '',
      deviceIdentify: map['deviceIdentify'] ?? '',
      deviceName: map['deviceName'] ?? '',
      deviceVersion: map['deviceVersion'] ?? '',
      deviceCount: map['deviceCount'] ?? '',
      deviceDate: map['deviceDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) => DeviceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeviceModel(deviceId: $deviceId, deviceIdentify: $deviceIdentify, deviceName: $deviceName, deviceVersion: $deviceVersion, deviceCount: $deviceCount, deviceDate: $deviceDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DeviceModel &&
      other.deviceId == deviceId &&
      other.deviceIdentify == deviceIdentify &&
      other.deviceName == deviceName &&
      other.deviceVersion == deviceVersion &&
      other.deviceCount == deviceCount &&
      other.deviceDate == deviceDate;
  }

  @override
  int get hashCode {
    return deviceId.hashCode ^
      deviceIdentify.hashCode ^
      deviceName.hashCode ^
      deviceVersion.hashCode ^
      deviceCount.hashCode ^
      deviceDate.hashCode;
  }
}
