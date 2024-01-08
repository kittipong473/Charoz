import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyle {
  static const Color backgroundColor = Color(0xFFBBDEFB);
  static const Color orangePrimary = Color(0xfff57f17);
  static const Color orangeLight = Color(0xffffb04c);
  static const Color orangeDark = Color(0xffbc5100);
  static const Color bluePrimary = Color(0xff081c70);
  static const Color blueLight = Color(0xffd0dce8);
  static const Color yellowPrimary = Color(0xffffeb00);
  static const Color yellowLight = Color(0xfffaf2d2);
  static const Color greenPrimary = Color(0xFF079745);
  static const Color greenLight = Color(0xffd6f4e3);
  static const Color redPrimary = Color(0xffe63737);
  static const Color redLight = Color(0xffffd7d7);
  static const Color greyPrimary = Color(0xffC7CAD8);
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

  static TextStyle textStyle(
          {required double size, required Color color, bool? bold}) =>
      GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          color: color,
          fontSize: size,
        ),
      );

  static BoxShadow boxShadow() => const BoxShadow(
        color: greyPrimary,
        blurRadius: 10,
        spreadRadius: 0,
        offset: Offset(0, 5),
        blurStyle: BlurStyle.normal,
      );
  static Shadow shadow() => const Shadow(
        color: greenPrimary,
        blurRadius: 3,
        offset: Offset.zero,
      );
}
