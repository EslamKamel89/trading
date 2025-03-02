import 'package:flutter/material.dart';
import 'package:trading/core/themes/apptheme_enum.dart';
import 'package:trading/core/themes/clr.dart';

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.blueLight: ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: Clr.bLight),
    hintColor: Colors.white,
  ),
  AppTheme.blueDark: ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Clr.bDark),
  ),
  AppTheme.redDark: ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.red[700]),
    primaryColor: Colors.red[700],
  ),
};
