import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';

class DecoratedContainerUserProfile extends StatelessWidget {
  const DecoratedContainerUserProfile({super.key, required this.child, this.verticalMargin});
  final Widget child;
  final double? verticalMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: verticalMargin ?? 0),
      decoration: BoxDecoration(
        border: Border.all(color: Clr.f, width: 1.w),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: child,
    );
  }
}
