import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/exit-app-warning/exit_app_warining.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_text_field.dart';
import 'package:trading/features/auth/presentation/screens/singin/widgets/dont_have_an_account.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  late SigninCubit controller;
  @override
  void initState() {
    controller = context.read<SigninCubit>();
    controller.initSignin();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeSignin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.initSignin();
    // SharedPreferences sharedPreferences = sl();
    // sharedPreferences.clear();
    // sl<AuthRepo>().getUserData(userId: 17);
    // sl<AuthRepo>().signin(userName: 'eslam@gmail.com', password: '123456');
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        exitAppAlert(context);
      },
      child: ScaffoldGradientBackgroudAuth(
        child: Scaffold(
          appBar: authAppBar(
            title: 'Sign In',
            context: context,
            automaticallyImplyLeading: false,
          ),
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          endDrawer: const AuthDrawer(),
          body: BlocListener<SigninCubit, SigninState>(
            listener: (context, state) {
              if (state is SigninFailureState) {
                customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
              } else if (state is SigninSuccessState) {
                customSnackBar(context: context, title: 'Sign in completed successfuly');
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => false);
              }
            },
            child: BodyWidget(
                verticalPadding: 0,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // SizedBox(height: 10.h),
                        Image.asset(
                          AppImages.moneymakerLogo,
                          height: 275.h,
                          fit: BoxFit.fill,
                        ),
                        // SizedBox(height: 20.h),
                        AuthTextField(
                          label: "EMAIL_MOBILE".tr(context),
                          hint: "ENTER_EMAIL_MOBILE".tr(context),
                          suffixIcon: Octicons.person,
                          controller: controller.emailOrMobileCont,
                          validator: (value) {
                            return signinValidator(
                              value: value!,
                              minLength: 5,
                              maxLength: 20,
                              isEmailOrMobile: true,
                            );
                          },
                        ),
                        SizedBox(height: 5.h),
                        AuthTextField(
                          label: "PASSWORD".tr(context),
                          hint: "ENTER_YOUR_PASSWORD".tr(context),
                          suffixIcon: Icons.remove_red_eye_outlined,
                          allowObsecure: true,
                          controller: controller.passwordCont,
                          validator: (value) {
                            return signinValidator(
                              value: value!,
                              isPassword: true,
                            );
                          },
                        ),
                        // SizedBox(height: 5.h),
                        // Align(
                        //   alignment: context.read<PickLanguageAndThemeCubit>().isEnglishLanguage()
                        //       ? Alignment.topRight
                        //       : Alignment.topLeft,
                        //   child: const ForgetPasswordButton(),
                        // ),
                        SizedBox(height: 40.h),
                        const DontHaveAnAccountWidget(),
                        SizedBox(height: 20.h),
                        BlocBuilder<SigninCubit, SigninState>(
                          builder: (context, state) {
                            return state is SigninLoadingState
                                ? const CircularProgressIndicator()
                                : AuthButton(
                                    buttonTitle: "Sign In",
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        await controller.signIn();
                                      }
                                    },
                                  );
                          },
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  String? signinValidator({
    required String value,
    int minLength = 5,
    int maxLength = 20,
    bool? isEmailOrMobile,
    bool? isPassword,
  }) {
    if (isEmailOrMobile == true) {
      if (value.isEmpty) {
        return "FIELD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      }
    } else if (isPassword == true) {
      if (value.isEmpty) {
        return "PASSWORD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      }
    }
    return null;
  }
}
