part of 'add_balance_cubit.dart';

sealed class AddBalanceState extends Equatable {
  const AddBalanceState();
  @override
  List<Object?> get props => [];
}

final class AddBalanceInitial extends AddBalanceState {}

final class UploadDocumentGalleryState extends AddBalanceState {}

final class UploadDocumentCameraState extends AddBalanceState {}

final class ResetUploadDocumentState extends AddBalanceState {}

final class DatePickedState extends AddBalanceState {
  final DateTime? transactionDate;
  const DatePickedState({required this.transactionDate});
  @override
  List<Object?> get props => [transactionDate];
}

final class AddBalanceLoadingState extends AddBalanceState {}

final class AddBalanceFailedState extends AddBalanceState {
  final ErrorModel errorModel;
  const AddBalanceFailedState({required this.errorModel});
  @override
  List<Object?> get props => [errorModel];
}

final class AddBalanceGetPaymentSuccessState extends AddBalanceState {
  final List<PaymentModel> allPayments;
  const AddBalanceGetPaymentSuccessState({required this.allPayments});
  @override
  List<Object?> get props => [allPayments];
}

final class AddBalanceDepositLoadingState extends AddBalanceState {}

final class AddBalanceDepositFailedState extends AddBalanceState {
  final String errorMessage;
  const AddBalanceDepositFailedState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class AddBalanceDepositSuccessState extends AddBalanceState {}

final class AddBalanceFromProfitLoadingState extends AddBalanceState {}

final class AddBalanceFromProfitFailedState extends AddBalanceState {
  final String errorMessage;
  const AddBalanceFromProfitFailedState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class AddBalanceFromProfitSuccessState extends AddBalanceState {}
