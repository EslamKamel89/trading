import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/auth/domain/models/signin_model.dart';
import 'package:trading/features/auth/domain/models/signup_model.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';

abstract class AuthRepoInterface {
  Future<Either<ErrorModel, SigninModel>> signin({
    required String userName,
    required String password,
  });
  Future<Either<ErrorModel, SignupModel>> signup({
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
  Future<Either<ErrorModel, UserModel>> getUserData({required int userId});

  Future<UserModel?> getChacedUserData();
  Future cacheUserData(UserModel userModel);
}
