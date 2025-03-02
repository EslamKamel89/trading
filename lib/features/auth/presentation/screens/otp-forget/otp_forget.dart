import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/otp.dart';

class OtpForgetScreen extends StatelessWidget {
  const OtpForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SigninCubit controller = context.read<SigninCubit>();
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: authAppBar(title: "OTP", context: context),
        backgroundColor: Colors.transparent,
        endDrawer: const AuthDrawer(),
        resizeToAvoidBottomInset: false,
        body: BodyWidget(
          child: Column(
            children: [
              Image.asset(
                AppImages.otp,
                // width: 250.w,
                height: 250.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              Txt.bodyMeduim("ENTER_OTP".tr(context)),
              SizedBox(height: 10.h),
              CustomOTP(
                numberOfFields: 6,
                onSubmit: (value) {
                  controller.otpForget(otp: value);
                },
              ),
              const Spacer(),
              BlocBuilder<SigninCubit, SigninState>(
                buildWhen: (previous, current) {
                  return current is OtpForgetState ? true : false;
                },
                builder: (context, state) {
                  if (state is OtpForgetState) {
                    return AuthButton(
                      buttonTitle: "CONTINUE".tr(context),
                      onTap: () {
                        state.otp.prm("OTP Forget");
                        Navigator.of(context).pushNamed(AppRoutesNames.resetPassword);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
