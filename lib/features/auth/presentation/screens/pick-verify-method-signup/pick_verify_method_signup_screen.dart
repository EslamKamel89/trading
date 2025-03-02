import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-signup/widgets/email_selection_signup.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-signup/widgets/pick_verify_method_message.dart';
import 'package:trading/features/auth/presentation/screens/pick-verify-method-signup/widgets/whatsapp_selection_signup.dart';

class PickVerifyMehodSignupScreen extends StatelessWidget {
  const PickVerifyMehodSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupCubit controller = context.read<SignupCubit>();
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: authAppBar(title: 'Verification Method', context: context),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        endDrawer: const AuthDrawer(),
        body: BodyWidget(
          child: Column(
            children: [
              ...pickVerifyMethodSignupMessage(context),
              EmailSelectionSignup(controller: controller),
              WhatsappSelectionSignup(controller: controller),
              const Spacer(),
              AuthButton(
                buttonTitle: "SEND_OTP".tr(context),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutesNames.otpSignup);
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
