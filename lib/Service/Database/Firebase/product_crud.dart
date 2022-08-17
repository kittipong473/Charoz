import 'dart:io';
import 'dart:math';

import 'package:charoz/Model_Sub/product_modify.dart';
import 'package:charoz/Model_Main/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductCRUD {
  final product = FirebaseFirestore.instance.collection('product');

  Future readProductAllList() async {
    List<ProductModel> result = [];
    try {
      final snapshot = await product.orderBy('name', descending: true).get();
      for (var item in snapshot.docs) {
        result.add(convertProduct(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readProductSuggestList() async {
    List<ProductModel> result = [];
    try {
      final snapshot = await product
          .where('suggest', isEqualTo: 1)
          .orderBy('name', descending: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertProduct(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readProductTypeList(String type) async {
    List<ProductModel> result = [];
    try {
      final snapshot = await product
          .where('type', isEqualTo: type)
          .orderBy('name', descending: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertProduct(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createProduct(ProductModify model) async {
    try {
      await product.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(String id, ProductModify model) async {
    try {
      await product.doc(id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStatusProduct(String id, int status) async {
    try {
      await product.doc(id).update({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await product.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageProduct(File file) async {
    int name = Random().nextInt(100000);
    try {
      final reference =
          FirebaseStorage.instance.ref().child('product/product$name.png');
      final task = reference.putFile(file);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
