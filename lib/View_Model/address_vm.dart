import 'package:charoz/Model/Data/address_model.dart';
import 'package:charoz/Service/Firebase/address_crud.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:get/get.dart';

class AddressViewModel extends GetxController {
  final RxList<AddressModel> _addressList = <AddressModel>[].obs;
  AddressModel? _address;

  get address => _address;
  get addressList => _addressList;

  Future readAddressList() async {
    _addressList.value = await AddressCRUD().readAddressList();
    _addressList.sort((a, b) => b.time!.compareTo(a.time!));
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
