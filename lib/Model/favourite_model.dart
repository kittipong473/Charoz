// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouriteModel {
  final int favouriteId;
  final int favouriteUserId;
  final String favouriteProducts;
  final DateTime updated;
  FavouriteModel({
    required this.favouriteId,
    required this.favouriteUserId,
    required this.favouriteProducts,
    required this.updated,
  });

  FavouriteModel copyWith({
    int? favouriteId,
    int? favouriteUserId,
    String? favouriteProducts,
    DateTime? updated,
  }) {
    return FavouriteModel(
      favouriteId: favouriteId ?? this.favouriteId,
      favouriteUserId: favouriteUserId ?? this.favouriteUserId,
      favouriteProducts: favouriteProducts ?? this.favouriteProducts,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favouriteId': favouriteId,
      'favouriteUserId': favouriteUserId,
      'favouriteProducts': favouriteProducts,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory FavouriteModel.fromMap(Map<String, dynamic> map) {
    return FavouriteModel(
      favouriteId: map['favouriteId'] as int,
      favouriteUserId: map['favouriteUserId'] as int,
      favouriteProducts: map['favouriteProducts'] as String,
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteModel.fromJson(String source) =>
      FavouriteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavouriteModel(favouriteId: $favouriteId, favouriteUserId: $favouriteUserId, favouriteProducts: $favouriteProducts, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavouriteModel &&
        other.favouriteId == favouriteId &&
        other.favouriteUserId == favouriteUserId &&
        other.favouriteProducts == favouriteProducts &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return favouriteId.hashCode ^
        favouriteUserId.hashCode ^
        favouriteProducts.hashCode ^
        updated.hashCode;
  }
}
