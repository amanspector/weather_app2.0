import 'package:flutter/material.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/text__Theme.dart';

class Themeconstant {
  static ThemeData lightthemedata = ThemeData(
    brightness: Brightness.light,
    textTheme: Text__Theme.textThemeLight,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colorconstant.blackcolor,
    ),
    colorScheme: ColorScheme.light(
      onSurface: Colorconstant.bluelightcolor,
      primary: Colorconstant.blackcolor,
      onPrimary: Colorconstant.whitecolor,
      secondary: Colorconstant.whitecolor,

      onSecondaryFixed: Colorconstant.bluelightcolor,
    ),
    dividerTheme: DividerThemeData(
      color: Colorconstant.whitecolor,
      thickness: 2,

      // space: 20,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(color: Colorconstant.blackcolor),
      iconColor: Colorconstant.bluelightcolor,

      // contentPadding: EdgeInsets.all(15),
    ),
    listTileTheme: ListTileThemeData(
      selectedTileColor: Colorconstant.blackcolor,
      textColor: Colorconstant.blackcolor,
    ),
  );

  static ThemeData darkthemedata = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colorconstant.whitecolor,
    ),
    brightness: Brightness.dark,
    textTheme: Text__Theme.textThemeDark,
    colorScheme: ColorScheme.dark(
      onSurface: Colorconstant.deeppurplecolor,
      primary: Colorconstant.whitecolor,
      onPrimary: Colorconstant.blackcolorlight,
      secondary: Colorconstant.customgreycolor,
      onSecondaryFixed: Colorconstant.whitecolor,
    ),
    dividerTheme: DividerThemeData(
      color: Colorconstant.blackcolor,
      thickness: 2,
      // space: 20,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(color: Colorconstant.whitecolor),
      suffixIconColor: Colorconstant.whitecolor,
    ),
    listTileTheme: ListTileThemeData(
      selectedTileColor: Colorconstant.whitecolor,
      textColor: Colorconstant.whitecolor,
    ),
  );
}
