import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VariableGeneral {
  // Width and Height between iPad and iPhone
  static bool largeDevice = false;
  // Index Page of Product Type
  static int indexProductChip = 0;
  // Index Page of Notification Type
  static int indexNotiChip = 0;
  // Index Page of Order Type
  static int indexOrderChip = 0;
  // Login Status
  static bool isLogin = false;
  // User Id
  static String? userTokenId;
  // Role of user
  static int? role;
  // About App Version
  static String? appVersion;
  static String? baseVersion;
  static bool update = false;
  // Create FirebaseAuth Variable
  // static FirebaseAuth auth = FirebaseAuth.instance;
  // Tab Control of Page Navigation
  static late TabController? tabController;
}
