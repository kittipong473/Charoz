import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Api/Modify/address_modify.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Library/console_log.dart';
import 'package:charoz/Service/Restful/api_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressCRUD {
  final address = FirebaseFirestore.instance.collection('address');

  Future<List<AddressModel>> readAddressList() async {
    List<AddressModel> result = [];
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await address
          .where('userid', isEqualTo: MyVariable.userTokenID)
          .get();
      for (var item in snapshot.docs) {
        result.add(AddressModel().convert(item: item));
      }
      ApiCRUD.loadingPage(false);
      return result;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      ConsoleLog.printRed(text: e.toString());
      ConsoleLog.toastApi();
      return [];
    }
  }

  Future<AddressModel?> readAddressById({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      final snapshot = await address.doc(id).get();
      if (snapshot.exists) {
        ApiCRUD.loadingPage(false);
        return AddressModel().convert(item: snapshot.data(), id: snapshot.id);
      } else {
        ApiCRUD.loadingPage(false);
        return null;
      }
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return null;
    }
  }

  Future<bool> createAddress({required AddressModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await address.doc().set(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> updateAddress(
      {required String id, required AddressModify model}) async {
    try {
      ApiCRUD.loadingPage(true);
      await address.doc(id).update(model.toMap());
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }

  Future<bool> deleteAddress({required String id}) async {
    try {
      ApiCRUD.loadingPage(true);
      await address.doc(id).delete();
      ApiCRUD.loadingPage(false);
      return true;
    } catch (e) {
      ApiCRUD.loadingPage(false);
      return false;
    }
  }
}
