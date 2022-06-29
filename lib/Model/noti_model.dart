// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiModel {
  final int notiId;
  final String notiType;
  final String notiName;
  final String notiDetail;
  final String notiImage;
  final DateTime notiStart;
  final DateTime notiEnd;
  final int notiStatus;
  NotiModel({
    required this.notiId,
    required this.notiType,
    required this.notiName,
    required this.notiDetail,
    required this.notiImage,
    required this.notiStart,
    required this.notiEnd,
    required this.notiStatus,
  });

  NotiModel copyWith({
    int? notiId,
    String? notiType,
    String? notiName,
    String? notiDetail,
    String? notiImage,
    DateTime? notiStart,
    DateTime? notiEnd,
    int? notiStatus,
  }) {
    return NotiModel(
      notiId: notiId ?? this.notiId,
      notiType: notiType ?? this.notiType,
      notiName: notiName ?? this.notiName,
      notiDetail: notiDetail ?? this.notiDetail,
      notiImage: notiImage ?? this.notiImage,
      notiStart: notiStart ?? this.notiStart,
      notiEnd: notiEnd ?? this.notiEnd,
      notiStatus: notiStatus ?? this.notiStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notiId': notiId,
      'notiType': notiType,
      'notiName': notiName,
      'notiDetail': notiDetail,
      'notiImage': notiImage,
      'notiStart': notiStart.millisecondsSinceEpoch,
      'notiEnd': notiEnd.millisecondsSinceEpoch,
      'notiStatus': notiStatus,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      notiId: map['notiId'] as int,
      notiType: map['notiType'] as String,
      notiName: map['notiName'] as String,
      notiDetail: map['notiDetail'] as String,
      notiImage: map['notiImage'] as String,
      notiStart: DateTime.fromMillisecondsSinceEpoch(map['notiStart'] as int),
      notiEnd: DateTime.fromMillisecondsSinceEpoch(map['notiEnd'] as int),
      notiStatus: map['notiStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) =>
      NotiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotiModel(notiId: $notiId, notiType: $notiType, notiName: $notiName, notiDetail: $notiDetail, notiImage: $notiImage, notiStart: $notiStart, notiEnd: $notiEnd, notiStatus: $notiStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiModel &&
        other.notiId == notiId &&
        other.notiType == notiType &&
        other.notiName == notiName &&
        other.notiDetail == notiDetail &&
        other.notiImage == notiImage &&
        other.notiStart == notiStart &&
        other.notiEnd == notiEnd &&
        other.notiStatus == notiStatus;
  }

  @override
  int get hashCode {
    return notiId.hashCode ^
        notiType.hashCode ^
        notiName.hashCode ^
        notiDetail.hashCode ^
        notiImage.hashCode ^
        notiStart.hashCode ^
        notiEnd.hashCode ^
        notiStatus.hashCode;
  }
}
