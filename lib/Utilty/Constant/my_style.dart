import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyStyle {
  static const Color primary = Color(0xfff57f17);
  static const Color light = Color(0xffffb04c);
  static const Color dark = Color(0xffbc5100);
  static const Color blue = Color(0xff303f9f);
  static Color colorBackGround = Colors.blue.shade100;
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

  TextStyle normalGrey12() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12.sp,
        ),
      );
  TextStyle normalGrey14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalBlack14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontSize: 14.sp,
        ),
      );
  TextStyle normalWhite14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalPrimary14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: primary,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalGreen14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.green,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalRed14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.red,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalBlue14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: blue,
          fontSize: 14.sp,
        ),
      );
  TextStyle normalGrey16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.sp,
        ),
      );
  TextStyle normalBlack16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
        ),
      );
  TextStyle normalPrimary16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: primary,
          fontSize: 16.sp,
        ),
      );
  TextStyle normalBlue16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: blue,
          fontSize: 16.sp,
        ),
      );
  TextStyle normalWhite18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
        ),
      );
  TextStyle normalGrey18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.black45,
          fontSize: 18.sp,
        ),
      );
  TextStyle normalPrimary18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: primary,
          fontSize: 18.sp,
        ),
      );
  TextStyle normalBlue18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: blue,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldBlack12() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      );
  TextStyle boldBlack14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldWhite14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldGrey14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldPrimary14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: primary,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldGreen14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldRed14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldBlue14() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: blue,
          fontSize: 14.sp,
        ),
      );
  TextStyle boldGrey16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldBlack16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldWhite16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldPrimary16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: primary,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldBlue16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: blue,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldGreen16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldRed16() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 16.sp,
        ),
      );
  TextStyle boldBlack18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldWhite18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldGrey18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldPrimary18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: primary,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldBlue18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: blue,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldGreen18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green.shade700,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldRed18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red.shade700,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldPurple18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple.shade700,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldDark18() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: dark,
          fontSize: 18.sp,
        ),
      );
  TextStyle boldPrimary20() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: primary,
          fontSize: 20.sp,
        ),
      );
  TextStyle boldRed20() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 20.sp,
        ),
      );
  TextStyle boldGreen20() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800,
          fontSize: 20.sp,
        ),
      );
  TextStyle boldBlue20() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: blue,
          fontSize: 20.sp,
        ),
      );
  TextStyle boldBlack18OTP() => GoogleFonts.kanit(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          letterSpacing: 20,
        ),
      );

  BoxShadow boxShadow({required Color color}) => BoxShadow(
        color: color,
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 1),
      );
  Shadow textShadow() => const Shadow(
        color: Colors.white,
        blurRadius: 10,
        offset: Offset(0, 1),
      );
}
