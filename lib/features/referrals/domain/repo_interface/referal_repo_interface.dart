import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/referrals/domain/models/referals_history_model.dart';

abstract class ReferalsRepoInterface {
  Future<Either<ErrorModel, int>> addReferal({
    required String userName,
    required String fullName,
    required String gender,
    required String email,
    required String mobile,
    required String password,
    required XFile? profileXFile,
    required XFile passportXFile,
    required XFile? passportBackXFile,
    int levelId = 2,
  });

  Future<Either<ErrorModel, List<ReferalHistoryModel>>> getReferalsHistory();
}
