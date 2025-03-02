part of 'withdraw_weekly_balance_cubit.dart';

sealed class WithdrawWeeklyBalanceState extends Equatable {
  const WithdrawWeeklyBalanceState();

  @override
  List<Object> get props => [];
}

final class WithdrawWeeklyBalanceInitial extends WithdrawWeeklyBalanceState {}

final class WithdrawWeeklyBalanceLoadingState extends WithdrawWeeklyBalanceState {}

final class WithdrawWeeklyBalanceFailedState extends WithdrawWeeklyBalanceState {
  final ErrorModel errorModel;
  const WithdrawWeeklyBalanceFailedState({required this.errorModel});
}

final class WithdrawWeeklyBalanceSuccessState extends WithdrawWeeklyBalanceState {
  final List<PaymentModel> allPayments;
  const WithdrawWeeklyBalanceSuccessState({required this.allPayments});
}

class WithdrawWeeklyRequestLoadingState extends WithdrawWeeklyBalanceState {}

class WithdrawWeeklyRequestFailedState extends WithdrawWeeklyBalanceState {
  final String errorMessage;
  const WithdrawWeeklyRequestFailedState({required this.errorMessage});
}

class WithdrawWeeklyRequestSuccessState extends WithdrawWeeklyBalanceState {}
