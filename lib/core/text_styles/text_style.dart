import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class Txt {
  static Text headlineMeduim(
    String text, {
    Color? color,
    double? size,
    TextOverflow? overFlow = TextOverflow.ellipsis,
    bool showFullText = false,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
// max lines is essential so the overFlow proberity works
      maxLines: showFullText ? null : 1,
      style: TextStyle(
        fontSize: size ?? 20.sp,
        overflow: showFullText ? null : overFlow,
        color: color ?? (sl<PickLanguageAndThemeCubit>().isLightTheme() ? Colors.black : Colors.white),
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
      textAlign: textAlign,
    );
  }

  static Text bodyMeduim(
    String text, {
    Color? color,
    double? size,
    TextOverflow overFlow = TextOverflow.ellipsis,
    bool showFullText = true,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16.sp,
        overflow: showFullText ? null : overFlow,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text displayMeduim(
    String text, {
    Color? color,
    double? size,
    TextOverflow? overFlow,
    bool showFullText = true,
    double? height,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      maxLines: showFullText ? null : 1,
      style: TextStyle(
        fontSize: size ?? 14.sp,
        overflow: overFlow,
        color: color,
        height: height ?? 1.2,
      ),
      textAlign: textAlign,
    );
  }
}
