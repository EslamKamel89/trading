import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';

double handleGraphRatio(double ratio, String ratioCacheKey) {
  // "Hello World 1".prm('handleGraphRatio');
  double oldRatio = sl<SharedPreferences>().getDouble(ratioCacheKey) ?? 0.01;
  // ratio.prm('new ratio');
  // oldRatio.prm('old ratio');
  String ratioCountKey = "${AppStrings.RATIO_COUNTER}_$ratioCacheKey";
  int ratioCount = sl<SharedPreferences>().getInt(ratioCountKey) ?? 0;
  if (ratio == 0.01) {
    ratioCount++;
    sl<SharedPreferences>().setInt(ratioCountKey, ratioCount);
    if (oldRatio != 0.01 && ratioCount > 5) {
      sl<SharedPreferences>().setDouble(ratioCacheKey, 0.01);
      sl<SharedPreferences>().setInt(ratioCountKey, 0);
    }
    return 0.01;
  }

  // "Hello World 2".prm('handleGraphRatio');
  if (oldRatio == ratio) {
    // "Hello World 3".prm('handleGraphRatio');
    return ratio;
  } else if (oldRatio > ratio) {
    // "Hello World 4".prm('handleGraphRatio');
    sl<SharedPreferences>().setDouble(ratioCacheKey, ratio);
    return ratio;
  } else {
    oldRatio += 0.001;
    // "Hello World 5".prm('handleGraphRatio');
    // oldRatio.prm('handleGraphRatio');
    sl<SharedPreferences>().setDouble(ratioCacheKey, oldRatio);
    return oldRatio;
  }
}
