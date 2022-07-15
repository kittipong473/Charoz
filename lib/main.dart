import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Service/Route/route_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/global_variable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String initialRoute = RoutePage.routeSplashPage;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    // await GlobalVariable.auth.signOut();
    GlobalVariable.auth.authStateChanges().listen((event) {
      if (event != null) {
        GlobalVariable.accountUid = event.uid;
      }
    });
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(MultiProvider(
    providers: routeMultiProvider(),
    child: const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        if (Device.screenType == ScreenType.tablet) {
          GlobalVariable.largeDevice = true;
        } else {
          GlobalVariable.largeDevice = false;
        }
        MaterialColor materialColor =
            MaterialColor(0xfff57f17, MyStyle.mapMaterialColor);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          title: GlobalVariable.mainTitle,
          routes: routes,
          initialRoute: initialRoute,
          theme: ThemeData(primarySwatch: materialColor),
        );
      },
    );
  }
}
