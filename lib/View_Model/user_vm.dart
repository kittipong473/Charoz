import 'dart:async';

import 'package:charoz/Model/Data/user_model.dart';
import 'package:charoz/Service/Library/preference.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/View/Function/dialog_alert.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Model/Util/Variable/var_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final RxBool _otpInTimeVerify = false.obs;
  final RxBool _delayResend = false.obs;
  final RxInt _countResend = 0.obs;
  final RxString _minutes = ''.obs;
  final RxString _seconds = ''.obs;
  final RxString _phoneNumber = ''.obs;
  final RxString _otpToken = ''.obs;
  final RxString _otpRefNo = ''.obs;
  final RxList<UserModel> _userList = <UserModel>[].obs;
  UserModel? _user;
  UserModel? _customer;
  UserModel? _rider;
  UserModel? _manager;

  get otpInTimeVerify => _otpInTimeVerify.value;
  get delayResend => _delayResend.value;
  get countResend => _countResend.value;
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
  Timer? otpTimer;
  List<String> roleUserList = [
    'Administrator',
    'Customer',
    'Rider',
    'Shop Manager',
    'Guest'
  ];

  void initOTPTime() {
    otpDuration = const Duration(minutes: 3);
    _countResend.value = 0;
    _minutes.value = '03';
    _seconds.value = '00';
  }

  void startOTPTime() {
    _otpInTimeVerify.value = true;
    otpTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      otpDuration = Duration(seconds: otpDuration!.inSeconds - 1);
      _minutes.value = otpDuration!.inMinutes.toString().padLeft(2, '0');
      _seconds.value =
          otpDuration!.inSeconds.remainder(60).toString().padLeft(2, '0');
      _countResend.value++;
      if (_countResend.value > 10) setDelayResend(true);
      update();
      if (otpDuration == const Duration(minutes: 0, seconds: 0)) stopOTPTime();
    });
  }

  void stopOTPTime() {
    _otpInTimeVerify.value = false;
    _minutes.value = '00';
    _seconds.value = '00';
    otpTimer!.cancel();
    update();
  }

  void setPhoneVerify(String phone) {
    _phoneNumber.value = phone;
  }

  void setDelayResend(bool status) {
    _delayResend.value = status;
  }

  // void sendNotiToAllRider(String token) {
  //   NotificationApi().sendNoti(
  //     token: token,
  //     title: 'มีออเดอร์จากลูกค้า!',
  //     body: 'ออเดอร์จากร้าน Charoz Steak House',
  //   );
  // }

  void setLoginVariable() async {
    await Preferences().init();
    _user = await UserCRUD().readUserByPhone(_phoneNumber.value);
    VariableGeneral.isLogin = true;
    VariableGeneral.role = _user!.role;
    VariableGeneral.userTokenId = _user!.id;
    Preferences().setString('id', _user!.id!);
    VariableGeneral.indexProductChip = 0;
    VariableGeneral.indexNotiChip = 0;
    VariableGeneral.indexOrderChip = 0;
    clearUserData();
    Get.offAllNamed(RoutePage.routePageNavigation);
    MyFunction().toast('ยินดีต้อนรับสู่ Application');
  }

  void setLogoutVariable() async {
    await Preferences().init();
    _user = null;
    VariableGeneral.isLogin = false;
    VariableGeneral.role = null;
    VariableGeneral.userTokenId = null;
    Preferences().clearAll();
    VariableGeneral.indexProductChip = 0;
    VariableGeneral.indexNotiChip = 0;
    VariableGeneral.indexOrderChip = 0;
    Get.offAllNamed(RoutePage.routePageNavigation);
    MyFunction().toast('ลงชื่อออกจากระบบ สำเร็จ');
  }

  void clearUserData() {
    _otpInTimeVerify.value = false;
    _delayResend.value = false;
    _countResend.value = 0;
    _minutes.value = '';
    _seconds.value = '';
    _phoneNumber.value = '';
    _otpToken.value = '';
    _otpRefNo.value = '';
    _userList.clear();
    _customer = null;
    _rider = null;
    _manager = null;
  }

  Future<bool> getUserPreference(BuildContext context, String id) async {
    _user = await UserCRUD().readUserById(id);
    VariableGeneral.userTokenId = _user!.id;
    VariableGeneral.role = _user!.role;
    bool status = await UserCRUD().updateUserTokenDevice(_user!.id!);
    if (!status) {
      MyFunction()
          .toast('ไม่สามารถเก็บ token ได้\nปิดการใช้งาน notification ชั่วคราว');
    }
    if (_user!.status != null && _user!.status == true) {
      return true;
    } else {
      return false;
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

  Future<void> getUserById(String id) async {
    _user = await UserCRUD().readUserById(id);
  }

  Future<void> getUserByPhone(String phone) async {
    _user = await UserCRUD().readUserByPhone(phone);
  }

  // Future signOutFirebase(BuildContext context) async {
  //   final ApiController capi = Get.find<ApiController>();
  //   capi.loadingPage(true);
  //   await VariableGeneral.auth
  //       .signOut()
  //       .then((value) => setLogoutVariable())
  //       .catchError((e) => MyDialog(context).singleDialog(e.code));
  //   capi.loadingPage(false);
  // }

  Future<void> readUserList() async {
    _userList.value = await UserCRUD().readUserList();
    update();
  }

  Future<void> readCustomerById(String id) async {
    _customer = await UserCRUD().readUserById(id);
    update();
  }

  Future<void> readRiderById(String id) async {
    _rider = await UserCRUD().readUserById(id);
    update();
  }

  Future<void> readManagerById(String id) async {
    _manager = await UserCRUD().readUserById(id);
    update();
  }

  Future<void> requestOTP() async {
    final ApiController capi = Get.find<ApiController>();
    bool status = await capi.requestOTP(_phoneNumber.value);
    if (status) {
      _otpToken.value = capi.responseSendOTP.token;
      _otpRefNo.value = capi.responseSendOTP.refno;
      update();
    }
  }

  // Future readRiderTokenList() async {
  //   _riderTokenList = await UserCRUD().readTokenRiderList();
  //   for (var i = 0; i < _riderTokenList!.length; i++) {
  //     sendNotiToAllRider(_riderTokenList![i]);
  //   }
  // }
}
