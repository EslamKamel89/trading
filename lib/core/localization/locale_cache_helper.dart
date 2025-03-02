import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/const-strings/app_strings.dart';

class LocaleCacheHelper {
  SharedPreferences sharedPreferences;
  LocaleCacheHelper({required this.sharedPreferences});
  void cacheLocale({required String languageCode}) {
    sharedPreferences.setString(AppStrings.LOCALE_CODE, languageCode);
  }

  Locale getCachedLocale() {
    String? languageCode = sharedPreferences.getString(AppStrings.LOCALE_CODE);
    if (languageCode == "ar") {
      return const Locale("ar");
    } else {
      return const Locale("en");
    }
  }
}
