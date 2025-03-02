import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    SigninCubit controller = context.read<SigninCubit>();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutesNames.pickVerificationMethodForget,
          arguments: {"mobileOrEmailValue": controller.emailOrMobileCont?.text ?? ""},
        );
      },
      child: Txt.bodyMeduim('FORGET_PASSWORD'.tr(context)),
    );
  }
}
