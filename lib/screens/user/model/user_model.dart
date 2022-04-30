import 'dart:convert';

class UserModel {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String userBirth;
  final String userEmail;
  final String userPhone;
  final String userPassword;
  final String userAddress;
  final String userLat;
  final String userLng;
  final String userRole;
  final String userStatus;
  final String userFavourite;
  final String created;
  final String updated;
  UserModel({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userBirth,
    required this.userEmail,
    required this.userPhone,
    required this.userPassword,
    required this.userAddress,
    required this.userLat,
    required this.userLng,
    required this.userRole,
    required this.userStatus,
    required this.userFavourite,
    required this.created,
    required this.updated,
  });

  UserModel copyWith({
    String? userId,
    String? userFirstName,
    String? userLastName,
    String? userBirth,
    String? userEmail,
    String? userPhone,
    String? userPassword,
    String? userAddress,
    String? userLat,
    String? userLng,
    String? userRole,
    String? userStatus,
    String? userFavourite,
    String? created,
    String? updated,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userBirth: userBirth ?? this.userBirth,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userPassword: userPassword ?? this.userPassword,
      userAddress: userAddress ?? this.userAddress,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
      userRole: userRole ?? this.userRole,
      userStatus: userStatus ?? this.userStatus,
      userFavourite: userFavourite ?? this.userFavourite,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userBirth': userBirth,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userPassword': userPassword,
      'userAddress': userAddress,
      'userLat': userLat,
      'userLng': userLng,
      'userRole': userRole,
      'userStatus': userStatus,
      'userFavourite': userFavourite,
      'created': created,
      'updated': updated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      userFirstName: map['userFirstName'] ?? '',
      userLastName: map['userLastName'] ?? '',
      userBirth: map['userBirth'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPhone: map['userPhone'] ?? '',
      userPassword: map['userPassword'] ?? '',
      userAddress: map['userAddress'] ?? '',
      userLat: map['userLat'] ?? '',
      userLng: map['userLng'] ?? '',
      userRole: map['userRole'] ?? '',
      userStatus: map['userStatus'] ?? '',
      userFavourite: map['userFavourite'] ?? '',
      created: map['created'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, userFirstName: $userFirstName, userLastName: $userLastName, userBirth: $userBirth, userEmail: $userEmail, userPhone: $userPhone, userPassword: $userPassword, userAddress: $userAddress, userLat: $userLat, userLng: $userLng, userRole: $userRole, userStatus: $userStatus, userFavourite: $userFavourite, created: $created, updated: $updated)';
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
      other.userPassword == userPassword &&
      other.userAddress == userAddress &&
      other.userLat == userLat &&
      other.userLng == userLng &&
      other.userRole == userRole &&
      other.userStatus == userStatus &&
      other.userFavourite == userFavourite &&
      other.created == created &&
      other.updated == updated;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      userFirstName.hashCode ^
      userLastName.hashCode ^
      userBirth.hashCode ^
      userEmail.hashCode ^
      userPhone.hashCode ^
      userPassword.hashCode ^
      userAddress.hashCode ^
      userLat.hashCode ^
      userLng.hashCode ^
      userRole.hashCode ^
      userStatus.hashCode ^
      userFavourite.hashCode ^
      created.hashCode ^
      updated.hashCode;
  }
}
