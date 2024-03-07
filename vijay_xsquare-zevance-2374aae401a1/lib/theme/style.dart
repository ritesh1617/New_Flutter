import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';


ThemeData appThemeDark = ThemeData();
ThemeData appThemeLight = ThemeData(
    backgroundColor: colors.whiteTemp,
    primaryColor: colors.primary,
    splashColor: Colors.transparent,
    unselectedWidgetColor: Colors.grey,
    disabledColor: Colors.grey,
    accentColor: colors.primary,
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: colors.primary,
    ),
    appBarTheme: AppBarTheme(
        color: colors.whiteTemp,
        elevation: 0.0,
        iconTheme: IconThemeData(color: colors.blackTemp)),
    buttonTheme: ButtonThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        buttonColor: colors.secondary,
        height: 50,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26)))),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
          color: colors.blackTemp,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18.0),
      labelStyle: TextStyle(
          color: colors.grayTemp,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18.0),
      focusedBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color:colors.transparent, width: 0),
      ),
      focusedErrorBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color: colors.transparent, width: 0),
      ),
      border: new UnderlineInputBorder(
        borderSide: BorderSide(color: colors.transparent, width: 0),
      ),
      enabledBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color: colors.transparent, width: 0),
      ),
      disabledBorder: new UnderlineInputBorder(
        borderSide: BorderSide(color: colors.transparent, width: 0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(12, 2, 8, 2),
    ),
    fontFamily: 'segoe',
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: colors.blackTemp),
      headline1: TextStyle(
          color: colors.blackTemp,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 30.0),
      bodyText1: TextStyle(
          color: colors.blackTemp,
          fontSize: 26.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal),
      bodyText2: TextStyle(
          color: colors.blackTemp,
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal),
      // body1: TextStyle(
      //     fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
      //body2: TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
      headline4: TextStyle(
          color: colors.blackTemp,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 18.0),
      headline3: TextStyle(
          color: colors.blackTemp,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 12.0),
      headline2: TextStyle(
          color: colors.blackTemp,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 14.0),
    ));

enum AppThemeKeys { LIGHT, DARK }

class AppThemes {
  static ThemeData getThemeFromKey(AppThemeKeys themeKey) {
    switch (themeKey) {
      case AppThemeKeys.LIGHT:
        return appThemeLight;
      case AppThemeKeys.DARK:
        return appThemeDark;
      default:
        return appThemeLight;
    }
  }

  static final containerBoxDecoration = BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: colors.grayLight, blurRadius: 3, offset: Offset(0, 5))
      ]);
}

Color colorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");

  return Color(int.parse('FF' + hexColor, radix: 16));
}

String toHex(Color color) {
  var hex = '#${color.value.toRadixString(16)}';
  return hex;
}


/*
Light Font
 */
TextStyle lightBlack14 = TextStyle(fontSize: 14.0, color: colors.blackTemp, fontWeight: FontWeight.w300);

/*
 Normal Font
 */
//Black
TextStyle normalBlack10 = TextStyle(fontSize: 10.0, color: colors.blackTemp, fontWeight: FontWeight.w400);
TextStyle normalBlack12 = TextStyle(fontSize: 12.0, color: colors.blackTemp, fontWeight: FontWeight.w400);
TextStyle normalBlack14 = TextStyle(fontSize: 14.0, color: colors.blackTemp, fontWeight: FontWeight.w400);
TextStyle normalBlack16 = TextStyle(fontSize: 16.0, color: colors.blackTemp, fontWeight: FontWeight.w400);
TextStyle normalBlack18 = TextStyle(fontSize: 18.0, color: colors.blackTemp, fontWeight: FontWeight.w400);
TextStyle normalBlack32 = TextStyle(fontSize: 32.0, color: colors.blackTemp, fontWeight: FontWeight.w400);

//App Accent
TextStyle normalAccent10 = TextStyle(fontSize: 10.0, color: colors.secondary, fontWeight: FontWeight.w400);
TextStyle normalAccent12 = TextStyle(fontSize: 12.0, color: colors.secondary, fontWeight: FontWeight.w400);
TextStyle normalAccent14 = TextStyle(fontSize: 14.0, color: colors.secondary, fontWeight: FontWeight.w400);
TextStyle normalAccent16 = TextStyle(fontSize: 16.0, color: colors.secondary, fontWeight: FontWeight.w400);
TextStyle normalAccent18 = TextStyle(fontSize: 18.0, color: colors.secondary, fontWeight: FontWeight.w400);
TextStyle normalAccent32 = TextStyle(fontSize: 16, color: colors.secondary, fontWeight: FontWeight.w400);

//App Primary
TextStyle normalPrimary10 = TextStyle(fontSize: 10.0, color: colors.primary, fontWeight: FontWeight.w400);
TextStyle normalPrimary12 = TextStyle(fontSize: 12.0, color: colors.primary, fontWeight: FontWeight.w400);
TextStyle normalPrimary14 = TextStyle(fontSize: 14.0, color: colors.primary, fontWeight: FontWeight.w400);
TextStyle normalPrimary16 = TextStyle(fontSize: 16.0, color: colors.primary, fontWeight: FontWeight.w400);
TextStyle normalPrimary18 = TextStyle(fontSize: 18.0, color: colors.primary, fontWeight: FontWeight.w400);
TextStyle normalPrimary25 = TextStyle(fontSize: 25.0, color: colors.primary, fontWeight: FontWeight.bold);
TextStyle normalPrimary32 = TextStyle(fontSize: 16, color: colors.primary, fontWeight: FontWeight.w400);


//white
TextStyle normalWhite12 = TextStyle(fontSize: 12.0, color: colors.whiteTemp, fontWeight: FontWeight.w400);
TextStyle normalWhite14 = TextStyle(fontSize: 14.0, color: colors.whiteTemp, fontWeight: FontWeight.w400);
TextStyle regularWhite16 = TextStyle(fontSize: 16.0, color: colors.whiteTemp, fontWeight: FontWeight.w400);
TextStyle regularWhiteHeader = TextStyle(fontSize: 40.0, color: colors.whiteTemp, fontWeight: FontWeight.w400);

//gray
TextStyle normalGray10 = TextStyle(fontSize: 10.0, color: colors.grayTemp, fontWeight: FontWeight.w400);
TextStyle normalGray12 = TextStyle(fontSize: 12.0, color: colors.grayTemp, fontWeight: FontWeight.w400);
TextStyle normalGray14 = TextStyle(fontSize: 14.0, color: colors.grayTemp, fontWeight: FontWeight.w400);
TextStyle normalGray16 = TextStyle(fontSize: 16.0, color: colors.grayTemp, fontWeight: FontWeight.w400);


//Black
TextStyle regularBlack10 = TextStyle(fontSize: 10.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack12 = TextStyle(fontSize: 12.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack13 = TextStyle(fontSize: 13.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack14 = TextStyle(fontSize: 14.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack16 = TextStyle(fontSize: 16.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack18 = TextStyle(fontSize: 18.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack22 = TextStyle(fontSize: 22.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack26 = TextStyle(fontSize: 26.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack30 = TextStyle(fontSize: 30.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularBlack36 = TextStyle(fontSize: 36.0, color: colors.blackTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
//white
TextStyle regularWhite8 = TextStyle(fontSize: 8.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite10 = TextStyle(fontSize: 10.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite12 = TextStyle(fontSize: 12.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite14 = TextStyle(fontSize: 14.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite18 = TextStyle(fontSize: 18.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite20 = TextStyle(fontSize: 20.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);
TextStyle regularWhite25 = TextStyle(fontSize: 25.0, color: colors.whiteTemp, fontWeight: FontWeight.bold);
TextStyle regularWhite36 = TextStyle(fontSize: 36.0, color: colors.whiteTemp, fontWeight: FontWeight.w500);

//appColor
TextStyle regularPrimary10 = TextStyle(fontSize: 10.0, color: colors.primary, fontWeight: FontWeight.w500);
TextStyle regularPrimary12 = TextStyle(fontSize: 12.0, color: colors.primary, fontWeight: FontWeight.w500);
TextStyle regularPrimary14 = TextStyle(fontSize: 14.0, color: colors.primary, fontWeight: FontWeight.w500);
TextStyle regularPrimary18 = TextStyle(fontSize: 18.0, color: colors.primary, fontWeight: FontWeight.w500);
TextStyle regularPrimary16 = TextStyle(fontSize: 16.0, color: colors.primary, fontWeight: FontWeight.w500);
TextStyle regularPrimary20 = TextStyle(fontSize: 20.0, color: colors.primary, fontWeight: FontWeight.w500);


TextStyle regularWhiteBack14 = TextStyle(fontSize: 14.0, color: colors.whiteTemp, fontWeight: FontWeight.w500,backgroundColor: colors.primary);
TextStyle regularWhiteBack16 = TextStyle(fontSize: 16.0, color: colors.whiteTemp, fontWeight: FontWeight.w500,backgroundColor: colors.primary);
TextStyle regularWhiteBack18 = TextStyle(fontSize: 18.0, color: colors.whiteTemp, fontWeight: FontWeight.w500,backgroundColor: colors.primary);
//gray
TextStyle regularGray8 = TextStyle(fontSize: 8.0, color: colors.grayTemp, fontWeight: FontWeight.w100,fontFamily: "montserrat");
TextStyle regularGray10 = TextStyle(fontSize: 10.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularGray12 = TextStyle(fontSize: 12.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularGray13 = TextStyle(fontSize: 13.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularGray14 = TextStyle(fontSize: 14.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularGray16 = TextStyle(fontSize: 16.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");
TextStyle regularGray18 = TextStyle(fontSize: 18.0, color: colors.grayTemp, fontWeight: FontWeight.w500,fontFamily: "montserrat");

/*
Semi bold
 */

TextStyle semiBoldWhite16 = TextStyle(fontSize: 16.0, color: colors.whiteTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldWhite18 = TextStyle(fontSize: 18.0, color: colors.whiteTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldWhite20 = TextStyle(fontSize: 20.0, color: colors.whiteTemp, fontWeight: FontWeight.w600);
TextStyle toolbarWhite20 = TextStyle(fontSize: 20.0, color: colors.whiteTemp, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, );

TextStyle semiBoldGrayBlue16 = TextStyle(fontSize: 16.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldGrayBlue18 = TextStyle(fontSize: 18.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldGrayBlue20 = TextStyle(fontSize: 20.0, color: colors.blackTemp, fontWeight: FontWeight.w600);




TextStyle semiBoldBlack16 = TextStyle(fontSize: 16.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack12 = TextStyle(fontSize: 12.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack14 = TextStyle(fontSize: 14.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack18 = TextStyle(fontSize: 18.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack20 = TextStyle(fontSize: 20.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack22 = TextStyle(fontSize: 22.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldBlack24 = TextStyle(fontSize: 24.0, color: colors.blackTemp, fontWeight: FontWeight.w600);


TextStyle semiBoldGrayBlue22 = TextStyle(fontSize: 22.0, color: colors.blackTemp, fontWeight: FontWeight.w600);
TextStyle semiBoldGrayBlue26 = TextStyle(fontSize: 26.0, color: colors.blackTemp, fontWeight: FontWeight.w600);

/*
Bold
 */
TextStyle boldBlack12 = TextStyle(fontSize: 12.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack13 = TextStyle(fontSize: 13.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack14 = TextStyle(fontSize: 14.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack16 = TextStyle(fontSize: 16.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack18 = TextStyle(fontSize: 18.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack20 = TextStyle(fontSize: 20.0, color: colors.blackTemp, fontFamily: "montserrat_bold");
TextStyle boldBlack24 = TextStyle(fontSize: 24.0, color: colors.blackTemp, fontWeight: FontWeight.w700,fontFamily: "montserrat_bold");
TextStyle boldBlack30 = TextStyle(fontSize: 30.0, color: colors.blackTemp, fontWeight: FontWeight.w700,fontFamily: "montserrat_bold");
TextStyle boldBlack36 = TextStyle(fontSize: 36.0, color: colors.blackTemp, fontWeight: FontWeight.w700,fontFamily: "montserrat_bold");
TextStyle boldGrayBlue26 = TextStyle(fontSize: 26, color: colors.blackTemp, fontWeight: FontWeight.w700,fontFamily: "montserrat_bold");

TextStyle boldWhite14 = TextStyle(fontSize: 14.0, color: colors.whiteTemp, fontWeight: FontWeight.w700);
TextStyle boldWhite16 = TextStyle(fontSize: 16.0, color: colors.whiteTemp, fontWeight: FontWeight.w700);
TextStyle boldWhite18 = TextStyle(fontSize: 18.0, color: colors.whiteTemp, fontWeight: FontWeight.w700);
TextStyle boldWhite22 = TextStyle(fontSize: 22.0, color: colors.whiteTemp, fontWeight: FontWeight.w700);
TextStyle boldWhite24 = TextStyle(fontSize: 24.0, color: colors.whiteTemp, fontWeight: FontWeight.w700);


TextStyle boldGray12 = TextStyle(fontSize: 12.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
TextStyle boldGray13 = TextStyle(fontSize: 13.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
TextStyle boldGray14 = TextStyle(fontSize: 14.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
TextStyle boldGray16 = TextStyle(fontSize: 16.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
TextStyle boldGray18 = TextStyle(fontSize: 18.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
TextStyle boldGray20 = TextStyle(fontSize: 20.0, color: colors.grayTemp, fontFamily: "montserrat_bold");
//green
TextStyle normalGreen16 = TextStyle(fontSize: 16.0, color: Colors.teal, fontWeight: FontWeight.bold);
TextStyle normalGreen18 = TextStyle(fontSize: 18.0, color: Colors.teal, fontWeight: FontWeight.bold);


/*
Name	      Weight
Normal,     Regular	400
Medium	    500
Semi Bold,  Demi Bold	600
Bold	700
 */

changeStatusColor(Color color) async {
  /*try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      debugPrint('ifff====>$color');
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

      debugPrint('else====>$color');
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }*/
}


