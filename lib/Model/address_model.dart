// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final int addressId;
  final int userId;
  final String addressName;
  final String addressDetail;
  final double addressLat;
  final double addressLng;
  final DateTime created;
  final DateTime updated;
  AddressModel({
    required this.addressId,
    required this.userId,
    required this.addressName,
    required this.addressDetail,
    required this.addressLat,
    required this.addressLng,
    required this.created,
    required this.updated,
  });

  AddressModel copyWith({
    int? addressId,
    int? userId,
    String? addressName,
    String? addressDetail,
    double? addressLat,
    double? addressLng,
    DateTime? created,
    DateTime? updated,
  }) {
    return AddressModel(
      addressId: addressId ?? this.addressId,
      userId: userId ?? this.userId,
      addressName: addressName ?? this.addressName,
      addressDetail: addressDetail ?? this.addressDetail,
      addressLat: addressLat ?? this.addressLat,
      addressLng: addressLng ?? this.addressLng,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressId': addressId,
      'userId': userId,
      'addressName': addressName,
      'addressDetail': addressDetail,
      'addressLat': addressLat,
      'addressLng': addressLng,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressId: map['addressId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      addressName: map['addressName'] ?? '',
      addressDetail: map['addressDetail'] ?? '',
      addressLat: map['addressLat']?.toDouble() ?? 0.0,
      addressLng: map['addressLng']?.toDouble() ?? 0.0,
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(addressId: $addressId, userId: $userId, addressName: $addressName, addressDetail: $addressDetail, addressLat: $addressLat, addressLng: $addressLng, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.addressId == addressId &&
        other.userId == userId &&
        other.addressName == addressName &&
        other.addressDetail == addressDetail &&
        other.addressLat == addressLat &&
        other.addressLng == addressLng &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return addressId.hashCode ^
        userId.hashCode ^
        addressName.hashCode ^
        addressDetail.hashCode ^
        addressLat.hashCode ^
        addressLng.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}

AddressModel convertAddress(dynamic item) {
  return AddressModel(
    addressId: int.parse(item['addressId']),
    userId: int.parse(item['userId']),
    addressName: item['addressName'],
    addressDetail: item['addressDetail'],
    addressLat: double.parse(item['addressLat']),
    addressLng: double.parse(item['addressLng']),
    created: DateTime.parse(item['created']),
    updated: DateTime.parse(item['updated']),
  );
}
