import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';

class CustomOTP extends StatelessWidget {
  const CustomOTP({
    super.key,
    required this.numberOfFields,
    required this.onSubmit,
  });
  final int numberOfFields;
  final void Function(String) onSubmit;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
          numberOfFields: 5,
          borderRadius: BorderRadius.circular(20),
          fieldWidth: 50.w,
          textStyle: TextStyle(fontSize: 16.sp),
          enabledBorderColor: Theme.of(context).dividerColor,
          borderColor: Clr.iconGoldColor,
          focusedBorderColor: Clr.iconGoldColor,
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: onSubmit),
    );
  }
}
