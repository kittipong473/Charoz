import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:timeago/timeago.dart' as timeago;

class MyFunction {
  void appBarTheme(bool darkTheme) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: darkTheme ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: darkTheme ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

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

  Future<bool> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;
    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      }
    } else {
      return false;
    }
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

  String encryption(String text) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base16.toString();
  }

  String decryption(encrypt.Encrypted code) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.decrypt(code, iv: iv);
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

  String getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  String parseMoney(double money) =>
      NumberFormat('#,##0.00', 'en_US').format(money);

  DateTime getDateTimeNow() => DateTime.now().add(const Duration(hours: 7));

  String getTimeAgo(DateTime time) => timeago.format(time);

  Timestamp getTimeStamp() => Timestamp.fromDate(getDateTimeNow());

  List<String> convertToList(String value) {
    List<String> result = [];
    value = value.substring(1, value.length - 1);
    List<String> strings = value.split(',');
    for (var item in strings) {
      result.add(item.trim());
    }
    return result;
  }

  String convertToDate(DateTime time) {
    return DateFormat('E, d MMM yyyy').format(time);
  }

  String convertToDateTime(DateTime time) {
    return DateFormat('E, d MMM yyyy HH:mm:ss').format(time);
  }
}
