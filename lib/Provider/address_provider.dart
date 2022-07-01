import 'package:charoz/Model/address_model.dart';
import 'package:charoz/Service/Api/address_api.dart';
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

  Future getCurrentAddressWhereId() async {
    _address = await AddressApi().getAddressWhereUserLocation();
    notifyListeners();
  }

  void deleteAddressWhereId(int id) {
    _addressList!.removeWhere((item) => item.addressId == id);
    notifyListeners();
  }

  void chooseAddress(int id) {
    _address = _addressList!.elementAt(id);
    notifyListeners();
  }
}
