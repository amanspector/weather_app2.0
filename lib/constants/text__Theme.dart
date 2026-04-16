import 'package:flutter/material.dart';
import 'package:weather_app/constants/colorConstant.dart';

// ignore: camel_case_types
class Text__Theme {
  static TextTheme textThemeLight = TextTheme(
    titleLarge: TextStyle().copyWith(
      fontSize: 100,
      fontFamily: 'SFPro',
      color: Colorconstant.blackcolor,
    ),
    displayLarge: TextStyle().copyWith(
      fontFamily: 'SFPro',
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colorconstant.blackcolor,
    ),

    displayMedium: TextStyle().copyWith(
      fontSize: 23,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w500,
      color: Colorconstant.blackcolor,
    ),
    displaySmall: TextStyle().copyWith(
      fontSize: 16,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w600,
      color: Colorconstant.blackcolor,
    ),

    labelSmall: TextStyle().copyWith(
      fontSize: 16,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w400,
      color: Colorconstant.blackcolor,
    ),
  );

  static TextTheme textThemeDark = TextTheme(
    titleLarge: TextStyle().copyWith(
      fontSize: 100,
      fontFamily: 'SFPro',
      color: Colorconstant.whitecolor,
    ),
    displayLarge: TextStyle().copyWith(
      fontSize: 36,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.bold,
      color: Colorconstant.whitecolor,
    ),
    displayMedium: TextStyle().copyWith(
      fontSize: 24,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w600,
      color: Colorconstant.whitecolor,
    ),

    displaySmall: TextStyle().copyWith(
      fontSize: 15,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w600,
      color: Colorconstant.whitecolor,
    ),

    labelSmall: TextStyle().copyWith(
      fontSize: 16,
      fontFamily: 'SFPro',
      fontWeight: FontWeight.w400,
      color: Colorconstant.whitecolor,
    ),
  );
}
