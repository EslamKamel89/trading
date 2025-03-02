part of 'singin_cubit.dart';

sealed class SigninState {}

final class SinginInitial extends SigninState {}

class PickResetPasswordMethodState extends SigninState {
  final bool isEmail;
  PickResetPasswordMethodState({required this.isEmail});
}

class OtpForgetState extends SigninState {
  final String otp;
  OtpForgetState({required this.otp});
}

class SigninSuccessState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninFailureState extends SigninState {
  final String errorMessage;
  SigninFailureState({required this.errorMessage});
}
