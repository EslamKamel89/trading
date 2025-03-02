// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_text_field.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/gender_selection.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/pick_image_referrals_widget.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/terms_and_conditions_check_refferals.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/upload_passport_photo_referrals_screen.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/upload_passport_status_referals.dart';

class AddReferralsScreen extends StatefulWidget {
  const AddReferralsScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<AddReferralsScreen> createState() => _AddReferralsScreenState();
}

class _AddReferralsScreenState extends State<AddReferralsScreen> {
  TextEditingController? signUpFullNameCont;
  TextEditingController? signUpUserNameCont;
  TextEditingController? signUpIdNumberCont;
  TextEditingController? signUpMobileCont;
  TextEditingController? signUpEmailCont;
  TextEditingController? signUpPassOneCont;
  TextEditingController? signUpPassTwoCont;
  late AddReferralsCubit controller;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey();
    controller = context.read<AddReferralsCubit>();
    signUpFullNameCont = TextEditingController();
    signUpUserNameCont = TextEditingController();
    signUpIdNumberCont = TextEditingController();
    signUpMobileCont = TextEditingController();
    signUpEmailCont = TextEditingController();
    signUpPassOneCont = TextEditingController();
    signUpPassTwoCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    signUpFullNameCont!.dispose();
    signUpUserNameCont!.dispose();
    signUpIdNumberCont!.dispose();
    signUpMobileCont!.dispose();
    signUpEmailCont!.dispose();
    signUpPassOneCont!.dispose();
    signUpPassTwoCont!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddRefferalsWidget(
      signUpFullNameCont: signUpFullNameCont,
      signUpUserNameCont: signUpUserNameCont,
      signUpIdNumberCont: signUpIdNumberCont,
      signUpMobileCont: signUpMobileCont,
      signUpEmailCont: signUpEmailCont,
      signUpPassOneCont: signUpPassOneCont,
      signUpPassTwoCont: signUpPassTwoCont,
      scaffoldKey: widget.scaffoldKey,
      formKey: formKey,
    );
  }
}

class AddRefferalsWidget extends StatelessWidget {
  const AddRefferalsWidget({
    super.key,
    required this.signUpFullNameCont,
    required this.signUpUserNameCont,
    required this.signUpIdNumberCont,
    required this.signUpMobileCont,
    required this.signUpEmailCont,
    required this.signUpPassOneCont,
    required this.signUpPassTwoCont,
    required this.scaffoldKey,
    required this.formKey,
  });
  final TextEditingController? signUpFullNameCont;
  final TextEditingController? signUpUserNameCont;
  final TextEditingController? signUpIdNumberCont;
  final TextEditingController? signUpMobileCont;
  final TextEditingController? signUpEmailCont;
  final TextEditingController? signUpPassOneCont;
  final TextEditingController? signUpPassTwoCont;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    String countryCodeNum = "+20";
    AddReferralsCubit controller = context.read<AddReferralsCubit>();
    return BlocListener<AddReferralsCubit, AddReferralsState>(
      listener: (context, state) {
        if (state is AddReferralFailureState) {
          customSnackBar(context: context, title: state.errorMessage, isSuccess: false);
        } else if (state is AddReferralSuccessState) {
          customSnackBar(context: context, title: 'Add Referrals Completed successfully');
          Navigator.of(context).pushNamed(AppRoutesNames.bottomNavigationScreen);
        }
      },
      child: Form(
        key: formKey,
        child: SizedBox(
          child: ListView(
            children: [
              SizedBox(height: 20.h),
              AuthButton(
                  buttonTitle: "COPY_WEB_LINK".tr(context),
                  onTap: () async {
                    int currentUserId = (await sl<AuthRepo>().getChacedUserData())?.id ?? 0;
                    await Clipboard.setData(ClipboardData(text: "${EndPoint.referralWebLink}$currentUserId"));
                  }),
              SizedBox(height: 20.h),
              Center(
                child: PickImageReferralsWidget(
                  controller: controller,
                  scaffoldKey: scaffoldKey,
                ),
              ),
              SizedBox(height: 15.h),
              AuthTextField(
                label: "FULL_NAME_IN_ENGLISH".tr(context),
                hint: "",
                suffixIcon: Icons.language,
                controller: signUpFullNameCont,
                validator: (value) {
                  return _refferalsValidator(context: context, value: value!, minLength: 10, maxLength: 40);
                },
              ),
              GenderSelection(
                label: "GENDER".tr(context),
                genderValue: 'male',
              ),
              AuthTextField(
                label: "USERNAME".tr(context),
                hint: "",
                suffixIcon: Icons.person_pin_rounded,
                controller: signUpUserNameCont,
                validator: (value) {
                  return _refferalsValidator(context: context, value: value!, minLength: 3, maxLength: 15);
                },
              ),
              AuthTextField(
                label: "MOBILE".tr(context),
                hint: "",
                suffixIcon: Icons.mobile_friendly_sharp,
                controller: signUpMobileCont,
                isMobile: true,
                validator: (value) {
                  return _refferalsValidator(context: context, value: value!, minLength: 6, maxLength: 20);
                },
                countryCodeCallback: (countryCode) {
                  countryCodeNum = countryCode.code ?? "+20";
                },
              ),
              AuthTextField(
                label: "EMAIL".tr(context),
                hint: "",
                suffixIcon: Icons.email,
                controller: signUpEmailCont,
                validator: (value) {
                  return _refferalsValidator(context: context, value: value!, isEmail: true);
                },
              ),
              AuthTextField(
                label: "PASSWORD".tr(context),
                hint: "ENTER_YOUR_PASSWORD".tr(context),
                suffixIcon: Icons.remove_red_eye_outlined,
                allowObsecure: true,
                controller: signUpPassOneCont,
                validator: (value) {
                  return _refferalsValidator(
                      context: context, value: value!, isPassword: true, anotherPass: signUpPassTwoCont!.text);
                },
              ),
              AuthTextField(
                label: "PASSWORD CONFIRMATION".tr(context),
                hint: "RE_ENTER_PASSWORD".tr(context),
                suffixIcon: Icons.remove_red_eye_outlined,
                allowObsecure: true,
                controller: signUpPassTwoCont,
                validator: (value) {
                  return _refferalsValidator(
                      context: context, value: value!, isPassword: true, anotherPass: signUpPassOneCont!.text);
                },
              ),
              const Divider(),
              SizedBox(height: 10.h),
              UploadPassportPhotoReferrals(
                scaffoldKey: scaffoldKey,
                controller: controller,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: UploadPassportStatusReferals(),
              ),
              SizedBox(height: 10.h),
              const Divider(),
              SizedBox(height: 10.h),
              ...termsAndConditionsCheckRefferals(context, controller),
              const Divider(),
              SizedBox(height: 10.h),
              BlocBuilder<AddReferralsCubit, AddReferralsState>(
                builder: (context, state) {
                  if (state is AddReferralLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(
                    buttonTitle: "CREATE_ACCOUNT".tr(context),
                    onTap: () async {
                      if (!controller.isTermsApproved) {
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
                      if (formKey.currentState!.validate() &&
                          controller.isTermsApproved &&
                          controller.uploadIdDocumentFileOne != null) {
                        String mobileNum = signUpMobileCont!.text;
                        if (mobileNum[0] == "0") {
                          mobileNum = mobileNum.substring(1);
                        }
                        mobileNum = "$countryCodeNum$mobileNum";
                        mobileNum.prm("mobile number in AddRefferals");
                        await controller.addRefferal(
                          userName: signUpUserNameCont?.text ?? '',
                          fullName: signUpFullNameCont?.text ?? '',
                          email: signUpEmailCont?.text ?? '',
                          mobile: mobileNum,
                          password: signUpPassOneCont?.text ?? '',
                          profileXFile: controller.uploadImageXFile,
                          passportXFile: controller.uploadIdDoucmentXFileOne!,
                          passportBackXFile: controller.uploadIdDoucmentXFileTwo,
                        );
                        controller.uploadIdDocumentFileOne = null;
                        controller.uploadIdDocumentFileTwo = null;
                        controller.uploadIdDoucmentXFileOne = null;
                        controller.uploadIdDoucmentXFileTwo = null;
                        controller.uploadImageFile = null;
                        controller.uploadImageXFile = null;
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  String? _refferalsValidator({
    required BuildContext context,
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
