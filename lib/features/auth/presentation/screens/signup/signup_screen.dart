import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/crud/status_request.dart';
import 'package:trading/core/handling-http-requests-view/handling_data_view.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/scaffold_gradient_color.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_text_field.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/gender_selection.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/pick_user_image.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/terms_and_conditions_check.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/upload_document_status.dart';
import 'package:trading/features/auth/presentation/screens/signup/widgets/upload_passport_photo.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class SingnupScreen extends StatefulWidget {
  const SingnupScreen({super.key});
  static String genderValue = "male";
  static bool approveTerms = false;

  @override
  State<SingnupScreen> createState() => _SingnupScreenState();
}

class _SingnupScreenState extends State<SingnupScreen> {
  late SignupCubit controller;
  @override
  void initState() {
    controller = context.read<SignupCubit>();
    controller.initSignUp();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeSignUp();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackgroudAuth(
      child: Scaffold(
        appBar: authAppBar(title: 'SINGN_UP'.tr(context), context: context),
        backgroundColor: Colors.transparent,
        endDrawer: const AuthDrawer(),
        key: scaffoldKey,
        body: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupFailureState) {
              customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
            } else if (state is SignupSuccessState) {
              customSnackBar(context: context, title: 'Sign up completed successfuly');
              Navigator.of(context).pushNamed(AppRoutesNames.signin);
            }
          },
          child: HandlingDataView(
            statusRequest: StatusRequest.success,
            child: BodyWidget(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PickImageWidget(scaffoldKey: scaffoldKey),
                      SizedBox(height: 15.h),
                      AuthTextField(
                        label: "FULL_NAME_IN_ENGLISH".tr(context),
                        hint: "",
                        suffixIcon: Icons.language,
                        controller: controller.signUpFullNameCont,
                        validator: (value) {
                          return signupValidator(value: value!, minLength: 10, maxLength: 40);
                        },
                      ),
                      // AuthTextField(
                      //     label: "FULL_NAME_IN_ARABIC".tr(context),
                      //     hint: "",
                      //     suffixIcon: Icons.person,
                      //     controller: controller.signUpFullNameArbCont,
                      //     validator: (value) {
                      //       return signupValidator(value: value!, minLength: 10, maxLength: 40);
                      //     }),
                      GenderSelection(
                        label: "GENDER".tr(context),
                        genderValue: SingnupScreen.genderValue,
                      ),
                      AuthTextField(
                        label: "USERNAME".tr(context),
                        hint: "",
                        suffixIcon: Icons.person_pin_rounded,
                        controller: controller.signUpUserNameCont,
                        validator: (value) {
                          return signupValidator(value: value!, minLength: 3, maxLength: 15);
                        },
                      ),
                      // AuthTextField(
                      //   label: "PASSPORT_NO".tr(context),
                      //   hint: "",
                      //   suffixIcon: Icons.info_rounded,
                      //   controller: controller.signUpIdNumberCont,
                      //   validator: (value) {
                      //     return signupValidator(value: value!, minLength: 10, maxLength: 30);
                      //   },
                      // ),
                      AuthTextField(
                        label: "MOBILE".tr(context),
                        hint: "",
                        suffixIcon: Icons.mobile_friendly_sharp,
                        controller: controller.signUpMobileCont,
                        isMobile: true,
                        validator: (value) {
                          return signupValidator(value: value!, minLength: 6, maxLength: 20);
                        },
                        countryCodeCallback: (CountryCode countryCode) {
                          controller.countryMobileCode = countryCode.dialCode;
                        },
                      ),
                      AuthTextField(
                        label: "EMAIL".tr(context),
                        hint: "",
                        suffixIcon: Icons.email,
                        controller: controller.signUpEmailCont,
                        validator: (value) {
                          return signupValidator(value: value!, isEmail: true);
                        },
                        countryCodeCallback: (countryCode) {
                          controller.countryMobileCode = countryCode.code;
                        },
                      ),
                      AuthTextField(
                        label: "PASSWORD".tr(context),
                        hint: "ENTER_YOUR_PASSWORD".tr(context),
                        suffixIcon: Icons.remove_red_eye_outlined,
                        allowObsecure: true,
                        controller: controller.signUpPassOneCont,
                        validator: (value) {
                          return signupValidator(
                              value: value!, isPassword: true, anotherPass: controller.signUpPassTwoCont!.text);
                        },
                      ),
                      AuthTextField(
                        label: "PASSWORD CONFIRMATION".tr(context),
                        hint: "RE_ENTER_PASSWORD".tr(context),
                        suffixIcon: Icons.remove_red_eye_outlined,
                        allowObsecure: true,
                        controller: controller.signUpPassTwoCont,
                        validator: (value) {
                          return signupValidator(
                              value: value!, isPassword: true, anotherPass: controller.signUpPassOneCont!.text);
                        },
                      ),
                      const Divider(),
                      UploadPassportPhoto(scaffoldKey: scaffoldKey),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: context.read<PickLanguageAndThemeCubit>().isEnglishLanguage()
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: const UploadPassportStatus(),
                      ),
                      const Divider(),
                      ...termsAndConditionsCheck(context),
                      const Divider(),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return state is SignupLoadingState
                              ? const CircularProgressIndicator()
                              : AuthButton(
                                  buttonTitle: "CREATE_ACCOUNT".tr(context),
                                  onTap: () async {
                                    if (formKey.currentState!.validate() &&
                                        SingnupScreen.approveTerms &&
                                        controller.uploadIdDocumentFileOne != null) {
                                      await controller.signup();
                                    }
                                    if (!SingnupScreen.approveTerms) {
                                      customSnackBar(
                                        context: context,
                                        title: "TERMS_CONDITIONS".tr(context),
                                        isSuccess: false,
                                      );
                                    }
                                    if (controller.uploadIdDocumentFileOne == null) {
                                      customSnackBar(
                                        context: context,
                                        title: "UPLOAD_PASSPORT_WARINING".tr(context),
                                        isSuccess: false,
                                      );
                                    }
                                    if (!controller.isUploadPassport && controller.uploadIdDocumentFileTwo == null) {
                                      customSnackBar(
                                        context: context,
                                        title: "UPLOAD_TWO_PHOTO".tr(context),
                                        isSuccess: false,
                                      );
                                    }
                                  },
                                );
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(AppRoutesNames.pickLanguage);
        //   },
        //   child: const Icon(Icons.settings),
        // ),
      ),
    );
  }

  String? signupValidator({
    required String value,
    int minLength = 5,
    int maxLength = 20,
    bool? isEmail,
    bool? isPassword,
    String? anotherPass,
  }) {
    final regExpEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (isEmail != null && isEmail == true) {
      if (value.isEmpty) {
        return "EMAIL_CANT_BE_EMBTY".tr(context);
      } else if (!regExpEmail.hasMatch(value)) {
        return "EMAIL_NOT_VALID".tr(context);
      }
    } else if (isPassword != null && isPassword == true) {
      if (value.isEmpty) {
        return "PASSWORD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      } else if (value != anotherPass) {
        return "PASSWORD_DONT_MATCH".tr(context);
      }
    } else {
      if (value.isEmpty) {
        return "FIELD_CANT_EMPTY".tr(context);
      } else if (value.length < minLength) {
        return '${"CARACTERS_BETWEEN".tr(context)} ($minLength , $maxLength) ${"CHARACTERS".tr(context)}';
      }
    }
    return null;
  }
}
