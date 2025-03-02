import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/domain/repo/auth_repo_abstract.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRepoInterface authRepo;
  SignupCubit({required this.authRepo}) : super(AuthInitial());

  TextEditingController? signUpFullNameCont;
  TextEditingController? signUpFullNameArbCont;
  TextEditingController? signUpUserNameCont;
  TextEditingController? signUpIdNumberCont;
  TextEditingController? signUpMobileCont;
  TextEditingController? signUpEmailCont;
  TextEditingController? signUpPassOneCont;
  TextEditingController? signUpPassTwoCont;
  String? countryMobileCode;

  XFile? uploadImageXFile;
  XFile? uploadIdDoucmentXFileOne;
  XFile? uploadIdDoucmentXFileTwo;
  File? uploadImageFile;
  File? uploadIdDocumentFileOne;
  File? uploadIdDocumentFileTwo;

  bool isVerificationMethodEmail = true;
  bool isUploadPassport = true;
  bool isMale = true;

  initSignUp() {
    signUpFullNameCont = TextEditingController();
    signUpFullNameArbCont = TextEditingController();
    signUpUserNameCont = TextEditingController();
    signUpIdNumberCont = TextEditingController();
    signUpMobileCont = TextEditingController();
    signUpEmailCont = TextEditingController();
    signUpPassOneCont = TextEditingController();
    signUpPassTwoCont = TextEditingController();
  }

  disposeSignUp() {
    signUpFullNameCont!.dispose();
    signUpFullNameArbCont!.dispose();
    signUpUserNameCont!.dispose();
    signUpIdNumberCont!.dispose();
    signUpMobileCont!.dispose();
    signUpEmailCont!.dispose();
    signUpPassOneCont!.dispose();
    signUpPassTwoCont!.dispose();
  }

  void updateUserImage() {
    emit(UpdateUserImageState());
  }

  void updateDocumentImage() {
    emit(UpdateDoucumentImageState());
  }

  void pickVerficationMethod({required bool isEmail}) {
    emit(PickVerificationMethodState(isEmail: isEmail));
  }

  void otpSignup({required String otp}) {
    emit(OtpSignupState(otp: otp));
  }

  Future signup() async {
    if (isClosed) {
      return;
    }
    emit(SignupLoadingState());
    String mobileNum = signUpMobileCont!.text;
    if (mobileNum[0] == "0") {
      mobileNum = mobileNum.substring(1);
    }
    mobileNum = "${countryMobileCode ?? '+20'}$mobileNum";
    mobileNum.prm("mobile number in signupCubit - signup");
    final response = await authRepo.signup(
      userName: signUpUserNameCont!.text,
      fullName: signUpFullNameCont!.text,
      gender: isMale ? 'male' : 'female',
      email: signUpEmailCont!.text,
      mobile: mobileNum,
      password: signUpPassOneCont!.text,
      profileXFile: uploadImageXFile,
      passportXFile: uploadIdDoucmentXFileOne!,
      passportBackXFile: uploadIdDoucmentXFileTwo,
    );
    response.fold(
      (errorModel) {
        emit(
          SignupFailureState(
              errorMessage: sl<PickLanguageAndThemeCubit>().isEnglishLanguage()
                  ? errorModel.errorMessageEn ?? 'Unknown Error'
                  : errorModel.errorMessageAr ?? 'خطأ غير معروف'),
        );
      },
      (userModel) {
        emit(SignupSuccessState());
      },
    );
  }
}
