// ------------------------------------------------------------------------------------
// AppLocalization -------------------------------------------------------------------------------
//--8-- create a class that will create the delegate which will be able to translate
// the text based on en.json and ar.json
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  Locale? locale;
  AppLocalization({this.locale});
  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  late Map<String, String> _localizedStrings;
  Future loadJsonLanguage() async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale?.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => _localizedStrings[key] ?? '';
  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
//!--14-- remeber that the list here is static and whenever you want to add
//! another language you should add it here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale: locale);
    await appLocalization.loadJsonLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}

extension Translatex on String {
  String tr(BuildContext context) {
    return AppLocalization.of(context)!.translate(this);
  }
}
