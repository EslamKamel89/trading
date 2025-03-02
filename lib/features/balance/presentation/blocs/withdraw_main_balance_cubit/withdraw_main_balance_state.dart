part of 'withdraw_main_balance_cubit.dart';

sealed class WithdrawMainBalanceState {
  const WithdrawMainBalanceState();
}

class WithdrawMainBalanceInitial extends WithdrawMainBalanceState {}

class WithdrawMainBalanceLoadingState extends WithdrawMainBalanceState {}

class WithdrawMainBalanceFailedState extends WithdrawMainBalanceState {
  final ErrorModel errorModel;
  const WithdrawMainBalanceFailedState({required this.errorModel});
}

class WithdrawMainBalanceSuccessState extends WithdrawMainBalanceState {
  final List<PaymentModel> allPayments;
  const WithdrawMainBalanceSuccessState({required this.allPayments});
}

class WithdrawMainRequestLoadingState extends WithdrawMainBalanceState {}

class WithdrawMainRequestFailedState extends WithdrawMainBalanceState {
  final String errorMessage;
  const WithdrawMainRequestFailedState({required this.errorMessage});
}

class WithdrawMainRequestSuccessState extends WithdrawMainBalanceState {}
