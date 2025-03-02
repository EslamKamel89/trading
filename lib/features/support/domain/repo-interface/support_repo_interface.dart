import 'package:dartz/dartz.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/support/domain/models/support_message_model.dart';

abstract class SupportRepoInterface {
  Future<Either<ErrorModel, List<SupportMessageModel>>> getSupportMessage({required int userId});

  Future<Either<ErrorModel, bool>> postNewSupportMessage({
    required int userId,
    required String message,
  });
}
