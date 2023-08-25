import 'package:charoz/Service/Initial/route_page.dart';
import 'package:charoz/Service/Initial/root_binding.dart';
import 'package:charoz/Utility/Variable/var_data.dart';
import 'package:charoz/Utility/Variable/var_general.dart';
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
  // await VariableGeneral.auth.signOut();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rs.ResponsiveSizer(
      builder: (_, __, screenType) {
        VariableGeneral.largeDevice =
            rs.Device.screenType == rs.ScreenType.tablet;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          title: VariableData.mainTitle,
          getPages: RoutePage.getPages,
          initialRoute: RoutePage.routeSplashPage,
          initialBinding: RootBinding(),
          theme: ThemeData(primarySwatch: Colors.orange),
        );
      },
    );
  }
}
