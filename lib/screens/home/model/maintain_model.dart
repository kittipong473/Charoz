import 'dart:convert';

class MaintainModel {
  final String maintainId;
  final String maintainName;
  final String maintainDetail;
  final String maintainStatus;
  MaintainModel({
    required this.maintainId,
    required this.maintainName,
    required this.maintainDetail,
    required this.maintainStatus,
  });

  MaintainModel copyWith({
    String? maintainId,
    String? maintainName,
    String? maintainDetail,
    String? maintainStatus,
  }) {
    return MaintainModel(
      maintainId: maintainId ?? this.maintainId,
      maintainName: maintainName ?? this.maintainName,
      maintainDetail: maintainDetail ?? this.maintainDetail,
      maintainStatus: maintainStatus ?? this.maintainStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maintainId': maintainId,
      'maintainName': maintainName,
      'maintainDetail': maintainDetail,
      'maintainStatus': maintainStatus,
    };
  }

  factory MaintainModel.fromMap(Map<String, dynamic> map) {
    return MaintainModel(
      maintainId: map['maintainId'] ?? '',
      maintainName: map['maintainName'] ?? '',
      maintainDetail: map['maintainDetail'] ?? '',
      maintainStatus: map['maintainStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintainModel.fromJson(String source) => MaintainModel.fromMap(json.decode(source));

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
