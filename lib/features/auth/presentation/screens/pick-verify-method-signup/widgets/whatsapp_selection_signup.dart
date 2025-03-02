import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WhatsappSelectionSignup extends StatelessWidget {
  const WhatsappSelectionSignup({
    super.key,
    required this.controller,
  });

  final SignupCubit controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return current is PickVerificationMethodState ? true : false;
      },
      builder: (context, state) {
        context.watch<PickLanguageAndThemeCubit>();
        return CheckboxListTile(
          activeColor: Clr.d,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                FontAwesome.whatsapp,
                size: 30.w,
                color: controller.isVerificationMethodEmail ? null : Clr.d,
              ),
              SizedBox(width: 10.w),
              Txt.bodyMeduim(
                'Whatsapp',
                size: 20.w,
                color: controller.isVerificationMethodEmail ? null : Clr.d,
              ),
            ],
          ),
          value: !controller.isVerificationMethodEmail,
          onChanged: (value) {
            controller.isVerificationMethodEmail = !(value!);
            controller.pickVerficationMethod(isEmail: !value);
          },
        );
      },
    );
  }
}
