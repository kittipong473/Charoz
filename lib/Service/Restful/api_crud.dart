import 'dart:convert';

import 'package:charoz/Service/Library/console_log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class ApiCRUD {
  static String username = '';
  static String password = '';

  Map<String, String> getHeader() => {'Content-Type': 'application/json'};

  static void loadingPage(bool loading) {
    if (loading == true) {
      EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<http.Response> getApi(
      {required String pathUrl, required dynamic pathParam}) async {
    final url = Uri.parse('$pathUrl$pathParam');
    try {
      var response = await http.get(url, headers: getHeader());
      return response;
    } catch (e) {
      ConsoleLog.printRed(text: e.toString());
      rethrow;
    }
  }

  Future<http.Response> postApi(
      {required String pathUrl, required Map<String, dynamic> pathBody}) async {
    final url = Uri.parse(pathUrl);
    var body = json.encode(pathBody);
    try {
      var response = await http.post(url, headers: getHeader(), body: body);
      return response;
    } catch (e) {
      ConsoleLog.printRed(text: e.toString());
      rethrow;
    }
  }

  Future<http.Response> putApi(
      {required String pathUrl,
      required dynamic pathParam,
      required Map<String, dynamic> pathBody}) async {
    final url = Uri.parse('$pathUrl$pathParam');
    var body = json.encode(pathBody);
    try {
      var response = await http.put(url, headers: getHeader(), body: body);
      return response;
    } catch (e) {
      ConsoleLog.printRed(text: e.toString());
      rethrow;
    }
  }

  Future<http.Response> deleteApi(
      {required String pathUrl, required dynamic pathParam}) async {
    final url = Uri.parse('$pathUrl$pathParam');
    try {
      var response = await http.delete(url, headers: getHeader());
      return response;
    } catch (e) {
      ConsoleLog.printRed(text: e.toString());
      rethrow;
    }
  }
}
