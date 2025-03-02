import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/api/upload_image_to_api.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';
import 'package:trading/features/balance/domain/models/withdraw_history_model.dart';
import 'package:trading/features/balance/domain/repo_interface/payment_repo_interface.dart';

class PaymentRepo implements PaymentRepoInterface {
  final ApiConsumer api;
  PaymentRepo({required this.api});
  @override
  Future<Either<ErrorModel, List<PaymentModel>>> getPaymentMehods() async {
    final t = 'PaymentRepo - getPaymentMehods'.prt;
    try {
      final response = await api.get(EndPoint.paymentMehods);
      final List<PaymentModel> allPaymentList = [];
      final List allPaymentJson = jsonDecode(response);
      for (var json in allPaymentJson) {
        allPaymentList.add(PaymentModel.fromJson(json));
      }
      '$allPaymentList'.prm(t);
      return Right(allPaymentList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, int>> addToBalance({
    required int paymentId,
    required int userId,
    required String transactionNumber,
    required double amount,
    required XFile imageXFile,
    required String createdAt,
  }) async {
    final t = 'PaymentRepo - addToBalance'.prt;
    final _ = {
      ApiKey.userId: userId,
      ApiKey.paymentId: paymentId,
      ApiKey.transactionNumber: transactionNumber,
      ApiKey.amount: amount,
      // ApiKey.image: (await uploadImageToApi(imageXFile)),
      ApiKey.createdAt: createdAt,
    }.prm('t');
    try {
      final response = await api.post(
        EndPoint.addDeposit,
        data: {
          ApiKey.userId: userId,
          ApiKey.paymentId: paymentId,
          ApiKey.transactionNumber: transactionNumber,
          ApiKey.amount: amount,
          ApiKey.image: (await uploadImageToApi(imageXFile)),
          ApiKey.createdAt: createdAt,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final int resultId = jsonDecode(response)[ApiKey.data];
        '$resultId'.prm(t);
        return Right(resultId);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, String>> withdraw({
    required int userId,
    required String accountNumber,
    required double amount,
    required String type,
    required int paymentId,
  }) async {
    final t = 'PaymentRepo - withdraw'.prt;
    try {
      final response = await api.post(
        EndPoint.withdraw,
        data: {
          ApiKey.userId: userId,
          ApiKey.accountNumber: accountNumber,
          ApiKey.paymentId: paymentId,
          ApiKey.amount: amount,
          ApiKey.type: type,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        'Withdraw from $type comptedted successfully'.prm(t);
        return const Right('success');
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<TransactionHistoryModel>>> getDepositHistory() async {
    final t = 'PaymentRepo - getDepositHistory'.prt;
    try {
      UserModel? userModel = await sl<AuthRepo>().getChacedUserData();
      final response = await api.get("${EndPoint.depositHistory}${userModel?.id}");
      // final response = await api.get("${EndPoint.depositHistory}5");
      final List<TransactionHistoryModel> allDepositHistoryList = [];
      List allDepoistHistoryJson = jsonDecode(response)[ApiKey.data];
      // allDepoistHistoryJson = depositStaticData;
      for (var json in allDepoistHistoryJson) {
        allDepositHistoryList.add(TransactionHistoryModel.fromJson(json));
      }
      '$allDepositHistoryList'.prm(t);
      return Right(allDepositHistoryList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<WithdrawHistoryModel>>> getWithdrawHistory() async {
    final t = 'PaymentRepo - getWithdrawHistory'.prt;
    try {
      UserModel? userModel = await sl<AuthRepo>().getChacedUserData();
      final response = await api.get("${EndPoint.withdrawHistory}${userModel?.id}");
      // final response = await api.get("${EndPoint.depositHistory}5");
      final List<WithdrawHistoryModel> allWithdrawHistoryList = [];
      List allWithdrawHistoryJson = jsonDecode(response)[ApiKey.data];
      // allWithdrawHistoryJson = withdrawStaticData;
      for (var json in allWithdrawHistoryJson) {
        allWithdrawHistoryList.add(WithdrawHistoryModel.fromJson(json));
      }
      '$allWithdrawHistoryList'.prm(t);
      return Right(allWithdrawHistoryList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  List withdrawStaticData = [
    {
      "id": 27,
      "image": null,
      "amount": 100,
      "account": " 88654",
      "user_id": 42,
      "accepted": "0",
      "payment_id": 3,
      "process": null,
      "refuse_reason": "Jhg",
      "type": "deposit",
      "created_at": "2024-07-12 00:19:51",
      "updated_at": "2024-07-12 00:20:53",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "المحافظ الإلكترونية - digital wallets",
      "payments_image": "1720544776.png"
    },
    {
      "id": 26,
      "image": null,
      "amount": 613.9,
      "account": " 8876543",
      "user_id": 42,
      "accepted": "0",
      "payment_id": 3,
      "process": null,
      "refuse_reason": null,
      "type": "profit",
      "created_at": "2024-07-12 00:03:36",
      "updated_at": "2024-07-12 00:03:36",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "المحافظ الإلكترونية - digital wallets",
      "payments_image": "1720544776.png"
    },
    {
      "id": 25,
      "image": null,
      "amount": 300,
      "account": " moneymaker",
      "user_id": 42,
      "accepted": "0",
      "payment_id": 2,
      "process": null,
      "refuse_reason": null,
      "type": "",
      "created_at": "2024-07-12 00:03:19",
      "updated_at": "2024-07-12 00:03:19",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "profit",
      "payments_image": "1716824408.jpg"
    },
    {
      "id": 5,
      "image": null,
      "amount": 79.11,
      "account": " 356788",
      "user_id": 42,
      "accepted": "1",
      "payment_id": 3,
      "process": null,
      "refuse_reason": null,
      "type": "profit",
      "created_at": "2024-07-09 00:30:07",
      "updated_at": "2024-07-08 21:32:20",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "المحافظ الإلكترونية - digital wallets",
      "payments_image": "1720544776.png"
    },
    {
      "id": 4,
      "image": null,
      "amount": 100,
      "account": " moneymaker",
      "user_id": 42,
      "accepted": "0",
      "payment_id": 2,
      "process": null,
      "refuse_reason": null,
      "type": "",
      "created_at": "2024-07-09 00:29:06",
      "updated_at": "2024-07-09 00:29:06",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "profit",
      "payments_image": "1716824408.jpg"
    },
    {
      "id": 3,
      "image": null,
      "amount": 23.91,
      "account": " 8765532",
      "user_id": 42,
      "accepted": "1",
      "payment_id": 3,
      "process": null,
      "refuse_reason": null,
      "type": "profit",
      "created_at": "2024-07-08 00:05:47",
      "updated_at": "2024-07-07 21:06:19",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "المحافظ الإلكترونية - digital wallets",
      "payments_image": "1720544776.png"
    },
    {
      "id": 2,
      "image": null,
      "amount": 30,
      "account": " moneymaker",
      "user_id": 42,
      "accepted": "0",
      "payment_id": 2,
      "process": null,
      "refuse_reason": "Jgfd",
      "type": "",
      "created_at": "2024-07-08 00:05:32",
      "updated_at": "2024-07-07 21:07:09",
      "profile": "1719425487.jpg",
      "first_name": "hamada1",
      "name": "profit",
      "payments_image": "1716824408.jpg"
    }
  ];
  List depositStaticData = [
    {
      "id": 24,
      "amount": 300,
      "user_id": 42,
      "image": "0.jpg",
      "accepted": "1",
      "payment_id": 2,
      "process": null,
      "refuse_reason": null,
      "created_at": "2024-07-12 00:03:19",
      "updated_at": "2024-07-12 00:03:19",
      "first_name": "hamada1",
      "profile": "1719425487.jpg",
      "name": "profit",
      "payments_image": "1716824408.jpg"
    },
    {
      "id": 21,
      "amount": 0,
      "user_id": 42,
      "image": null,
      "accepted": "1",
      "payment_id": 1,
      "process": null,
      "refuse_reason": null,
      "created_at": "2024-07-11 23:28:39",
      "updated_at": "2024-07-11 23:28:39",
      "first_name": "hamada1",
      "profile": "1719425487.jpg",
      "name": "prog",
      "payments_image": "1714925067.png"
    },
    {
      "id": 20,
      "amount": 0,
      "user_id": 42,
      "image": null,
      "accepted": "1",
      "payment_id": 1,
      "process": null,
      "refuse_reason": null,
      "created_at": "2024-07-11 20:27:33",
      "updated_at": "2024-07-11 20:27:33",
      "first_name": "hamada1",
      "profile": "1719425487.jpg",
      "name": "prog",
      "payments_image": "1714925067.png"
    },
    {
      "id": 9,
      "amount": 100,
      "user_id": 42,
      "image": "0.jpg",
      "accepted": "1",
      "payment_id": 2,
      "process": null,
      "refuse_reason": null,
      "created_at": "2024-07-09 00:29:06",
      "updated_at": "2024-07-09 00:29:06",
      "first_name": "hamada1",
      "profile": "1719425487.jpg",
      "name": "profit",
      "payments_image": "1716824408.jpg"
    },
    {
      "id": 2,
      "amount": 100,
      "user_id": 42,
      "image": "1720362071.jpg",
      "accepted": "1",
      "payment_id": 3,
      "process": "245689",
      "refuse_reason": null,
      "created_at": "2024-07-07 00:00:00",
      "updated_at": "2024-07-07 14:21:33",
      "first_name": "hamada1",
      "profile": "1719425487.jpg",
      "name": "المحافظ الإلكترونية - digital wallets",
      "payments_image": "1720544776.png"
    }
  ];
}
