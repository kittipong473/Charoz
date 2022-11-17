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
        textStyle: TextStyle(
          fontWeight: weight,
          color: color,
          fontSize: size.sp,
        ),
      );

  BorderRadius borderRadius(int radius) => BorderRadius.circular(radius.sp);

  TextStyle normalGrey12() => textStyle(FontWeight.normal, Colors.grey, 12);
  TextStyle normalGrey14() => textStyle(FontWeight.normal, Colors.grey, 14);
  TextStyle normalBlack14() => textStyle(FontWeight.normal, Colors.black, 14);
  TextStyle normalWhite14() => textStyle(FontWeight.normal, Colors.white, 14);
  TextStyle normalPrimary14() => textStyle(FontWeight.normal, primary, 14);
  TextStyle normalGreen14() => textStyle(FontWeight.normal, Colors.green, 14);
  TextStyle normalRed14() => textStyle(FontWeight.normal, Colors.red, 14);
  TextStyle normalBlue14() => textStyle(FontWeight.normal, bluePrimary, 14);
  TextStyle normalWhite16() => textStyle(FontWeight.normal, Colors.white, 16);
  TextStyle normalGrey16() => textStyle(FontWeight.normal, Colors.grey, 16);
  TextStyle normalBlack16() => textStyle(FontWeight.normal, Colors.black, 16);
  TextStyle normalPrimary16() => textStyle(FontWeight.normal, primary, 16);
  TextStyle normalBlue16() => textStyle(FontWeight.normal, bluePrimary, 16);
  TextStyle normalBlack18() => textStyle(FontWeight.normal, Colors.black, 18);
  TextStyle normalWhite18() => textStyle(FontWeight.normal, Colors.white, 18);
  TextStyle normalGrey18() => textStyle(FontWeight.normal, Colors.grey, 18);
  TextStyle normalPrimary18() => textStyle(FontWeight.normal, primary, 18);
  TextStyle normalBlue18() => textStyle(FontWeight.normal, bluePrimary, 18);
  TextStyle normalGreen18() => textStyle(FontWeight.normal, Colors.green, 18);
  TextStyle normalRed18() => textStyle(FontWeight.normal, Colors.red, 18);
  TextStyle normalPurple18() => textStyle(FontWeight.normal, Colors.purple, 18);
  TextStyle normalWhite22() => textStyle(FontWeight.normal, Colors.white, 22);
  TextStyle boldBlack12() => textStyle(FontWeight.bold, Colors.black, 12);
  TextStyle boldBlack14() => textStyle(FontWeight.bold, Colors.black, 14);
  TextStyle boldWhite14() => textStyle(FontWeight.bold, Colors.white, 14);
  TextStyle boldGrey14() => textStyle(FontWeight.bold, Colors.grey, 14);
  TextStyle boldPrimary14() => textStyle(FontWeight.bold, primary, 14);
  TextStyle boldGreen14() => textStyle(FontWeight.bold, Colors.green, 14);
  TextStyle boldRed14() => textStyle(FontWeight.bold, Colors.red, 14);
  TextStyle boldBlue14() => textStyle(FontWeight.bold, bluePrimary, 14);
  TextStyle boldGrey16() => textStyle(FontWeight.bold, Colors.grey, 16);
  TextStyle boldBlack16() => textStyle(FontWeight.bold, Colors.black, 16);
  TextStyle boldWhite16() => textStyle(FontWeight.bold, Colors.white, 16);
  TextStyle boldPrimary16() => textStyle(FontWeight.bold, primary, 16);
  TextStyle boldBlue16() => textStyle(FontWeight.bold, bluePrimary, 16);
  TextStyle boldGreen16() => textStyle(FontWeight.bold, Colors.green, 16);
  TextStyle boldRed16() => textStyle(FontWeight.bold, Colors.red, 16);
  TextStyle boldBlack18() => textStyle(FontWeight.bold, Colors.black, 18);
  TextStyle boldWhite18() => textStyle(FontWeight.bold, Colors.white, 18);
  TextStyle boldGrey18() => textStyle(FontWeight.bold, Colors.grey, 18);
  TextStyle boldPrimary18() => textStyle(FontWeight.bold, primary, 18);
  TextStyle boldBlue18() => textStyle(FontWeight.bold, bluePrimary, 18);
  TextStyle boldGreen18() => textStyle(FontWeight.bold, Colors.green, 18);
  TextStyle boldRed18() => textStyle(FontWeight.bold, Colors.red, 18);
  TextStyle boldPurple18() => textStyle(FontWeight.bold, Colors.purple, 18);
  TextStyle boldPrimary20() => textStyle(FontWeight.bold, primary, 20);
  TextStyle boldRed20() => textStyle(FontWeight.bold, Colors.red, 20);
  TextStyle boldGreen20() => textStyle(FontWeight.bold, Colors.green, 20);
  TextStyle boldBlue20() => textStyle(FontWeight.bold, bluePrimary, 20);
}
