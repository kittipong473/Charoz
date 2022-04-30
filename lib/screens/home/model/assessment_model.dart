import 'dart:convert';

class AssessmentModel {
  final String assessId;
  final String assessName;
  AssessmentModel({
    required this.assessId,
    required this.assessName,
  });

  AssessmentModel copyWith({
    String? assessId,
    String? assessName,
  }) {
    return AssessmentModel(
      assessId: assessId ?? this.assessId,
      assessName: assessName ?? this.assessName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assessId': assessId,
      'assessName': assessName,
    };
  }

  factory AssessmentModel.fromMap(Map<String, dynamic> map) {
    return AssessmentModel(
      assessId: map['assessId'] ?? '',
      assessName: map['assessName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssessmentModel.fromJson(String source) => AssessmentModel.fromMap(json.decode(source));

  @override
  String toString() => 'AssessmentModel(assessId: $assessId, assessName: $assessName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AssessmentModel &&
      other.assessId == assessId &&
      other.assessName == assessName;
  }

  @override
  int get hashCode => assessId.hashCode ^ assessName.hashCode;
}
