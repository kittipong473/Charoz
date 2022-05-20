// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String userBirth;
  final String userEmail;
  final String userPhone;
  final String userRole;
  final String userLocation;
  final String userEmailToken;
  final String userPhoneToken;
  final String userGoogleToken;
  UserModel({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userBirth,
    required this.userEmail,
    required this.userPhone,
    required this.userRole,
    required this.userLocation,
    required this.userEmailToken,
    required this.userPhoneToken,
    required this.userGoogleToken,
  });

  UserModel copyWith({
    String? userId,
    String? userFirstName,
    String? userLastName,
    String? userBirth,
    String? userEmail,
    String? userPhone,
    String? userRole,
    String? userLocation,
    String? userEmailToken,
    String? userPhoneToken,
    String? userGoogleToken,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userBirth: userBirth ?? this.userBirth,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userRole: userRole ?? this.userRole,
      userLocation: userLocation ?? this.userLocation,
      userEmailToken: userEmailToken ?? this.userEmailToken,
      userPhoneToken: userPhoneToken ?? this.userPhoneToken,
      userGoogleToken: userGoogleToken ?? this.userGoogleToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userBirth': userBirth,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userRole': userRole,
      'userLocation': userLocation,
      'userEmailToken': userEmailToken,
      'userPhoneToken': userPhoneToken,
      'userGoogleToken': userGoogleToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      userFirstName: map['userFirstName'] as String,
      userLastName: map['userLastName'] as String,
      userBirth: map['userBirth'] as String,
      userEmail: map['userEmail'] as String,
      userPhone: map['userPhone'] as String,
      userRole: map['userRole'] as String,
      userLocation: map['userLocation'] as String,
      userEmailToken: map['userEmailToken'] as String,
      userPhoneToken: map['userPhoneToken'] as String,
      userGoogleToken: map['userGoogleToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, userBirth: $userBirth, userEmail: $userEmail, userPhone: $userPhone, userRole: $userRole, userLocation: $userLocation, userEmailToken: $userEmailToken, userPhoneToken: $userPhoneToken, userGoogleToken: $userGoogleToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.userBirth == userBirth &&
        other.userEmail == userEmail &&
        other.userPhone == userPhone &&
        other.userRole == userRole &&
        other.userLocation == userLocation &&
        other.userEmailToken == userEmailToken &&
        other.userPhoneToken == userPhoneToken &&
        other.userGoogleToken == userGoogleToken;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        userBirth.hashCode ^
        userEmail.hashCode ^
        userPhone.hashCode ^
        userRole.hashCode ^
        userLocation.hashCode ^
        userEmailToken.hashCode ^
        userPhoneToken.hashCode ^
        userGoogleToken.hashCode;
  }
}
