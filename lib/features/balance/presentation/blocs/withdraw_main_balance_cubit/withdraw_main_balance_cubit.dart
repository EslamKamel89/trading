import 'package:bloc/bloc.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';

part 'withdraw_main_balance_state.dart';

class WithdrawMainBalanceCubit extends Cubit<WithdrawMainBalanceState> {
  final PaymentRepo paymentRepo;

  WithdrawMainBalanceCubit({required this.paymentRepo}) : super(WithdrawMainBalanceInitial());

  Future getAllPaymentMethod() async {
    if (isClosed) {
      return null;
    }
    emit(WithdrawMainBalanceLoadingState());
    final response = await paymentRepo.getPaymentMehods();
    response.fold(
      (errorModel) {
        emit(WithdrawMainBalanceFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(WithdrawMainBalanceSuccessState(allPayments: allPayments));
      },
    );
  }

  Future withdraw({
    required int paymentId,
    required String accountNumber,
    required double amount,
  }) async {
    if (isClosed) {
      return null;
    }
    emit(WithdrawMainRequestLoadingState());
    final authRepo = sl<AuthRepo>();
    final UserModel? userModel = await authRepo.getChacedUserData();
    final int userId = userModel?.id ?? 0;
    final response = await paymentRepo.withdraw(
      userId: userId,
      accountNumber: accountNumber,
      amount: amount,
      type: ApiKey.withdrawMainBalance,
      paymentId: paymentId,
    );
    response.fold(
      (errorModel) {
        emit(WithdrawMainRequestFailedState(
            errorMessage: errorModel.errorMessageEn ?? "can't complete the withdraw for unknown reason"));
      },
      (allPayments) {
        emit(WithdrawMainRequestSuccessState());
      },
    );
  }
}
