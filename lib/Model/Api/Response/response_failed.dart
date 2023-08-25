import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseFailed {
  List<ErrorsModel>? errors;
  int? code;
  ResponseFailed({
    this.errors,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errors': errors!.map((x) => x.toMap()).toList(),
      'code': code,
    };
  }

  factory ResponseFailed.fromMap(Map<String, dynamic> map) {
    return ResponseFailed(
      errors: map['errors'] != null
          ? List<ErrorsModel>.from(
              (map['errors'] as List<int>).map<ErrorsModel?>(
                (x) => ErrorsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      code: map['code'] != null ? map['code'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseFailed.fromJson(String source) =>
      ResponseFailed.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ErrorsModel {
  List<dynamic>? detail;
  String? message;
  ErrorsModel({
    this.detail,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detail': detail,
      'message': message,
    };
  }

  factory ErrorsModel.fromMap(Map<String, dynamic> map) {
    return ErrorsModel(
      detail: map['detail'] != null
          ? List<dynamic>.from((map['detail'] as List<dynamic>))
          : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorsModel.fromJson(String source) =>
      ErrorsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
