part of 'add_referrals_cubit.dart';

sealed class AddReferralsState {
  const AddReferralsState();
}

final class AddReferralsInitial extends AddReferralsState {}

class UpdateUserImageReferralsState extends AddReferralsState {}

class UpdateDoucumentImageReferralsState extends AddReferralsState {}

class AddReferralSuccessState extends AddReferralsState {}

class AddReferralLoadingState extends AddReferralsState {}

class AddReferralFailureState extends AddReferralsState {
  final String errorMessage;
  AddReferralFailureState({required this.errorMessage});
}

class ReferralHistorySuccessState extends AddReferralsState {}

class ReferralHistoryLoadingState extends AddReferralsState {}

class ReferralHistoryFailureState extends AddReferralsState {
  final String errorMessage;
  ReferralHistoryFailureState({required this.errorMessage});
}
