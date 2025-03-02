import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';
import 'package:trading/features/balance/domain/models/withdraw_history_model.dart';

part 'transaction_history_state.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryState> {
  final PaymentRepo paymentRepo;
  TransactionHistoryCubit({required this.paymentRepo}) : super(TransactionHistoryInitial());
  Future getDepositHistory() async {
    if (isClosed) {
      return null;
    }
    emit(TransactionHistoryLoadingState());
    final response = await paymentRepo.getDepositHistory();
    response.fold(
      (errorModel) {
        emit(TransactionHistoryFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(TransactionHistorySuccessState(allDepositHistory: allPayments));
      },
    );
  }

  Future getWithdrawHistory() async {
    if (isClosed) {
      return null;
    }
    emit(WithdrawHistoryLoadingState());
    final response = await paymentRepo.getWithdrawHistory();
    response.fold(
      (errorModel) {
        emit(WithdrawHistoryFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(WithdrawHistorySuccessState(allWithdrawHistory: allPayments));
      },
    );
  }
}
