import 'package:charoz/Screen/Address/Model/address_model.dart';
import 'package:charoz/Service/Api/address_api.dart';
import 'package:flutter/cupertino.dart';

class AddressProvider with ChangeNotifier {
  AddressModel? _address;

  List<AddressModel> _addresses = [];

  get address => _address;

  get addresses => _addresses;
  get addressesLength => _addresses.length;

  Future getAllAddress() async {
    _addresses = await AddressApi().getAllAddressWhereUserId();
    notifyListeners();
  }

  Future getCurrentAddressWhereId() async {
    _address = await AddressApi().getCurrentAddressWhereId();
    notifyListeners();
  }
}
