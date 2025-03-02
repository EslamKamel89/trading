part of 'transaction_history_cubit.dart';

sealed class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

final class TransactionHistoryInitial extends TransactionHistoryState {}

final class TransactionHistoryLoadingState extends TransactionHistoryState {}

final class TransactionHistoryFailedState extends TransactionHistoryState {
  final ErrorModel errorModel;
  const TransactionHistoryFailedState({required this.errorModel});
}

final class TransactionHistorySuccessState extends TransactionHistoryState {
  final List<TransactionHistoryModel> allDepositHistory;
  const TransactionHistorySuccessState({required this.allDepositHistory});
}

final class WithdrawHistoryLoadingState extends TransactionHistoryState {}

final class WithdrawHistoryFailedState extends TransactionHistoryState {
  final ErrorModel errorModel;
  const WithdrawHistoryFailedState({required this.errorModel});
}

final class WithdrawHistorySuccessState extends TransactionHistoryState {
  final List<WithdrawHistoryModel> allWithdrawHistory;
  const WithdrawHistorySuccessState({required this.allWithdrawHistory});
}
