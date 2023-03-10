import 'package:charoz/Model/Data/noti_model.dart';
import 'package:charoz/Service/Firebase/noti_crud.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:get/get.dart';

class NotiViewModel extends GetxController {
  final RxList<NotiModel> _notiList = <NotiModel>[].obs;
  final RxList<NotiModel> _notiTypeList = <NotiModel>[].obs;
  NotiModel? _noti;

  get noti => _noti;
  get notiList => _notiList;
  get notiTypeList => _notiTypeList;

  Future readNotiList() async {
    if (VariableGeneral.role == null) {
      _notiList.value = await NotiCRUD().readNotiListByRole(0);
    } else if (VariableGeneral.role == 0) {
      _notiList.value = await NotiCRUD().readNotiListAll();
    } else {
      _notiList.value =
          await NotiCRUD().readNotiListByRole(VariableGeneral.role!);
    }
    _notiList.sort((a, b) => b.time!.compareTo(a.time!));
    update();
  }

  void getNotiTypeList(int type) {
    _notiTypeList.clear();
    _notiTypeList.value = _notiList.where((item) => item.type == type).toList();
    update();
  }

  void setNotiModel(NotiModel model) {
    _noti = model;
    update();
  }

  void selectAddressWhereId(String id) {
    _noti = _notiList.firstWhere((element) => element.id == id);
  }

  void clearNotiData() {
    _notiList.clear();
    _notiTypeList.clear();
    _noti = null;
  }
}
