
import 'package:charoz/Model/Data/address_model.dart';
import 'package:charoz/Model/Api/Request/address_modify.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressCRUD {
  final address = FirebaseFirestore.instance.collection('address');

  Future readAddressList() async {
    List<AddressModel> result = [];
    try {
      final snapshot = await address
          .where('userid', isEqualTo: VariableGeneral.userTokenId)
          .get();
      for (var item in snapshot.docs) {
        result.add(convertAddress(item, null));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future readAddressById(String id) async {
    try {
      final snapshot = await address.doc(id).get();
      if (snapshot.exists) {
        return convertAddress(snapshot.data(), snapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createAddress(AddressManage model) async {
    try {
      await address.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAddress(String id, AddressManage model) async {
    try {
      await address.doc(id).update(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAddress(String id) async {
    try {
      await address.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
