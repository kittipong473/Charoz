import 'dart:convert';

import 'package:flutter/foundation.dart';

class ResponseFailed {
  final List<ErrorsModel> errors;
  final int code;
  ResponseFailed({
    required this.errors,
    required this.code,
  });

  ResponseFailed copyWith({
    List<ErrorsModel>? errors,
    int? code,
  }) {
    return ResponseFailed(
      errors: errors ?? this.errors,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errors': errors.map((x) => x.toMap()).toList(),
      'code': code,
    };
  }

  factory ResponseFailed.fromMap(Map<String, dynamic> map) {
    return ResponseFailed(
      errors: List<ErrorsModel>.from(map['errors']?.map<ErrorsModel>(
          (x) => ErrorsModel.fromMap(x as Map<String, dynamic>))),
      code: map['code'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseFailed.fromJson(String source) =>
      ResponseFailed.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseFailed(errors: $errors, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseFailed &&
        listEquals(other.errors, errors) &&
        other.code == code;
  }

  @override
  int get hashCode => errors.hashCode ^ code.hashCode;
}

class ErrorsModel {
  final List<dynamic> detail;
  final String message;
  ErrorsModel({
    required this.detail,
    required this.message,
  });

  ErrorsModel copyWith({
    List<dynamic>? detail,
    String? message,
  }) {
    return ErrorsModel(
      detail: detail ?? this.detail,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'message': message,
    };
  }

  factory ErrorsModel.fromMap(Map<String, dynamic> map) {
    return ErrorsModel(
      detail: map['detail'] ?? [],
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorsModel.fromJson(String source) => ErrorsModel.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorsModel(detail: $detail, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ErrorsModel &&
      listEquals(other.detail, detail) &&
      other.message == message;
  }

  @override
  int get hashCode => detail.hashCode ^ message.hashCode;
}
