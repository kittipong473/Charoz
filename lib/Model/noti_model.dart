// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiModel {
  final int notiId;
  final int userId;
  final String notiType;
  final String notiName;
  final String notiDetail;
  final String notiImage;
  final DateTime notiStart;
  final DateTime notiEnd;
  final int notiStatus;
  NotiModel({
    required this.notiId,
    required this.userId,
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
    int? userId,
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
      userId: userId ?? this.userId,
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
    return {
      'notiId': notiId,
      'userId': userId,
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
      notiId: map['notiId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      notiType: map['notiType'] ?? '',
      notiName: map['notiName'] ?? '',
      notiDetail: map['notiDetail'] ?? '',
      notiImage: map['notiImage'] ?? '',
      notiStart: DateTime.fromMillisecondsSinceEpoch(map['notiStart']),
      notiEnd: DateTime.fromMillisecondsSinceEpoch(map['notiEnd']),
      notiStatus: map['notiStatus']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) =>
      NotiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiModel(notiId: $notiId, userId: $userId, notiType: $notiType, notiName: $notiName, notiDetail: $notiDetail, notiImage: $notiImage, notiStart: $notiStart, notiEnd: $notiEnd, notiStatus: $notiStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotiModel &&
        other.notiId == notiId &&
        other.userId == userId &&
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
        userId.hashCode ^
        notiType.hashCode ^
        notiName.hashCode ^
        notiDetail.hashCode ^
        notiImage.hashCode ^
        notiStart.hashCode ^
        notiEnd.hashCode ^
        notiStatus.hashCode;
  }
}

NotiModel convertNoti(dynamic item) {
  return NotiModel(
    notiId: int.parse(item['notiId']),
    userId: int.parse(item['userId']),
    notiType: item['notiType'],
    notiName: item['notiName'],
    notiDetail: item['notiDetail'],
    notiImage: item['notiImage'],
    notiStart: DateTime.parse(item['notiStart']),
    notiEnd: DateTime.parse(item['notiEnd']),
    notiStatus: int.parse(item['notiStatus']),
  );
}
