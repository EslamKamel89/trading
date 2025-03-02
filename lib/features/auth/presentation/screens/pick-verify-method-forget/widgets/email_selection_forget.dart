import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';

class EmailSelectionForget extends StatelessWidget {
  const EmailSelectionForget({
    super.key,
    required this.controller,
  });

  final SigninCubit controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) {
        return current is PickResetPasswordMethodState ? true : false;
      },
      builder: (context, state) {
        return CheckboxListTile(
          activeColor: Clr.d,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.email_outlined,
                size: 30.w,
                color: controller.isResetPasswordMethodEmail ? Clr.d : null,
              ),
              SizedBox(width: 10.w),
              Txt.bodyMeduim(
                'Email',
                size: 20.w,
                color: controller.isResetPasswordMethodEmail ? Clr.d : null,
              ),
            ],
          ),
          value: controller.isResetPasswordMethodEmail,
          onChanged: (value) {
            controller.isResetPasswordMethodEmail = value!;
            controller.pickResetPasswordMethod(isEmail: value);
          },
        );
      },
    );
  }
}
