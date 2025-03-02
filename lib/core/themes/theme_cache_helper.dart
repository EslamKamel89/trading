import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/themes/apptheme_data.dart';
import 'package:trading/core/themes/apptheme_enum.dart';

class ThemeCacheHelper {
  SharedPreferences sharedPreferences;
  ThemeCacheHelper({required this.sharedPreferences});
  void cacheTheme({required String themeType}) {
    sharedPreferences.setString(AppStrings.THEME, themeType);
  }

  ThemeData getCachedTheme() {
    String? themeType = sharedPreferences.getString(AppStrings.THEME);

    if (themeType == "light") {
      return appThemeData[AppTheme.blueLight]!;
    } else {
      return appThemeData[AppTheme.blueDark]!;
    }
  }

  bool isLightTheme() {
    String? themeType = sharedPreferences.getString(AppStrings.THEME);
    // themeType.toString().prm('Theme Chche Helper');
    if (themeType == "light") {
      return true;
    } else {
      return false;
    }
  }
}
