// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeModel {
  final int timeId;
  final int shopId;
  final String timeWeekdayOpen;
  final String timeWeekdayClose;
  final String timeWeekendOpen;
  final String timeWeekendClose;
  final String timeStatus;
  final String timeChoose;
  TimeModel({
    required this.timeId,
    required this.shopId,
    required this.timeWeekdayOpen,
    required this.timeWeekdayClose,
    required this.timeWeekendOpen,
    required this.timeWeekendClose,
    required this.timeStatus,
    required this.timeChoose,
  });

  TimeModel copyWith({
    int? timeId,
    int? shopId,
    String? timeWeekdayOpen,
    String? timeWeekdayClose,
    String? timeWeekendOpen,
    String? timeWeekendClose,
    String? timeStatus,
    String? timeChoose,
  }) {
    return TimeModel(
      timeId: timeId ?? this.timeId,
      shopId: shopId ?? this.shopId,
      timeWeekdayOpen: timeWeekdayOpen ?? this.timeWeekdayOpen,
      timeWeekdayClose: timeWeekdayClose ?? this.timeWeekdayClose,
      timeWeekendOpen: timeWeekendOpen ?? this.timeWeekendOpen,
      timeWeekendClose: timeWeekendClose ?? this.timeWeekendClose,
      timeStatus: timeStatus ?? this.timeStatus,
      timeChoose: timeChoose ?? this.timeChoose,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeId': timeId,
      'shopId': shopId,
      'timeWeekdayOpen': timeWeekdayOpen,
      'timeWeekdayClose': timeWeekdayClose,
      'timeWeekendOpen': timeWeekendOpen,
      'timeWeekendClose': timeWeekendClose,
      'timeStatus': timeStatus,
      'timeChoose': timeChoose,
    };
  }

  factory TimeModel.fromMap(Map<String, dynamic> map) {
    return TimeModel(
      timeId: map['timeId'] as int,
      shopId: map['shopId'] as int,
      timeWeekdayOpen: map['timeWeekdayOpen'] as String,
      timeWeekdayClose: map['timeWeekdayClose'] as String,
      timeWeekendOpen: map['timeWeekendOpen'] as String,
      timeWeekendClose: map['timeWeekendClose'] as String,
      timeStatus: map['timeStatus'] as String,
      timeChoose: map['timeChoose'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeModel.fromJson(String source) =>
      TimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeModel(timeId: $timeId, shopId: $shopId, timeWeekdayOpen: $timeWeekdayOpen, timeWeekdayClose: $timeWeekdayClose, timeWeekendOpen: $timeWeekendOpen, timeWeekendClose: $timeWeekendClose, timeStatus: $timeStatus, timeChoose: $timeChoose)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeModel &&
        other.timeId == timeId &&
        other.shopId == shopId &&
        other.timeWeekdayOpen == timeWeekdayOpen &&
        other.timeWeekdayClose == timeWeekdayClose &&
        other.timeWeekendOpen == timeWeekendOpen &&
        other.timeWeekendClose == timeWeekendClose &&
        other.timeStatus == timeStatus &&
        other.timeChoose == timeChoose;
  }

  @override
  int get hashCode {
    return timeId.hashCode ^
        shopId.hashCode ^
        timeWeekdayOpen.hashCode ^
        timeWeekdayClose.hashCode ^
        timeWeekendOpen.hashCode ^
        timeWeekendClose.hashCode ^
        timeStatus.hashCode ^
        timeChoose.hashCode;
  }
}
