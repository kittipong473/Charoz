import 'dart:convert';

class MaintenanceModel {
  final String maintainId;
  final String maintainName;
  final String maintainDetail;
  final String maintainStatus;
  MaintenanceModel({
    required this.maintainId,
    required this.maintainName,
    required this.maintainDetail,
    required this.maintainStatus,
  });

  MaintenanceModel copyWith({
    String? maintainId,
    String? maintainName,
    String? maintainDetail,
    String? maintainStatus,
  }) {
    return MaintenanceModel(
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

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceModel(
      maintainId: map['maintainId'] ?? '',
      maintainName: map['maintainName'] ?? '',
      maintainDetail: map['maintainDetail'] ?? '',
      maintainStatus: map['maintainStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceModel.fromJson(String source) =>
      MaintenanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MaintainModel(maintainId: $maintainId, maintainName: $maintainName, maintainDetail: $maintainDetail, maintainStatus: $maintainStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaintenanceModel &&
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
