import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.title,
    required this.icon,
    this.width,
  });
  final String title;
  final IconData icon;
  final double? width;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          style: BorderStyle.solid,
          color: Clr.f,
        ),
      ),
      child: SizedBox(
        width: width ?? 120.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Txt.bodyMeduim(title, color: Clr.f),
            Icon(icon, color: Clr.f, size: 25.w),
          ],
        ),
      ),
    );
  }
}
