import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    super.key,
    required this.buttonTitle,
    this.width,
  });
  final String buttonTitle;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Clr.iconGoldColor),
      ),
      child: Center(
        child: Txt.displayMeduim(buttonTitle),
      ),
    );
  }
}
