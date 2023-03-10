import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyStyle {
  static const Color backgroundColor = Color(0xFFBBDEFB);
  static const Color orangePrimary = Color(0xfff57f17);
  static const Color orangeLight = Color(0xffffb04c);
  static const Color orangeDark = Color(0xffbc5100);
  static const Color bluePrimary = Color(0xff081c70);
  static const Color blueLight = Color(0xffd0dce8);
  static const Color yellowPrimary = Color(0xffffeb00);
  static const Color yellowLight = Color(0xfffaf2d2);
  static const Color greenPrimary = Color(0xff33c773);
  static const Color greenLight = Color(0xffd6f4e3);
  static const Color redPrimary = Color(0xffe63737);
  static const Color redLight = Color(0xffffd7d7);
  static const Color greyPrimary = Color(0xffbbc3cb);
  static const Color greyLight = Color(0xFFEFF4F8);
  static const Color whitePrimary = Color(0xffffffff);
  static const Color blackPrimary = Color(0xff1c1c1e);

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

  BoxShadow boxShadow() => const BoxShadow(
        color: blueLight,
        blurRadius: 3,
        spreadRadius: -3,
        offset: Offset(3, 3),
        blurStyle: BlurStyle.normal,
      );
  Shadow shadow() => const Shadow(
        color: greenPrimary,
        blurRadius: 3,
        offset: Offset.zero,
      );

  BorderRadius borderRadius5() => BorderRadius.circular(5.sp);
  BorderRadius borderRadius10() => BorderRadius.circular(10.sp);
  BorderRadius borderRadius15() => BorderRadius.circular(15.sp);
  BorderRadius borderRadius20() => BorderRadius.circular(20.sp);

  TextStyle normalGrey12() => textStyle(FontWeight.normal, Colors.grey, 12);
  TextStyle normalGrey14() => textStyle(FontWeight.normal, Colors.grey, 14);
  TextStyle normalBlack14() => textStyle(FontWeight.normal, Colors.black, 14);
  TextStyle normalWhite14() => textStyle(FontWeight.normal, Colors.white, 14);
  TextStyle normalPrimary14() =>
      textStyle(FontWeight.normal, orangePrimary, 14);
  TextStyle normalGreen14() => textStyle(FontWeight.normal, Colors.green, 14);
  TextStyle normalRed14() => textStyle(FontWeight.normal, Colors.red, 14);
  TextStyle normalBlue14() => textStyle(FontWeight.normal, bluePrimary, 14);
  TextStyle normalWhite16() => textStyle(FontWeight.normal, Colors.white, 16);
  TextStyle normalGrey16() => textStyle(FontWeight.normal, Colors.grey, 16);
  TextStyle normalBlack16() => textStyle(FontWeight.normal, Colors.black, 16);
  TextStyle normalPrimary16() =>
      textStyle(FontWeight.normal, orangePrimary, 16);
  TextStyle normalBlue16() => textStyle(FontWeight.normal, bluePrimary, 16);
  TextStyle normalGreen16() => textStyle(FontWeight.normal, Colors.green, 16);
  TextStyle normalRed16() => textStyle(FontWeight.normal, Colors.red, 16);
  TextStyle normalBlack18() => textStyle(FontWeight.normal, Colors.black, 18);
  TextStyle normalWhite18() => textStyle(FontWeight.normal, Colors.white, 18);
  TextStyle normalGrey18() => textStyle(FontWeight.normal, Colors.grey, 18);
  TextStyle normalPrimary18() =>
      textStyle(FontWeight.normal, orangePrimary, 18);
  TextStyle normalBlue18() => textStyle(FontWeight.normal, bluePrimary, 18);
  TextStyle normalGreen18() => textStyle(FontWeight.normal, Colors.green, 18);
  TextStyle normalRed18() => textStyle(FontWeight.normal, Colors.red, 18);
  TextStyle normalPurple18() => textStyle(FontWeight.normal, Colors.purple, 18);
  TextStyle normalWhite22() => textStyle(FontWeight.normal, Colors.white, 22);
  TextStyle boldBlack12() => textStyle(FontWeight.bold, Colors.black, 12);
  TextStyle boldBlack14() => textStyle(FontWeight.bold, Colors.black, 14);
  TextStyle boldWhite14() => textStyle(FontWeight.bold, Colors.white, 14);
  TextStyle boldGrey14() => textStyle(FontWeight.bold, Colors.grey, 14);
  TextStyle boldPrimary14() => textStyle(FontWeight.bold, orangePrimary, 14);
  TextStyle boldGreen14() => textStyle(FontWeight.bold, Colors.green, 14);
  TextStyle boldRed14() => textStyle(FontWeight.bold, Colors.red, 14);
  TextStyle boldBlue14() => textStyle(FontWeight.bold, bluePrimary, 14);
  TextStyle boldGrey16() => textStyle(FontWeight.bold, Colors.grey, 16);
  TextStyle boldBlack16() => textStyle(FontWeight.bold, Colors.black, 16);
  TextStyle boldWhite16() => textStyle(FontWeight.bold, Colors.white, 16);
  TextStyle boldPrimary16() => textStyle(FontWeight.bold, orangePrimary, 16);
  TextStyle boldBlue16() => textStyle(FontWeight.bold, bluePrimary, 16);
  TextStyle boldGreen16() => textStyle(FontWeight.bold, Colors.green, 16);
  TextStyle boldRed16() => textStyle(FontWeight.bold, Colors.red, 16);
  TextStyle boldBlack18() => textStyle(FontWeight.bold, Colors.black, 18);
  TextStyle boldWhite18() => textStyle(FontWeight.bold, Colors.white, 18);
  TextStyle boldGrey18() => textStyle(FontWeight.bold, Colors.grey, 18);
  TextStyle boldPrimary18() => textStyle(FontWeight.bold, orangePrimary, 18);
  TextStyle boldBlue18() => textStyle(FontWeight.bold, bluePrimary, 18);
  TextStyle boldGreen18() => textStyle(FontWeight.bold, Colors.green, 18);
  TextStyle boldRed18() => textStyle(FontWeight.bold, Colors.red, 18);
  TextStyle boldPurple18() => textStyle(FontWeight.bold, Colors.purple, 18);
  TextStyle boldPrimary20() => textStyle(FontWeight.bold, orangePrimary, 20);
  TextStyle boldRed20() => textStyle(FontWeight.bold, Colors.red, 20);
  TextStyle boldGreen20() => textStyle(FontWeight.bold, Colors.green, 20);
  TextStyle boldBlue20() => textStyle(FontWeight.bold, bluePrimary, 20);
}
