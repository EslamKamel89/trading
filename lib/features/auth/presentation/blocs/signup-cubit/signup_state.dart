// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

class SignupState {}

final class AuthInitial extends SignupState {}

class UpdateUserImageState extends SignupState {}

class UpdateDoucumentImageState extends SignupState {}

final class PickVerificationMethodState extends SignupState {
  final bool isEmail;
  PickVerificationMethodState({required this.isEmail});
}

class OtpSignupState extends SignupState {
  final String otp;
  OtpSignupState({required this.otp});
}

class SignupSuccessState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupFailureState extends SignupState {
  final String errorMessage;
  SignupFailureState({required this.errorMessage});
}
