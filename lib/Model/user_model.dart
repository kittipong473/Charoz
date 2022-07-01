// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int userId;
  final String userFirstName;
  final String userLastName;
  final DateTime userBirth;
  final String userEmail;
  final String userPhone;
  final String userImage;
  final String userRole;
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
    required this.userImage,
    required this.userRole,
    required this.userEmailToken,
    required this.userPhoneToken,
    required this.userGoogleToken,
  });

  UserModel copyWith({
    int? userId,
    String? userFirstName,
    String? userLastName,
    DateTime? userBirth,
    String? userEmail,
    String? userPhone,
    String? userImage,
    String? userRole,
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
      userImage: userImage ?? this.userImage,
      userRole: userRole ?? this.userRole,
      userEmailToken: userEmailToken ?? this.userEmailToken,
      userPhoneToken: userPhoneToken ?? this.userPhoneToken,
      userGoogleToken: userGoogleToken ?? this.userGoogleToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userBirth': userBirth.millisecondsSinceEpoch,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userImage': userImage,
      'userRole': userRole,
      'userEmailToken': userEmailToken,
      'userPhoneToken': userPhoneToken,
      'userGoogleToken': userGoogleToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId']?.toInt() ?? 0,
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      userBirth: DateTime.fromMillisecondsSinceEpoch(map['userBirth']),
      userEmail: map['userEmail'] ?? '',
      userPhone: map['userPhone'] ?? '',
      userImage: map['userImage'] ?? '',
      userRole: map['userRole'] ?? '',
      userEmailToken: map['userEmailToken'] ?? '',
      userPhoneToken: map['userPhoneToken'] ?? '',
      userGoogleToken: map['userGoogleToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, userBirth: $userBirth, userEmail: $userEmail, userPhone: $userPhone, userImage: $userImage, userRole: $userRole, userEmailToken: $userEmailToken, userPhoneToken: $userPhoneToken, userGoogleToken: $userGoogleToken)';
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
      other.userImage == userImage &&
      other.userRole == userRole &&
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
      userImage.hashCode ^
      userRole.hashCode ^
      userEmailToken.hashCode ^
      userPhoneToken.hashCode ^
      userGoogleToken.hashCode;
  }
}
