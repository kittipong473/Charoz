import 'package:charoz/Model/SubModel/sub_address_model.dart';
import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressCRUD {
  final address = FirebaseFirestore.instance.collection('address');

  Future readAddressList() async {
    List<AddressModel> result = [];
    try {
      final snapshot = await address
          .where('userid', isEqualTo: MyVariable.userTokenId)
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

  Future<bool> createAddress(SubAddressModel model) async {
    try {
      await address.doc().set(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAddress(String id, SubAddressModel model) async {
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
