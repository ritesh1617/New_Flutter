
import 'package:flutter/material.dart';

extension colors on ColorScheme {
  static MaterialColor primary_app = const MaterialColor(
    0xffFC6A57,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color primary =Color(0xff06D0B8);
  static const Color primaryLight =Color(0x4f06d0b8);
  static const Color secondary =  Color(0xff0052C9);
  static const Color secondaryLight =  Color(0xffCCDDFF);

  static const Color firstColor = Color(0xff06D0B8);
  static const Color secondColor = Color(0xff0052C9);
  static const Color titleColor = Color(0xff34648C);

  static const Color backgroundColor = Color(0xffF5F5F5);

  Color get btnColor => this.brightness == Brightness.dark ? whiteTemp : primary;

  Color get lightWhite => this.brightness == Brightness.dark ? darkColor : const Color(0xffEEF2F9);

  Color get fontColor => this.brightness == Brightness.dark ? whiteTemp : const Color(0xff222222);

  Color get gray => this.brightness == Brightness.dark ? darkColor3 : Color(0xfff0f0f0);

  Color get simmerBase => this.brightness == Brightness.dark ? darkColor2 : Colors.grey[300]!;

  Color get simmerHigh =>  this.brightness == Brightness.dark ? darkColor : Colors.grey[100]!;

  static Color darkIcon = Color(0xff9B9B9B);
  static Color grayTemp = Color(0xffACACAC);
  static Color underLineColor = Color(0xffE6E6E6);
  static Color grayShado = Color(0xffdbdbdb);
  static Color grayLight = Color(0xffe3e3e3);
  static Color grayCartLight = Color(0xfff3f3f3);
  static Color transparent = Colors.transparent;

  static const Color grad1Color = Color(0xffFFBD69);
  static const Color grad2Color = Color(0xffFF6363);
  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color yellow = Color(0xfffdd901);


  static const Color greenShado = Color(0x700ad5cf);
  static const Color open = Color(0xff06D0B8);
  static const Color close = Color(0xffF17A7A);
  static const Color resolve = Color(0xffE8AF06);

  static const Color subtitle = Color(0xff0052C9);
  static const Color redDark = Color(0xffE21D1D);

  static const Color red = Colors.red;

  Color get lightBlack =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff52575C);

  Color get lightBlack2 =>
      this.brightness == Brightness.dark ? white70 : const Color(0xff999999);

  static const Color darkColor = Color(0xff17242B);
  static const Color darkColor2 = Color(0xff29414E);
  static const Color darkColor3 = Color(0xff22343C);

  Color get white =>
      this.brightness == Brightness.dark ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xffFFFFFF);

  Color get black =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color black28 = Colors.black26;
  static const Color black38 = Colors.black38;
  static const Color disableColor = Color(0xffEEF2F9);

  static const Color blackTemp = Color(0xff000000);
  static const Color textBlack = Color(0xff000000);

  Color get black26 =>
      this.brightness == Brightness.dark ? white30 : Colors.black26;
  static const Color cardColor = Color(0xffFFFFFF);

  Color get back1 => this.brightness == Brightness.dark
      ? Color(0xff1E3039)
      : Color(0x66a2d8fe);

  Color get back2 => this.brightness == Brightness.dark
      ? Color(0xff09202C)
      : Color(0x66bdb1ff);

  Color get back3 => this.brightness == Brightness.dark
      ? Color(0xff10101E)
      : Color(0x66EFAFBF);

  Color get back4 => this.brightness == Brightness.dark
      ? Color(0xff171515)
      : Color(0x66F9DED7);

  Color get back5 => this.brightness == Brightness.dark
      ? Color(0xff0F1412)
      : Color(0x66C6F8E5);
}
