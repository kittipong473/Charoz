import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyStyle {
  static const Color colorBackGround = Color(0xFFBBDEFB);
  static const Color primary = Color(0xfff57f17);
  static const Color light = Color(0xffffb04c);
  static const Color dark = Color(0xffbc5100);
  static const Color bluePrimary = Color(0xff303f9f);
  static Map<int, Color> mapMaterialColor = {
    50: const Color(0xfffffde7),
    100: const Color(0xfffff9c4),
    200: const Color(0xfffff59d),
    300: const Color(0xfffff176),
    400: const Color(0xffffee58),
    500: const Color(0xffffeb3b),
    600: const Color(0xfffdd835),
    700: const Color(0xfffbc02d),
    800: const Color(0xfff9a825),
    900: const Color(0xfff57f17),
  };

  TextStyle textStyle(FontWeight weight, Color color, double size) =>
      GoogleFonts.kanit(
        textStyle: TextStyle(fontWeight: weight, color: color, fontSize: size),
      );

  TextStyle normalGrey12() => textStyle(FontWeight.normal, Colors.grey, 12.sp);
  TextStyle normalGrey14() => textStyle(FontWeight.normal, Colors.grey, 14.sp);
  TextStyle normalBlack14() =>
      textStyle(FontWeight.normal, Colors.black, 14.sp);
  TextStyle normalWhite14() =>
      textStyle(FontWeight.normal, Colors.white, 14.sp);
  TextStyle normalPrimary14() => textStyle(FontWeight.normal, primary, 14.sp);
  TextStyle normalGreen14() =>
      textStyle(FontWeight.normal, Colors.green, 14.sp);
  TextStyle normalRed14() => textStyle(FontWeight.normal, Colors.red, 14.sp);
  TextStyle normalBlue14() => textStyle(FontWeight.normal, Colors.blue, 14.sp);
  TextStyle normalWhite16() =>
      textStyle(FontWeight.normal, Colors.white, 16.sp);
  TextStyle normalGrey16() => textStyle(FontWeight.normal, Colors.grey, 16.sp);
  TextStyle normalBlack16() =>
      textStyle(FontWeight.normal, Colors.black, 16.sp);
  TextStyle normalPrimary16() => textStyle(FontWeight.normal, primary, 16.sp);
  TextStyle normalBlue16() => textStyle(FontWeight.normal, Colors.blue, 16.sp);
  TextStyle normalBlack18() =>
      textStyle(FontWeight.normal, Colors.black, 18.sp);
  TextStyle normalWhite18() =>
      textStyle(FontWeight.normal, Colors.white, 18.sp);
  TextStyle normalGrey18() => textStyle(FontWeight.normal, Colors.grey, 18.sp);
  TextStyle normalPrimary18() => textStyle(FontWeight.normal, primary, 18.sp);
  TextStyle normalBlue18() => textStyle(FontWeight.normal, Colors.blue, 18.sp);
  TextStyle normalGreen18() =>
      textStyle(FontWeight.normal, Colors.green, 18.sp);
  TextStyle normalRed18() => textStyle(FontWeight.normal, Colors.red, 18.sp);
  TextStyle normalPurple18() =>
      textStyle(FontWeight.normal, Colors.purple, 18.sp);
  TextStyle boldBlack12() => textStyle(FontWeight.bold, Colors.black, 12.sp);
  TextStyle boldBlack14() => textStyle(FontWeight.bold, Colors.black, 14.sp);
  TextStyle boldWhite14() => textStyle(FontWeight.bold, Colors.white, 14.sp);
  TextStyle boldGrey14() => textStyle(FontWeight.bold, Colors.grey, 14.sp);
  TextStyle boldPrimary14() => textStyle(FontWeight.bold, primary, 14.sp);
  TextStyle boldGreen14() => textStyle(FontWeight.bold, Colors.green, 14.sp);
  TextStyle boldRed14() => textStyle(FontWeight.bold, Colors.red, 14.sp);
  TextStyle boldBlue14() => textStyle(FontWeight.bold, Colors.blue, 14.sp);
  TextStyle boldGrey16() => textStyle(FontWeight.bold, Colors.grey, 16.sp);
  TextStyle boldBlack16() => textStyle(FontWeight.bold, Colors.black, 16.sp);
  TextStyle boldWhite16() => textStyle(FontWeight.bold, Colors.white, 16.sp);
  TextStyle boldPrimary16() => textStyle(FontWeight.bold, primary, 16.sp);
  TextStyle boldBlue16() => textStyle(FontWeight.bold, Colors.blue, 16.sp);
  TextStyle boldGreen16() => textStyle(FontWeight.bold, Colors.green, 16.sp);
  TextStyle boldRed16() => textStyle(FontWeight.bold, Colors.red, 16.sp);
  TextStyle boldBlack18() => textStyle(FontWeight.bold, Colors.black, 18.sp);
  TextStyle boldWhite18() => textStyle(FontWeight.bold, Colors.white, 18.sp);
  TextStyle boldGrey18() => textStyle(FontWeight.bold, Colors.grey, 18.sp);
  TextStyle boldPrimary18() => textStyle(FontWeight.bold, primary, 18.sp);
  TextStyle boldBlue18() => textStyle(FontWeight.bold, Colors.blue, 18.sp);
  TextStyle boldGreen18() => textStyle(FontWeight.bold, Colors.green, 18.sp);
  TextStyle boldRed18() => textStyle(FontWeight.bold, Colors.red, 18.sp);
  TextStyle boldPurple18() => textStyle(FontWeight.bold, Colors.purple, 18.sp);
  TextStyle boldPrimary20() => textStyle(FontWeight.bold, primary, 20.sp);
  TextStyle boldRed20() => textStyle(FontWeight.bold, Colors.red, 20.sp);
  TextStyle boldGreen20() => textStyle(FontWeight.bold, Colors.green, 20.sp);
  TextStyle boldBlue20() => textStyle(FontWeight.bold, Colors.blue, 20.sp);
}
