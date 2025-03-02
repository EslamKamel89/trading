import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });
  final String buttonTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          width: 300.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Clr.d,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Center(
            child: Txt.bodyMeduim(
              buttonTitle,
              color: Clr.c,
            ),
          ),
        ),
      ),
    );
  }
}
