import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/auth/domain/repo/auth_repo_abstract.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

part 'singin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  AuthRepoInterface authRepo;
  SigninCubit({required this.authRepo}) : super(SinginInitial());

  TextEditingController? emailOrMobileCont;
  TextEditingController? passwordCont;

  TextEditingController? resetPasswordOneCont;
  TextEditingController? resetPasswordTwoCont;

  TextEditingController? emailOrMobileVerifyMethodCont;

  bool isResetPasswordMethodEmail = true;

  UserModel? userModel;
  int? userId;

  initSignin() {
    emailOrMobileCont = TextEditingController();
    passwordCont = TextEditingController();
  }

  disposeSignin() async {
    // return null;
    // emailOrMobileCont!.dispose();
    // passwordCont!.dispose();
  }

  initResetPassord() {
    resetPasswordOneCont = TextEditingController();
    resetPasswordTwoCont = TextEditingController();
  }

  disposeResetPassord() async {
    // return null;
    resetPasswordOneCont!.dispose();
    resetPasswordTwoCont!.dispose();
  }

  initPickVerifyMethod() {
    emailOrMobileVerifyMethodCont = TextEditingController();
  }

  disposePickVerifyMethod() {
    emailOrMobileVerifyMethodCont!.dispose();
  }

  void pickResetPasswordMethod({required bool isEmail}) {
    if (isClosed) {
      return;
    }
    emit(PickResetPasswordMethodState(isEmail: isEmail));
  }

  void otpForget({required String otp}) {
    if (isClosed) {
      return;
    }
    emit(OtpForgetState(otp: otp));
  }

  signIn() async {
    if (isClosed) {
      return null;
    }
    emit(SigninLoadingState());
    final response = await authRepo.signin(
      userName: emailOrMobileCont?.text ?? '',
      password: passwordCont?.text ?? '',
    );
    response.fold(
      (errorModel) {
        emit(
          SigninFailureState(
              errorMessage: sl<PickLanguageAndThemeCubit>().isEnglishLanguage()
                  ? errorModel.errorMessageEn ?? 'Unknown Error'
                  : errorModel.errorMessageAr ?? 'خطأ غير معروف'),
        );
      },
      (signinModel) async {
        userId = signinModel.userId;
        await getUserData();
        emit(SigninSuccessState());
      },
    );
  }

  Future<UserModel?> getUserData() async {
    if (isClosed) {
      return null;
    }
    final response = await authRepo.getUserData(userId: userId ?? 0);
    return response.fold(
      (errorModel) {
        return null;
      },
      (user) async {
        await authRepo.cacheUserData(user);
        userModel = (await authRepo.getChacedUserData())!;
        userModel.prm('User Data in SigninCubit');
        return userModel;
      },
    );
  }
}
