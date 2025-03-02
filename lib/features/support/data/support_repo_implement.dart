import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/support/domain/models/support_message_model.dart';
import 'package:trading/features/support/domain/repo-interface/support_repo_interface.dart';

class SupportRepo implements SupportRepoInterface {
  final ApiConsumer api;
  SupportRepo({required this.api});
  @override
  Future<Either<ErrorModel, List<SupportMessageModel>>> getSupportMessage({required int userId}) async {
    final t = 'SupportRepo - getSupportMessage'.prt;
    try {
      final response = await api.get("${EndPoint.supportMessages}/$userId");
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<SupportMessageModel> supportMessages =
            jsonList.map((json) => SupportMessageModel.fromJson(json)).toList();
        '$supportMessages'.prm(t);
        final List<SupportMessageModel> result = [];
        for (SupportMessageModel message in supportMessages) {
          result.add(message);
          if (message.supportMessage != null && message.supportMessage != "") {
            result.add(SupportMessageModel(
              id: message.id,
              senderId: -1,
              senderName: "Admin",
              senderMessage: message.supportMessage,
              createdAt: message.createdAt,
            ));
          }
        }
        return Right(result);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, bool>> postNewSupportMessage({required int userId, required String message}) async {
    final t = 'SupportRepo - getSupportMessage'.prt;
    try {
      final response = await api.post(
        EndPoint.supportMessages,
        data: {
          ApiKey.senderId: userId,
          ApiKey.senderMessage: message,
          ApiKey.messageId: 1,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        'message is sent by userId = $userId and message = $message'.prm(t);
        return const Right(true);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }
}
