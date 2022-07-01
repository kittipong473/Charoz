// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeModel {
  final int timeId;
  final int shopId;
  final String timeOpen;
  final String timeClose;
  final String timeStatus;
  final String timeChoose;
  TimeModel({
    required this.timeId,
    required this.shopId,
    required this.timeOpen,
    required this.timeClose,
    required this.timeStatus,
    required this.timeChoose,
  });

  TimeModel copyWith({
    int? timeId,
    int? shopId,
    String? timeOpen,
    String? timeClose,
    String? timeStatus,
    String? timeChoose,
  }) {
    return TimeModel(
      timeId: timeId ?? this.timeId,
      shopId: shopId ?? this.shopId,
      timeOpen: timeOpen ?? this.timeOpen,
      timeClose: timeClose ?? this.timeClose,
      timeStatus: timeStatus ?? this.timeStatus,
      timeChoose: timeChoose ?? this.timeChoose,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeId': timeId,
      'shopId': shopId,
      'timeOpen': timeOpen,
      'timeClose': timeClose,
      'timeStatus': timeStatus,
      'timeChoose': timeChoose,
    };
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel(
      timeId: map['timeId']?.toInt() ?? 0,
      shopId: map['shopId']?.toInt() ?? 0,
      timeOpen: map['timeOpen'] ?? '',
      timeClose: map['timeClose'] ?? '',
      timeStatus: map['timeStatus'] ?? '',
      timeChoose: map['timeChoose'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) => TimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TimeModel(timeId: $timeId, shopId: $shopId, timeOpen: $timeOpen, timeClose: $timeClose, timeStatus: $timeStatus, timeChoose: $timeChoose)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TimeModel &&
      other.timeId == timeId &&
      other.shopId == shopId &&
      other.timeOpen == timeOpen &&
      other.timeClose == timeClose &&
      other.timeStatus == timeStatus &&
      other.timeChoose == timeChoose;
  }

  @override
  int get hashCode {
    return timeId.hashCode ^
      shopId.hashCode ^
      timeOpen.hashCode ^
      timeClose.hashCode ^
      timeStatus.hashCode ^
      timeChoose.hashCode;
  }
}
