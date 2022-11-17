import 'package:charoz/Model/Service/Route/route_page.dart';
import 'package:charoz/Model/Service/Route/root_binding.dart';
import 'package:charoz/Util/Variable/var_data.dart';
import 'package:charoz/Util/Variable/var_general.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;

String initialRoute = RoutePage.routeSplashPage;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        if (rs.Device.screenType == rs.ScreenType.tablet) {
          VariableGeneral.largeDevice = true;
        } else {
          VariableGeneral.largeDevice = false;
        }
        return OverlaySupport(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            title: VariableData.mainTitle,
            getPages: RoutePage.getPages,
            initialRoute: initialRoute,
            initialBinding: RootBinding(),
            theme: ThemeData(primarySwatch: Colors.orange),
          ),
        );
      },
    );
  }
}
