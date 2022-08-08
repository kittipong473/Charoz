import 'package:charoz/Model/shop_model.dart';
import 'package:charoz/Model/time_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopCRUD {
  final shop = FirebaseFirestore.instance.collection('shop');
  final time = FirebaseFirestore.instance.collection('time');

  Future readShopModel() async {
    try {
      final snapshot = await shop.limit(1).get();
      for (var item in snapshot.docs) {
        return convertShop(item);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future readTimeModel() async {
     try {
      final snapshot = await time.limit(1).get();
      for (var item in snapshot.docs) {
        return convertTime(item);
      }
    } catch (e) {
      rethrow;
    }
  }
}
