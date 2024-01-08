import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConsoleLog {
  static void toast({required String text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  static void toastApi() {
    Fluttertoast.showToast(
      msg: 'Error get data from API\nPlease check connection',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  // Hidden & Not Important
  static void printBlack({required String text}) {
    log('\x1B[30m$text\x1B[0m');
  }

  // Obvious & Important
  static void printRed({required String text}) {
    log('\x1B[31m$text\x1B[0m');
  }

  // Permission & Acception
  static void printGreen({required String text}) {
    log('\x1B[32m$text\x1B[0m');
  }

  // API Request & Response
  static void printYellow({required String text}) {
    log('\x1B[33m$text\x1B[0m');
  }

  // Notification
  static void printPurple({required String text}) {
    log('\x1B[35m$text\x1B[0m');
  }

  //
  static void printDarkBlue({required String text}) {
    log('\x1B[34m$text\x1B[0m');
  }

  //
  static void printLightBlue({required String text}) {
    log('\x1B[36m$text\x1B[0m');
  }

  // Particular
  static void printWhite({required String text}) {
    log('\x1B[37m$text\x1B[0m');
  }
}
