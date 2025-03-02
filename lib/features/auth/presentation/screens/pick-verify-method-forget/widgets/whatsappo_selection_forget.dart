import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WhatsappSelectionForget extends StatelessWidget {
  const WhatsappSelectionForget({
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
        final themeController = context.watch<PickLanguageAndThemeCubit>();
        return CheckboxListTile(
          activeColor: Clr.d,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                FontAwesome.whatsapp,
                size: 30.w,
                color: controller.isResetPasswordMethodEmail ? null : Clr.d,
              ),
              SizedBox(width: 10.w),
              Txt.bodyMeduim(
                'Whatsapp',
                size: 20.w,
                color: controller.isResetPasswordMethodEmail ? null : Clr.d,
              ),
            ],
          ),
          value: !controller.isResetPasswordMethodEmail,
          onChanged: (value) {
            controller.isResetPasswordMethodEmail = !(value!);
            controller.pickResetPasswordMethod(isEmail: !value);
          },
        );
      },
    );
  }
}
