import 'package:charoz/Model/Api/FireStore/shop_model.dart';
import 'package:charoz/Model/Api/Modify/shop_modify.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopCRUD {
  final shop = FirebaseFirestore.instance.collection('shop');

  Future<ShopModel?> readShopModel() async {
    ShopModel? model;
    try {
      final snapshot = await shop.limit(1).get();
      for (var item in snapshot.docs) {
        model = ShopModel().convert(item: item);
      }
      return model;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateShop(
      {required String id, required ShopModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await shop.doc(id).update(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }
}
