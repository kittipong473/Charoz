import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Service/Api/PHP/address_api.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  AddressModel? _address;
  List<AddressModel>? _addressList;

  get address => _address;
  get addressList => _addressList;

  Future getAllAddressWhereUser() async {
    _addressList = await AddressApi().getAllAddressWhereUser();
    notifyListeners();
  }

  void deleteAddressWhereId(int id) {
    _addressList!.removeWhere((item) => item.addressId == id);
    notifyListeners();
  }

  void getAddress() {
    _address = _addressList!
        .firstWhere((element) => element.userId == GlobalVariable.userTokenId);
  }

  void selectAddressWhereId(int id) {
    _address = _addressList!.firstWhere((element) => element.addressId == id);
    notifyListeners();
  }

  void getAddressWhereId(int id) {
    _address = _addressList!.firstWhere((element) => element.addressId == id);
  }
}
