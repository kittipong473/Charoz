import 'dart:convert';

class SuggestionModel {
  final String suggestId;
  final String suggestAge;
  final String suggestJob;
  final String suggestScore;
  final String suggestTotal;
  final String suggestDetail;
  final String created;
  SuggestionModel({
    required this.suggestId,
    required this.suggestAge,
    required this.suggestJob,
    required this.suggestScore,
    required this.suggestTotal,
    required this.suggestDetail,
    required this.created,
  });

  SuggestionModel copyWith({
    String? suggestId,
    String? suggestAge,
    String? suggestJob,
    String? suggestScore,
    String? suggestTotal,
    String? suggestDetail,
    String? created,
  }) {
    return SuggestionModel(
      suggestId: suggestId ?? this.suggestId,
      suggestAge: suggestAge ?? this.suggestAge,
      suggestJob: suggestJob ?? this.suggestJob,
      suggestScore: suggestScore ?? this.suggestScore,
      suggestTotal: suggestTotal ?? this.suggestTotal,
      suggestDetail: suggestDetail ?? this.suggestDetail,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'suggestId': suggestId,
      'suggestAge': suggestAge,
      'suggestJob': suggestJob,
      'suggestScore': suggestScore,
      'suggestTotal': suggestTotal,
      'suggestDetail': suggestDetail,
      'created': created,
    };
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      suggestId: map['suggestId'] ?? '',
      suggestAge: map['suggestAge'] ?? '',
      suggestJob: map['suggestJob'] ?? '',
      suggestScore: map['suggestScore'] ?? '',
      suggestTotal: map['suggestTotal'] ?? '',
      suggestDetail: map['suggestDetail'] ?? '',
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuggestionModel.fromJson(String source) => SuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SuggestionModel(suggestId: $suggestId, suggestAge: $suggestAge, suggestJob: $suggestJob, suggestScore: $suggestScore, suggestTotal: $suggestTotal, suggestDetail: $suggestDetail, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SuggestionModel &&
      other.suggestId == suggestId &&
      other.suggestAge == suggestAge &&
      other.suggestJob == suggestJob &&
      other.suggestScore == suggestScore &&
      other.suggestTotal == suggestTotal &&
      other.suggestDetail == suggestDetail &&
      other.created == created;
  }

  @override
  int get hashCode {
    return suggestId.hashCode ^
      suggestAge.hashCode ^
      suggestJob.hashCode ^
      suggestScore.hashCode ^
      suggestTotal.hashCode ^
      suggestDetail.hashCode ^
      created.hashCode;
  }
}
