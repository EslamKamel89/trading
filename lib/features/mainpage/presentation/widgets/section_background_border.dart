import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class SectionBackgroundAndBorder extends StatelessWidget {
  const SectionBackgroundAndBorder({super.key, required this.child, this.height});
  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Container(
      width: 350.w,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      decoration: BoxDecoration(
        border: Border.all(color: Clr.a, width: 2.w),
        borderRadius: BorderRadius.circular(20.w),
        color: Clr.a.withOpacity(0.5),
      ),
      child: child,
    );
  }
}
