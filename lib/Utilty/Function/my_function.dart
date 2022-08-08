import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MyFunction {
  void toast(String title) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  
  String cutWord10(String name) {
    String result = name;
    if (result.length > 13) {
      result = result.substring(0, 10);
      result = '$result...';
    }
    return result;
  }

  Future<File> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 600,
      );
      return File(result!.path);
    } catch (e) {
      rethrow;
    }
  }

  String authenAlert(String code) {
    if (code == 'invalid-email') {
      return 'อีเมลล์ไม่ถูกต้อง';
    } else if (code == 'email-already-in-use') {
      return 'อีเมลล์ถูกใช้งานแล้ว กรุณาลองอีเมลล์อื่น';
    } else if (code == 'wrong-password') {
      return 'รหัสผ่านไม่ถูกต้อง';
    } else {
      return "Error 404 Not Found";
    }
  }

  List<String> convertToList(String value) {
    List<String> result = [];
    value = value.substring(1, value.length - 1);
    List<String> strings = value.split(',');
    for (var item in strings) {
      result.add(item.trim());
    }
    return result;
  }

  String convertToOpenClose(String time) {
    DateTime convert = DateTime.parse("2022-01-01T$time.000Z");
    return DateFormat('HH:mm').format(convert);
  }

  String convertToDateTime(DateTime time) => DateFormat('E, d MMM yyyy HH:mm:ss').format(time);
}
