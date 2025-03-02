import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/routing/app_routes_names.dart';

class AppMiddleWare {
  SharedPreferences sharedPreferences;
  AppMiddleWare({required this.sharedPreferences});
  // static bool _onBoarding() {
  //   return _sharedPreferences.getBool(AppStorageKey.deviceOpenFirstTime) ?? false;
  // }

  static bool _isSignedIn() {
    final userDataString = sl<SharedPreferences>().getString(AppStrings.USER_DATA);
    if (userDataString == null) {
      return false;
    }
    return true;
  }

  String? middlleware(String? routeName) {
    if (routeName == AppRoutesNames.signin) {
      const t = 'middlleware - AppMiddleWare';
      if (_isSignedIn()) {
        'middleware redirect the app to mainpage screen'.prm(t);
        return AppRoutesNames.bottomNavigationScreen;
      } else {
        'middleware redirect the app to signin screen'.prm(t);
        return AppRoutesNames.signin;
      }
    }
    return routeName;
  }
}
