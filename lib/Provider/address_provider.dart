import 'package:charoz/Model_Main/address_model.dart';
import 'package:charoz/Service/Database/Firebase/address_crud.dart';
import 'package:charoz/Utilty/my_variable.dart';
import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  AddressModel? _address;
  List<AddressModel>? _addressList;

  get address => _address;
  get addressList => _addressList;

  Future readAddressList() async {
    _addressList = await AddressCRUD().readAddressList();
    _addressList!.sort((a, b) => b.time.compareTo(a.time));
    notifyListeners();
  }

  Future readAddressById(String id) async {
    _address = await AddressCRUD().readAddressById(id);
    notifyListeners();
  }

  void getAddress() {
    _address = _addressList!
        .firstWhere((element) => element.userid == MyVariable.userTokenId);
  }

  void selectAddressWhereId(String id) {
    _address = _addressList!.firstWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearAddressData() {
    _address = null;
    _addressList = null;
  }
}
