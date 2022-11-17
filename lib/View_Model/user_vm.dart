import 'dart:async';

import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Model/Service/CRUD/api_controller.dart';
import 'package:charoz/Model/Service/CRUD/Firebase/user_crud.dart';
import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  RxBool _otpInTimeVerify = false.obs;
  RxString _minutes = ''.obs;
  RxString _seconds = ''.obs;
  RxString _phoneNumber = ''.obs;
  RxString _otpToken = ''.obs;
  RxString _otpRefNo = ''.obs;
  UserModel? _user;
  UserModel? _customer;
  UserModel? _rider;
  UserModel? _manager;
  RxList<UserModel>? _userList = <UserModel>[].obs;

  get otpInTimeVerify => _otpInTimeVerify.value;
  get minutes => _minutes.value;
  get seconds => _seconds.value;
  get phoneNumber => _phoneNumber.value;
  get otpToken => _otpToken.value;
  get otpRefNo => _otpRefNo.value;
  get user => _user;
  get customer => _customer;
  get rider => _rider;
  get manager => _manager;
  get userList => _userList;

  Duration? otpDuration;
  Timer? otpTImer;

  void initOTPTime() {
    otpDuration = const Duration(minutes: 3);
    _minutes.value = '03';
    _seconds.value = '00';
  }

  void startOTPTime() {
    _otpInTimeVerify.value = true;
    otpTImer = Timer.periodic(const Duration(seconds: 1), (_) {
      otpDuration = Duration(seconds: otpDuration!.inSeconds - 1);
      _minutes.value = otpDuration!.inMinutes.toString().padLeft(2, '0');
      _seconds.value =
          otpDuration!.inSeconds.remainder(60).toString().padLeft(2, '0');
      update();
      if (otpDuration == const Duration(minutes: 0, seconds: 0)) stopOTPTime();
    });
  }

  void stopOTPTime() {
    _otpInTimeVerify.value = false;
    _minutes.value = '00';
    _seconds.value = '00';
    otpTImer!.cancel();
    update();
  }

  void setPhoneVerify(String phone) {
    _phoneNumber.value = phone;
  }

  // void sendNotiToAllRider(String token) {
  //   NotificationApi().sendNoti(
  //     token: token,
  //     title: 'มีออเดอร์จากลูกค้า!',
  //     body: 'ออเดอร์จากร้าน Charoz Steak House',
  //   );
  // }

  void setLoginVariable() {
    VariableGeneral.isLogin = true;
    VariableGeneral.role = _user!.role;
    VariableGeneral.userTokenId = _user!.id;
    VariableGeneral.indexProductChip = 0;
    VariableGeneral.indexNotiChip = 0;
    VariableGeneral.indexOrderChip = 0;
    clearUserData();
    MyFunction().toast('ยินดีต้อนรับสู่ Application');
    Get.offAllNamed(RoutePage.routePageNavigation);
  }

  void setLogoutVariable() {
    _user = null;
    VariableGeneral.isLogin = false;
    VariableGeneral.role = null;
    VariableGeneral.userTokenId = null;
    MyFunction().toast('ลงชื่อออกจากระบบ สำเร็จ');
    Get.offAllNamed(RoutePage.routePageNavigation);
  }

  void clearUserData() {
    _customer = null;
    _rider = null;
    _manager = null;
    _userList = null;
    _minutes.value = '';
    _seconds.value = '';
    _phoneNumber.value = '';
    _otpToken.value = '';
    _otpRefNo.value = '';
  }

  Future getUserPreference(BuildContext context, String uid) async {
    _user = await UserCRUD().readUserByToken(uid);
    VariableGeneral.isLogin = true;
    VariableGeneral.userTokenId = _user!.id;
    VariableGeneral.role = _user!.role;
    bool status = await UserCRUD().updateUserTokenDevice(_user!.id);
    if (!status) {
      MyDialog(context).doubleDialog(
          'ไม่สามารถเก็บ token ได้', 'ปิดการใช้งาน notification ชั่วคราว');
    }
    if (_user!.status == 0) {
      MyDialog(context).doubleDialog(
          'คุณถูกระงับการใช้งาน', 'โปรดติดต่อสอบถามผู้ดูแลระบบเมื่อมีข้อสงสัย');
      signOutFirebase(context);
    } else {
      Get.offNamed(RoutePage.routePageNavigation);
    }
  }

  Future<bool> checkPhoneAndGetUser() async {
    _user = await UserCRUD().readUserByPhone(_phoneNumber.value);
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future readUserById(String id) async {
    _user = await UserCRUD().readUserById(id);
  }

  Future signOutFirebase(BuildContext context) async {
    final ApiController capi = Get.find<ApiController>();
    capi.loadingPage(true);
    await VariableGeneral.auth
        .signOut()
        .then((value) => setLogoutVariable())
        .catchError((e) => MyDialog(context).singleDialog(e.code));
    capi.loadingPage(false);
  }

  Future readUserList() async {
    _userList = await UserCRUD().readUserList();
  }

  Future readCustomerById(String id) async {
    _customer = await UserCRUD().readUserById(id);
  }

  Future readRiderById(String id) async {
    _rider = await UserCRUD().readUserById(id);
  }

  Future readManagerById(String id) async {
    _manager = await UserCRUD().readUserById(id);
  }

  Future<bool> requestOTP() async {
    final ApiController capi = Get.find<ApiController>();
    bool status = await capi.requestOTP(_phoneNumber.value);
    if (status) {
      _otpToken = capi.responseSendOTP.token;
      _otpRefNo = capi.responseSendOTP.refno;
      update();
      return true;
    } else {
      return false;
    }
  }

  // Future readRiderTokenList() async {
  //   _riderTokenList = await UserCRUD().readTokenRiderList();
  //   for (var i = 0; i < _riderTokenList!.length; i++) {
  //     sendNotiToAllRider(_riderTokenList![i]);
  //   }
  // }
}
