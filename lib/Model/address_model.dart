// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final int addressId;
  final int addressUserId;
  final String addressName;
  final String addressDescription;
  final double addressLat;
  final double addressLng;
  final DateTime created;
  final DateTime updated;
  AddressModel({
    required this.addressId,
    required this.addressUserId,
    required this.addressName,
    required this.addressDescription,
    required this.addressLat,
    required this.addressLng,
    required this.created,
    required this.updated,
  });

  AddressModel copyWith({
    int? addressId,
    int? addressUserId,
    String? addressName,
    String? addressDescription,
    double? addressLat,
    double? addressLng,
    DateTime? created,
    DateTime? updated,
  }) {
    return AddressModel(
      addressId: addressId ?? this.addressId,
      addressUserId: addressUserId ?? this.addressUserId,
      addressName: addressName ?? this.addressName,
      addressDescription: addressDescription ?? this.addressDescription,
      addressLat: addressLat ?? this.addressLat,
      addressLng: addressLng ?? this.addressLng,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressId': addressId,
      'addressUserId': addressUserId,
      'addressName': addressName,
      'addressDescription': addressDescription,
      'addressLat': addressLat,
      'addressLng': addressLng,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressId: map['addressId'] as int,
      addressUserId: map['addressUserId'] as int,
      addressName: map['addressName'] as String,
      addressDescription: map['addressDescription'] as String,
      addressLat: map['addressLat'] as double,
      addressLng: map['addressLng'] as double,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(addressId: $addressId, addressUserId: $addressUserId, addressName: $addressName, addressDescription: $addressDescription, addressLat: $addressLat, addressLng: $addressLng, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.addressId == addressId &&
        other.addressUserId == addressUserId &&
        other.addressName == addressName &&
        other.addressDescription == addressDescription &&
        other.addressLat == addressLat &&
        other.addressLng == addressLng &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return addressId.hashCode ^
        addressUserId.hashCode ^
        addressName.hashCode ^
        addressDescription.hashCode ^
        addressLat.hashCode ^
        addressLng.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}
