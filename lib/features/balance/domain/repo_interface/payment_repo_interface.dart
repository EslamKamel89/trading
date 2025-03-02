import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';
import 'package:trading/features/balance/domain/models/withdraw_history_model.dart';

abstract class PaymentRepoInterface {
  Future<Either<ErrorModel, List<PaymentModel>>> getPaymentMehods();
  Future<Either<ErrorModel, List<TransactionHistoryModel>>> getDepositHistory();
  Future<Either<ErrorModel, List<WithdrawHistoryModel>>> getWithdrawHistory();
  Future<Either<ErrorModel, int>> addToBalance({
    required int paymentId,
    required int userId,
    required String transactionNumber,
    required double amount,
    required XFile imageXFile,
    required String createdAt,
  });
  Future<Either<ErrorModel, String>> withdraw({
    required int userId,
    required String accountNumber,
    required double amount,
    required String type,
    required int paymentId,
  });
}
