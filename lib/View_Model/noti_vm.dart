import 'package:charoz/Model/Api/FireStore/noti_model.dart';
import 'package:charoz/Service/Firebase/noti_crud.dart';
import 'package:charoz/View_Model/user_vm.dart';
import 'package:get/get.dart';

class NotiViewModel extends GetxController {
  List<String> datatypeNotiType = ['ข่าวสาร', 'โปรโมชั่น'];
  List<String> notiRoleTargetList = ['ทั้งหมด', 'คนขับ', 'ลูกค้า'];

  NotiModel? _noti;
  final RxList<NotiModel> _notiList = <NotiModel>[].obs;
  final RxList<NotiModel> _notiTypeList = <NotiModel>[].obs;

  NotiModel? get noti => _noti;
  List<NotiModel> get notiList => _notiList;
  List<NotiModel> get notiTypeList => _notiTypeList;

  Future readNotiList() async {
    final userVM = Get.find<UserViewModel>();
    if (userVM.role == 4) {
      _notiList.value = await NotiCRUD().readNotiListAll();
    } else {
      _notiList.value = await NotiCRUD()
          .readNotiListByRole(role: userVM.userRoleList[userVM.role]);
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
