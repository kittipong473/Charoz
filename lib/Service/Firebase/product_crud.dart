import 'dart:io';
import 'dart:math';

import 'package:charoz/Model/Data/product_model.dart';
import 'package:charoz/Model/Api/Request/product_request.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProductCRUD {
  final ApiController capi = Get.find<ApiController>();
  final product = FirebaseFirestore.instance.collection('product');

  Future<List<ProductModel>> readProductAllList() async {
    List<ProductModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await product.orderBy('name', descending: true).get();
      for (var item in snapshot.docs) {
        result.add(convertProduct(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<List<ProductModel>> readProductSuggestList() async {
    List<ProductModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await product
          .where('suggest', isEqualTo: true)
          .orderBy('name', descending: true)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertProduct(item, null));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<bool> createProduct(ProductRequest model) async {
    try {
      capi.loadingPage(true);
      await product.doc().set(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateProduct(String id, ProductRequest model) async {
    try {
      capi.loadingPage(true);
      await product.doc(id).update(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateStatusProduct(String id, bool status) async {
    try {
      capi.loadingPage(true);
      await product.doc(id).update({'status': status});
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      capi.loadingPage(true);
      await product.doc(id).delete();
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<String?> uploadImageProduct(File file) async {
    int name = Random().nextInt(100000);
    try {
      capi.loadingPage(true);
      final reference =
          FirebaseStorage.instance.ref().child('product/product$name.png');
      final task = reference.putFile(file);
      capi.loadingPage(false);
      return await task.storage.ref().getDownloadURL();
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }
}
