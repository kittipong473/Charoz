// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavouriteModel {
  final int favouriteId;
  final int userId;
  final String favouriteProducts;
  final DateTime created;
  FavouriteModel({
    required this.favouriteId,
    required this.userId,
    required this.favouriteProducts,
    required this.created,
  });

  FavouriteModel copyWith({
    int? favouriteId,
    int? userId,
    String? favouriteProducts,
    DateTime? created,
  }) {
    return FavouriteModel(
      favouriteId: favouriteId ?? this.favouriteId,
      userId: userId ?? this.userId,
      favouriteProducts: favouriteProducts ?? this.favouriteProducts,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favouriteId': favouriteId,
      'userId': userId,
      'favouriteProducts': favouriteProducts,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory FavouriteModel.fromMap(Map<String, dynamic> map) {
    return FavouriteModel(
      favouriteId: map['favouriteId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      favouriteProducts: map['favouriteProducts'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteModel.fromJson(String source) =>
      FavouriteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavouriteModel(favouriteId: $favouriteId, userId: $userId, favouriteProducts: $favouriteProducts, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavouriteModel &&
        other.favouriteId == favouriteId &&
        other.userId == userId &&
        other.favouriteProducts == favouriteProducts &&
        other.created == created;
  }

  @override
  int get hashCode {
    return favouriteId.hashCode ^
        userId.hashCode ^
        favouriteProducts.hashCode ^
        created.hashCode;
  }
}

FavouriteModel convertFavourite(dynamic item) {
  return FavouriteModel(
    favouriteId: int.parse(item['favouriteId']),
    userId: int.parse(item['userId']),
    favouriteProducts: item['favouriteProducts'],
    created: DateTime.parse(item['created']),
  );
}
