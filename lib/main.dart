import 'package:charoz/Service/Route/route_page.dart';
import 'package:charoz/Service/Route/route_provider.dart';
import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:charoz/Utilty/Constant/my_variable.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String initialRoute = RoutePage.routeSplashPage;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    // await MyVariable.auth.signOut();
    MyVariable.auth.authStateChanges().listen((event) {
      if (event != null) {
        MyVariable.accountUid = event.uid;
        print(event.uid);
      }
    });
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: routeMultiProvider(),

    // Basically mode
    child: const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),

    // Testing Emulator mode
    // child: DevicePreview(
    //   builder: (context) => const MaterialApp(
    //     home: MyApp(),
    //     useInheritedMediaQuery: true,
    //     debugShowCheckedModeBanner: false,
    //   ),
    // ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        if (Device.screenType == ScreenType.tablet) {
          MyVariable.largeDevice = true;
        } else {
          MyVariable.largeDevice = false;
        }
        MaterialColor materialColor =
            MaterialColor(0xfff57f17, MyStyle.mapMaterialColor);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: DevicePreview.appBuilder,
          title: MyVariable.mainTitle,
          routes: routes,
          initialRoute: initialRoute,
          theme: ThemeData(
            primarySwatch: materialColor,
          ),
        );
      },
    );
  }
}
