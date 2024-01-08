import 'dart:io';

import 'package:charoz/Model/Utility/my_variable.dart';
import 'package:charoz/Service/Routes/route_page.dart';
import 'package:charoz/Service/Routes/root_binding.dart';
import 'package:charoz/Service/Library/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  await FirebaseMessaging.instance.getInitialMessage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rs.ResponsiveSizer(
      builder: (_, __, screenType) {
        MyVariable.phoneDevice = rs.Device.screenType == rs.ScreenType.mobile;
        MyVariable.androidDevice = Platform.isAndroid;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          title: 'Charoz',
          getPages: RoutePage.getPages,
          initialRoute: RoutePage.routeSplashPage,
          initialBinding: RootBinding(),
          theme: ThemeData(primarySwatch: Colors.orange),
        );
      },
    );
  }
}
