import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late SigninCubit controller;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller = context.read<SigninCubit>();
    controller.initResetPassord();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeResetPassord();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: authAppBar(title: "RESET_PASSWORD".tr(context), context: context),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        endDrawer: const AuthDrawer(),
        body: BodyWidget(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Txt.bodyMeduim("ENTER_NEW_PASSWORD".tr(context)),
                SizedBox(height: 10.h),
                AuthTextField(
                  label: "PASSWORD".tr(context),
                  hint: "ENTER_YOUR_PASSWORD".tr(context),
                  suffixIcon: Icons.remove_red_eye_outlined,
                  allowObsecure: true,
                  controller: controller.resetPasswordOneCont,
                  validator: (value) {
                    return resetPasswordValidator(
                      context: context,
                      value: value!,
                      isPassword: true,
                      anotherPass: controller.resetPasswordTwoCont!.text,
                    );
                  },
                ),
                AuthTextField(
                  label: "PASSWORD CONFIRMATION".tr(context),
                  hint: "RE_ENTER_PASSWORD".tr(context),
                  suffixIcon: Icons.remove_red_eye_outlined,
                  allowObsecure: true,
                  controller: controller.resetPasswordTwoCont,
                  validator: (value) {
                    return resetPasswordValidator(
                      context: context,
                      value: value!,
                      isPassword: true,
                      anotherPass: controller.resetPasswordOneCont!.text,
                    );
                  },
                ),
                const Spacer(),
                Center(
                  child: AuthButton(
                    buttonTitle: "SAVE".tr(context),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.signin, (route) => true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? resetPasswordValidator({
    required BuildContext context,
    required String value,
    int minLength = 5,
    int maxLength = 20,
    bool? isEmail,
    bool? isPassword,
    String? anotherPass,
  }) {
    if (isPassword == true) {
      if (value.isEmpty) {
        return "PASSWORD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength || value.length > maxLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      } else if (value != anotherPass) {
        return "PASSWORD_DONT_MATCH".tr(context);
      }
    }
    return null;
  }
}
