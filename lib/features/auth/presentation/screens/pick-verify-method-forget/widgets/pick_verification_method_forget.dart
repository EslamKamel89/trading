import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/text_styles/text_style.dart';

List<Widget> pickVerifyMethodForgetMessage(BuildContext context) {
  return [
    Txt.headlineMeduim(
      "PICK_VERIFY_METHOD_FORGET".tr(context),
      showFullText: true,
    ),
    SizedBox(height: 5.h),
    Txt.displayMeduim("RECIEVE_OTP_ANY_WAY_FORGET".tr(context)),
    SizedBox(height: 15.h),
  ];
}
