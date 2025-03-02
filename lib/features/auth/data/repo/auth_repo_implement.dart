import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/api/upload_image_to_api.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/domain/models/signin_model.dart';
import 'package:trading/features/auth/domain/models/signup_model.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/auth/domain/repo/auth_repo_abstract.dart';

class AuthRepo implements AuthRepoInterface {
  final ApiConsumer api;
  AuthRepo({required this.api});
  @override
  Future<Either<ErrorModel, UserModel>> getUserData({required int userId}) async {
    final t = 'AuthRepo - getUserData'.prt;
    'get User Data is called : userId = $userId'.prm(t);
    try {
      final response = await api.get('${EndPoint.getUserData}$userId');
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final userModel = UserModel.fromJson(jsonDecode(response));
        // userModel.chat = ApiKey.chatAllowed;
        sl<SharedPreferences>().setString(AppStrings.CHAT_STATUS, userModel.chat ?? ApiKey.chatBlocked);
        sl<SharedPreferences>().setInt(AppStrings.USER_ID, userModel.id ?? -1);
        '$userModel'.prm(t);
        return Right(userModel);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, SigninModel>> signin({
    required String userName,
    required String password,
  }) async {
    final t = 'AuthRepo - signin'.prt;
    try {
      final response = await api.post(
        EndPoint.signin,
        data: {
          ApiKey.user: userName,
          ApiKey.password: password,
        },
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final signinModel = SigninModel.fromJson(jsonDecode(response));
        '$signinModel'.prm(t);
        return Right(signinModel);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
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
  }) async {
    final t = 'Repo - signup'.prt;
    try {
      final response = await api.post(
        EndPoint.signup,
        data: {
          ApiKey.userName: userName,
          ApiKey.fullName: fullName,
          ApiKey.gender: gender,
          ApiKey.email: email,
          ApiKey.mobile: mobile,
          ApiKey.password: password,
          ApiKey.levelId: levelId,
          ApiKey.profile: profileXFile != null ? (await uploadImageToApi(profileXFile)) : null,
          ApiKey.passport: (await uploadImageToApi(passportXFile)),
          ApiKey.passportBack: passportBackXFile != null ? (await uploadImageToApi(passportBackXFile)) : null,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final signupModel = SignupModel.fromJson(jsonDecode(response));
        '$signupModel'.prm(t);
        return Right(signupModel);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<UserModel?> getChacedUserData() async {
    final userDataString = sl<SharedPreferences>().getString(AppStrings.USER_DATA);
    if (userDataString == null) {
      'No current user is signed in'.prm('Auth checking cahce');
      return null;
    }
    final user = UserModel.fromJson(jsonDecode(userDataString));
    //! fake data delete in production
    // user.referral = 1000;
    // user.daily = 1500;
    // user.chat = 'block';
    // user.id = 23;
    "$user".prm('Auth checking cahce');
    return user;
  }

  @override
  Future cacheUserData(UserModel userModel) async {
    await sl<SharedPreferences>().setString(AppStrings.USER_DATA, userModel.toJsonString());
  }
}
