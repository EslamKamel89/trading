// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pick_language_cubit.dart';

class PickLanguageAndThemeState {
  final Locale locale;
  final ThemeData themeData;
  const PickLanguageAndThemeState({
    required this.locale,
    required this.themeData,
  });

  PickLanguageAndThemeState copyWith({
    Locale? locale,
    ThemeData? themeData,
  }) {
    return PickLanguageAndThemeState(
      locale: locale ?? this.locale,
      themeData: themeData ?? this.themeData,
    );
  }
}
