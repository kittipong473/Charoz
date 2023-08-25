import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Api/Modify/address_modify.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressCRUD {
  final ApiController capi = Get.find<ApiController>();
  final address = FirebaseFirestore.instance.collection('address');

  Future<List<AddressModel>> readAddressList() async {
    List<AddressModel> result = [];
    try {
      capi.loadingPage(true);
      final snapshot = await address
          .where('userid', isEqualTo: VariableGeneral.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(AddressModel().convert(item: item));
      }
      capi.loadingPage(false);
      return result;
    } catch (e) {
      capi.loadingPage(false);
      return [];
    }
  }

  Future<AddressModel?> readAddressById({required String id}) async {
    try {
      capi.loadingPage(true);
      final snapshot = await address.doc(id).get();
      if (snapshot.exists) {
        capi.loadingPage(false);
        return AddressModel().convert(item: snapshot.data(), id: snapshot.id);
      } else {
        capi.loadingPage(false);
        return null;
      }
    } catch (e) {
      capi.loadingPage(false);
      return null;
    }
  }

  Future<bool> createAddress({required AddressModify model}) async {
    try {
      capi.loadingPage(true);
      await address.doc().set(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateAddress(
      {required String id, required AddressModify model}) async {
    try {
      capi.loadingPage(true);
      await address.doc(id).update(model.toMap());
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteAddress({required String id}) async {
    try {
      capi.loadingPage(true);
      await address.doc(id).delete();
      capi.loadingPage(false);
      return true;
    } catch (e) {
      capi.loadingPage(false);
      return false;
    }
  }
}
