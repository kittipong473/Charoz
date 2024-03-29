import 'package:charoz/Model/Api/FireStore/address_model.dart';
import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Firebase/address_crud.dart';
import 'package:get/get.dart';

class AddressViewModel extends GetxController {
  List<String> datatypeAddress = [
    'คอนโดถนอมมิตร',
    'บ้านพัก',
    'ที่ทำงาน',
    'อื่นๆ'
  ];
  List<String> buildingNumbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16'
  ];

  AddressModel? _address;
  final RxList<AddressModel> _addressList = <AddressModel>[].obs;

  AddressModel? get address => _address;
  List<AddressModel> get addressList => _addressList;

  Future readAddressList() async {
    _addressList.value = await AddressCRUD().readAddressList();
    _addressList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  Future readAddressById(String id) async {
    _address = await AddressCRUD().readAddressById(id: id);
    update();
  }

  void getAddress() {
    _address = _addressList
        .firstWhere((element) => element.userid == MyVariable.userTokenID);
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
