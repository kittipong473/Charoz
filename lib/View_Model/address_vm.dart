import 'package:charoz/Model/Data/address_model.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/address_crud.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:get/get.dart';

class AddressViewModel extends GetxController {
  AddressModel? _address;
  RxList<AddressModel> _addressList = <AddressModel>[].obs;

  get address => _address;
  get addressList => _addressList;

  Future readAddressList() async {
    _addressList = await AddressCRUD().readAddressList();
    _addressList.sort((a, b) => b.time.compareTo(a.time));
    update();
  }

  Future readAddressById(String id) async {
    _address = await AddressCRUD().readAddressById(id);
    update();
  }

  void getAddress() {
    _address = _addressList
        .firstWhere((element) => element.userid == VariableGeneral.userTokenId);
  }

  void selectAddressWhereId(String id) {
    _address = _addressList.firstWhere((element) => element.id == id);
    update();
  }

  void clearAddressData() {
    _address = null;
    _addressList.clear();
  }
}
