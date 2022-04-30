import 'dart:convert';

class NotiModel {
  final String notiId;
  final String notiType;
  final String notiName;
  final String notiDetail;
  final String notiImage;
  final String notiRefer;
  final String notiStart;
  final String notiEnd;
  final String notiStatus;
  NotiModel({
    required this.notiId,
    required this.notiType,
    required this.notiName,
    required this.notiDetail,
    required this.notiImage,
    required this.notiRefer,
    required this.notiStart,
    required this.notiEnd,
    required this.notiStatus,
  });

  NotiModel copyWith({
    String? notiId,
    String? notiType,
    String? notiName,
    String? notiDetail,
    String? notiImage,
    String? notiRefer,
    String? notiStart,
    String? notiEnd,
    String? notiStatus,
  }) {
    return NotiModel(
      notiId: notiId ?? this.notiId,
      notiType: notiType ?? this.notiType,
      notiName: notiName ?? this.notiName,
      notiDetail: notiDetail ?? this.notiDetail,
      notiImage: notiImage ?? this.notiImage,
      notiRefer: notiRefer ?? this.notiRefer,
      notiStart: notiStart ?? this.notiStart,
      notiEnd: notiEnd ?? this.notiEnd,
      notiStatus: notiStatus ?? this.notiStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notiId': notiId,
      'notiType': notiType,
      'notiName': notiName,
      'notiDetail': notiDetail,
      'notiImage': notiImage,
      'notiRefer': notiRefer,
      'notiStart': notiStart,
      'notiEnd': notiEnd,
      'notiStatus': notiStatus,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      notiId: map['notiId'] ?? '',
      notiType: map['notiType'] ?? '',
      notiName: map['notiName'] ?? '',
      notiDetail: map['notiDetail'] ?? '',
      notiImage: map['notiImage'] ?? '',
      notiRefer: map['notiRefer'] ?? '',
      notiStart: map['notiStart'] ?? '',
      notiEnd: map['notiEnd'] ?? '',
      notiStatus: map['notiStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) => NotiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotiModel(notiId: $notiId, notiType: $notiType, notiName: $notiName, notiDetail: $notiDetail, notiImage: $notiImage, notiRefer: $notiRefer, notiStart: $notiStart, notiEnd: $notiEnd, notiStatus: $notiStatus)';
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
      other.notiRefer == notiRefer &&
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
      notiRefer.hashCode ^
      notiStart.hashCode ^
      notiEnd.hashCode ^
      notiStatus.hashCode;
  }
}
