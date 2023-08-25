import 'dart:async';

import 'package:charoz/Model/Api/FireStore/user_model.dart';
import 'package:charoz/Model/Data/privacy_model.dart';
import 'package:charoz/Service/Library/preference.dart';
import 'package:charoz/Service/Restful/api_controller.dart';
import 'package:charoz/Service/Firebase/user_crud.dart';
import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/View/Function/my_function.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
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
  final RxList<PrivacyModel> _privacyList = <PrivacyModel>[].obs;
  final RxList<PrivacyModel> _questionList = <PrivacyModel>[].obs;
  final RxList<UserModel> _userList = <UserModel>[].obs;
  UserModel? _user;
  UserModel? _customer;
  UserModel? _rider;
  UserModel? _manager;

  bool get otpInTimeVerify => _otpInTimeVerify.value;
  bool get delayResend => _delayResend.value;
  int get countResend => _countResend.value;
  String get minutes => _minutes.value;
  String get seconds => _seconds.value;
  String get phoneNumber => _phoneNumber.value;
  String get otpToken => _otpToken.value;
  String get otpRefNo => _otpRefNo.value;
  List<PrivacyModel> get privacyList => _privacyList;
  List<PrivacyModel> get questionList => _questionList;
  List<UserModel> get userList => _userList;
  UserModel? get user => _user;
  UserModel? get customer => _customer;
  UserModel? get rider => _rider;
  UserModel? get manager => _manager;

  Duration? otpDuration;
  Timer? otpTimer;
  List<String> roleUserList = [
    'Guest',
    'Customer',
    'Rider',
    'Shop Manager',
    'Administrator',
  ];

  void initPrivacyList() {
    _privacyList.value = [
      PrivacyModel(
        number: 1,
        name:
            'ความยินยอมให้ แอพพลิเคชั่น เก็บรวบรวม ใช้ เปิดเผยข้อมูลส่วนบุคคลของท่าน ในขั้นตอนการสมัครใช้งาน หรือยืนยันตัวตนผู้ใช้งาน',
        detail:
            'ซึ่งมีข้อมูลชื่อ อีเมลล์ เบอร์โทรศัพท์ รวมทั้งยินยอมให้ผู้พัฒนาเก็บและเปิดเผย ข้อมูลดังกล่าวให้ผู้ประมวลผลที่เกี่ยวข้องเพื่อการ ดำเนินการตามวัตถุประสงค์ในการสมัครใช้งานและ ระบุหรือยืนยันตัวตนผู้ใช้งาน หากไม่ยินยอม แอพพลิเคชั่น ไม่อาจสามารถให้บริการและไม่สามารถทำข้อตกลงการใช้บริการกับท่านได้',
      ),
      PrivacyModel(
        number: 2,
        name:
            'ความยินยอมให้ ผู้พัฒนา เก็บรวบรวม ใช้ เปิดเผยข้อมูล ส่วนบุคคลของท่านเพื่อปรับปรุงพัฒนาการให้บริการของ แอพพลิเคชั่น',
        detail:
            'เช่น การวิจัย วิเคราะห์ ทำสถิติ เพื่อพัฒนาหรือปรับปรุง โปรแกรมหรือซอฟท์แวร์หรือระบบของแอพพลิเคชั่น การเก็บรวบรวมข้อมูลเฉพาะของอุปกรณ์ของผู้ใช้งาน เพื่อนำมาปรับแต่งการให้บริการและพัฒนาการให้บริการที่เหมาะสมกับอุปกรณ์ของผู้ใช้งาน การวิจัยพัฒนาโปรแกรมหรือระบบผู้ให้บริการหรือผู้ควบคุมข้อมูลส่วนบุคคลอื่น การทำแบบสอบถามเพื่อสำรวจความพึงพอใจของผู้ใช้งาน และการวิเคราะห์ข้อมูลความพึงพอใจของผู้ใช้งาน หากไม่ยินยอม ผู้พัฒนาอาจไม่สามารถพัฒนาหรือปรับปรุงบริการให้เหมาะสมกับความต้องการของท่านได้',
      ),
      PrivacyModel(
        number: 3,
        name:
            'ความยินยอมสำหรับการที่แอพพิลเคชั่น ใช้คุกกี้และเทคโนโลยี ที่คล้ายกัน (Cookies and Similar Technologies) เก็บรวบรวม และประมวลผลข้อมูลส่วนบุคคลของท่าน',
        detail:
            'เมื่อท่านใช้งานแอปพลิเคชั่น หรือเพื่อ รวบรวมและจัดเก็บข้อมูล เมื่อท่านมีการโต้ตอบกับ บริการที่แอพพิลเคชั่นให้ เพื่อนำมาใช้ประโยชน์ในทางการตลาด การประชาสัมพันธ์บริการต่างๆ ของแอพพลิเคชั่น การวิเคราะห์ข้อมูลของท่านเพื่อออกแบบบริการหรือนำเสนอเนื้อหาซึ่งได้รับการปรับแต่ง ให้เหมาะสมกับการใช้งานหรือประสบการณ์ของท่านโดยเฉพาะ เช่น แสดงผลการค้นหาที่เกี่ยวข้องกับท่าน การนำเสนอหรือแสดงข้อมูลสินค้าหรือบริการตามความสนใจของท่าน หากไม่ยินยอม บริษัทอาจไม่สามารถปรับปรุงหรือพัฒนาหรือออกแบบบริการให้สอดคล้องตามพฤติกรรม การใช้งานหรือความสนใจของท่านได้',
      ),
      PrivacyModel(
        number: 4,
        name: 'การจัดการข้อมูลส่วนบุคคล',
        detail:
            'ข้อมูลของคุณเป็นสิ่งสำคัญยิ่ง ทางผู้พัฒนาผลิตภัณฑ์ เราจะดำเนินการอย่างดีที่สุด ด้วยมาตรการที่เข้มงวด ในการรักษาความปลอดภัยคุณ สามารถดูรายละเอียดนโยบายความเป็นส่วนตัวของเรา ได้ที่เว็บไซต์ของเรา https://github.com/kittipong473/kittipong-privacy/blob/main/privacy-pilicy.md หรือติดต่อสอบถามเราได้ที่ kittipong_kc47@hotmail.com',
      ),
    ];
  }

  void initQuestionList() {
    _questionList.value = [
      PrivacyModel(
        number: 1,
        name: 'แอพพลิเคชั่นนี้ คืออะไร ใช้งานเกี่ยวกับอะไร ?',
        detail:
            'แอพพลิเคชั่น Charoz นี้ ถูกจัดทำขึ้นสำหรับร้านอาหาร Charoz Steak House เพื่อให้ลูกค้าหรือผู้เข้าชมทุกท่าน ได้เห็นข้อมูลเกี่ยวกับร้านค้า ประกอบด้วย เมนูอาหาร หมวดหมู่ อาหารแนะนำ รวมถึงช่วงเวลาเปิดปิด และโปรโมชั่นต่างที่จะมีในอนาคต',
      ),
      PrivacyModel(
        number: 2,
        name: 'ผู้เข้าชม สามารถทำอะไรในแอพนี้ ได้บ้าง',
        detail:
            '- ลูกค้าสามารถดูช่วงเวลาเปิด-ปิดของร้าน รายการอาหารแนะนำ และคำอธิบายของร้าน\n- ลูกค้าสามารถดูเมนูอาหารทั้งหมดที่ร้านนี้ขาย และหมวดหมู่ของอาหารต่างๆ\n- ลูกค้าสามารถดูข่าวสารจากทางร้านหรือโปรโมชั่นได้\n- ลูกค้าสามารถดูข้อมูลเกี่ยวกับร้านค้า ค้นหาตำแหน่งบนแผนที่ รวมถึงผู้ติดต่อได้',
      ),
      PrivacyModel(
        number: 3,
        name: 'มีแผนจะพัฒนาแอพ ในอนาคตอย่างไรบ้าง',
        detail:
            '- ลูกค้าสามารถสมัครเป็นสมาชิกได้ รวมถึงการเพิ่มที่อยู่ ตั้ง Book Mark เมนูอาหาร และมีโปรโมชั่นพิเศษสำหรับสมาชิก\n- ลูกค้าสามารถสั่งอาหารกับทางร้านค้าผ่านแอพนี้ได้ โดยมีคนขับไปส่งถึงที่อยู่ของท่าน\n- ลูกค้าสามารถให้คะแนน หรือ แนะนำเกี่ยวกับอาหารกับทางร้านได้',
      ),
    ];
  }

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
    _user = await UserCRUD().readUserByPhone(phone: _phoneNumber.value);
    VariableGeneral.isLogin = true;
    VariableGeneral.role = _user!.role;
    VariableGeneral.userTokenId = _user!.id;
    Preferences().setUserID(value: _user!.id!);
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

  void clearPrivacyList() {
    _privacyList.clear();
  }

  void clearQuestionList() {
    _questionList.clear();
  }

  Future<bool> getUserPreference(BuildContext context, String id) async {
    _user = await UserCRUD().readUserById(id: id);
    VariableGeneral.userTokenId = _user!.id;
    VariableGeneral.role = _user!.role;
    bool status = await UserCRUD().updateUserTokenDevice(id: _user!.id!);
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
    _user = await UserCRUD().readUserByPhone(phone: _phoneNumber.value);
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUserById(String id) async {
    _user = await UserCRUD().readUserById(id: id);
  }

  Future<void> getUserByPhone(String phone) async {
    _user = await UserCRUD().readUserByPhone(phone: phone);
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
    _customer = await UserCRUD().readUserById(id: id);
    update();
  }

  Future<void> readRiderById(String id) async {
    _rider = await UserCRUD().readUserById(id: id);
    update();
  }

  Future<void> readManagerById(String id) async {
    _manager = await UserCRUD().readUserById(id: id);
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
