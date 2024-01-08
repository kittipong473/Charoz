import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Api/FireStore/product_model.dart';
import 'package:charoz/Model/Api/Modify/product_modify.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductCRUD {
  final product = FirebaseFirestore.instance.collection('product');

  Future<List<ProductModel>> readProductAllList() async {
    List<ProductModel> result = [];
    try {
      final snapshot = await product.orderBy('name', descending: true).get();
      for (var item in snapshot.docs) {
        result.add(ProductModel().convert(item: item));
      }
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createProduct({required ProductModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await product.doc().set(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateProduct(
      {required String id, required ProductModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await product.doc(id).update(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateStatusProduct(
      {required String id, required bool status}) async {
    try {
      ApiCRUD.loadingPage(true);
      await product.doc(id).update({'status': status});
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteProduct({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      await product.doc(id).delete();
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<String?> uploadImageProduct({required File file}) async {
    int name = Random().nextInt(100000);
    try {
      ApiCRUD.loadingPage(true);
      final reference =
          FirebaseStorage.instance.ref().child('product/product$name.png');
      final task = reference.putFile(file);
      ApiCRUD.loadingPage(false);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }
}
