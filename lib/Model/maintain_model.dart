// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MaintainModel {
  final int maintainId;
  final String maintainName;
  final String maintainDetail;
  final int maintainStatus;
  MaintainModel({
    required this.maintainId,
    required this.maintainName,
    required this.maintainDetail,
    required this.maintainStatus,
  });

  MaintainModel copyWith({
    int? maintainId,
    String? maintainName,
    String? maintainDetail,
    int? maintainStatus,
  }) {
    return MaintainModel(
      maintainId: maintainId ?? this.maintainId,
      maintainName: maintainName ?? this.maintainName,
      maintainDetail: maintainDetail ?? this.maintainDetail,
      maintainStatus: maintainStatus ?? this.maintainStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maintainId': maintainId,
      'maintainName': maintainName,
      'maintainDetail': maintainDetail,
      'maintainStatus': maintainStatus,
    };
  }

  factory MaintainModel.fromMap(Map<String, dynamic> map) {
    return MaintainModel(
      maintainId: map['maintainId'] as int,
      maintainName: map['maintainName'] as String,
      maintainDetail: map['maintainDetail'] as String,
      maintainStatus: map['maintainStatus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintainModel.fromJson(String source) =>
      MaintainModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MaintainModel(maintainId: $maintainId, maintainName: $maintainName, maintainDetail: $maintainDetail, maintainStatus: $maintainStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaintainModel &&
        other.maintainId == maintainId &&
        other.maintainName == maintainName &&
        other.maintainDetail == maintainDetail &&
        other.maintainStatus == maintainStatus;
  }

  @override
  int get hashCode {
    return maintainId.hashCode ^
        maintainName.hashCode ^
        maintainDetail.hashCode ^
        maintainStatus.hashCode;
  }
}
