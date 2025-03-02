import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';

part 'withdraw_weekly_balance_state.dart';

class WithdrawWeeklyBalanceCubit extends Cubit<WithdrawWeeklyBalanceState> {
  final PaymentRepo paymentRepo;

  WithdrawWeeklyBalanceCubit({required this.paymentRepo}) : super(WithdrawWeeklyBalanceInitial());

  Future getAllPaymentMethod() async {
    if (isClosed) {
      return;
    }
    emit(WithdrawWeeklyBalanceLoadingState());
    final response = await paymentRepo.getPaymentMehods();
    response.fold(
      (errorModel) {
        emit(WithdrawWeeklyBalanceFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(WithdrawWeeklyBalanceSuccessState(allPayments: allPayments));
      },
    );
  }

  Future withdraw({
    required int paymentId,
    required String accountNumber,
    required double amount,
  }) async {
    if (isClosed) {
      return;
    }
    emit(WithdrawWeeklyRequestLoadingState());
    final authRepo = sl<AuthRepo>();
    final UserModel? userModel = await authRepo.getChacedUserData();
    final int userId = userModel?.id ?? 0;
    final response = await paymentRepo.withdraw(
      userId: userId,
      accountNumber: accountNumber,
      amount: amount,
      type: ApiKey.withdrawWeeklyBalance,
      paymentId: paymentId,
    );
    response.fold(
      (errorModel) {
        emit(WithdrawWeeklyRequestFailedState(
            errorMessage: errorModel.errorMessageEn ?? "can't complete the withdraw for unknown reason"));
      },
      (allPayments) {
        emit(WithdrawWeeklyRequestSuccessState());
      },
    );
  }
}
