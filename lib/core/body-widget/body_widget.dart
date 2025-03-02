import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key, required this.child, this.verticalPadding});
  final Widget child;
  final double? verticalPadding;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: verticalPadding ?? 10.h),
        child: child,
      ),
    );
  }
}
