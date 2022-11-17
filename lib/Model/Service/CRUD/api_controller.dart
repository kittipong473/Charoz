import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:charoz/Model/Api/Response/confirm_otp.dart';
import 'package:charoz/Model/Api/Response/response_failed.dart';
import 'package:charoz/Model/Api/Response/send_otp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiController extends GetxController {
  RxBool _loading = false.obs;
  ResponseSendOTP? _responseSendOTP;
  ResponseConfirmOTP? _responseConfirmOTP;
  ResponseFailed? _responseFailed;

  get loading => _loading;
  get responseSendOTP => _responseSendOTP;
  get responseConfirmOTP => _responseConfirmOTP;
  get responseFailed => _responseFailed;

  String domainApiNotification = 'https://kittipongkdev.com/notification/';

  void loadingPage(bool status) {
    _loading.value = status;
    if (_loading.value) {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<bool> pushNotification(String token, String title, String body) async {
    final url = Uri.parse(
        '${domainApiNotification}apiNoti.php?token=$token&title=$title&body=$body');
    try {
      var response = await http.get(url);
      final decode = json.decode(response.body);
      print(decode);
      if (response.statusCode == 200 && decode['success'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> requestOTP(String phone) async {
    final url =
        Uri.parse('${domainApiNotification}requestOTP.php?phone=$phone');
    try {
      var response = await http.get(url);
      final decode = json.decode(response.body);
      print(decode);
      if (response.statusCode == 200 && decode["status"] == 'success') {
        _responseSendOTP = ResponseSendOTP.fromMap(decode);
        return true;
      } else {
        _responseFailed = ResponseFailed.fromMap(decode);
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> confirmOTP(String token, String code) async {
    final url = Uri.parse(
        '${domainApiNotification}confirmOTP.php?token=$token&code=$code');
    try {
      var response = await http.get(url);
      final decode = json.decode(response.body);
      print(decode);
      if (response.statusCode == 200 &&
          json.decode(response.body)["status"] == 'success') {
        _responseConfirmOTP = ResponseConfirmOTP.fromMap(decode);
        return true;
      } else {
        _responseFailed = ResponseFailed.fromMap(decode);
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
