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
import 'package:trading/features/auth/presentation/screens/pick-verify-method-forget/widgets/email_selection_forget.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-forget/widgets/pick_verification_method_forget.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-forget/widgets/whatsappo_selection_forget.dart';

class PickVerifyMetodFroget extends StatefulWidget {
  const PickVerifyMetodFroget({super.key, required this.mobileOrEmailValue});
  final String mobileOrEmailValue;

  @override
  State<PickVerifyMetodFroget> createState() => _PickVerifyMetodFrogetState();
}

class _PickVerifyMetodFrogetState extends State<PickVerifyMetodFroget> {
  late SigninCubit controller;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller = context.read<SigninCubit>();
    controller.initPickVerifyMethod();
    controller.emailOrMobileVerifyMethodCont!.text = widget.mobileOrEmailValue;
    super.initState();
  }

  @override
  void dispose() {
    controller.disposePickVerifyMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: authAppBar(title: 'FORGET_PASSWORD'.tr(context), context: context),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        endDrawer: const AuthDrawer(),
        body: BodyWidget(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ...pickVerifyMethodForgetMessage(context),
                EmailSelectionForget(controller: controller),
                WhatsappSelectionForget(controller: controller),
                SizedBox(height: 10.h),
                BlocBuilder<SigninCubit, SigninState>(
                  buildWhen: (previous, current) => current is PickResetPasswordMethodState ? true : false,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Txt.displayMeduim(
                          controller.isResetPasswordMethodEmail
                              ? "ENTER_EMAIL_SEND_OTP".tr(context)
                              : "ENTER_MOBILE_HAVE_WHATSAPP".tr(context),
                        ),
                        SizedBox(height: 15.h),
                        AuthTextField(
                          label: controller.isResetPasswordMethodEmail ? "EMAIL".tr(context) : "MOBILE".tr(context),
                          hint: "",
                          suffixIcon: controller.isResetPasswordMethodEmail ? Icons.email : Icons.mobile_friendly,
                          isMobile: !controller.isResetPasswordMethodEmail,
                          controller: controller.emailOrMobileVerifyMethodCont,
                          validator: (value) {
                            return pickVerifyMethodForgetValidator(value: value!);
                          },
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                AuthButton(
                  buttonTitle: "SEND_OTP".tr(context),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pushNamed(AppRoutesNames.otpForget);
                    }
                  },
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? pickVerifyMethodForgetValidator({
    required String value,
    int minLength = 5,
    int maxLength = 20,
    bool? isEmailOrMobile = true,
    bool? isPassword,
  }) {
    if (isEmailOrMobile == true) {
      if (value.isEmpty) {
        return "FIELD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      }
    }
    return null;
  }
}
