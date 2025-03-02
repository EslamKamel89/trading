import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/mainpage/domain/models/banner_model.dart';
import 'package:trading/features/mainpage/domain/repo_interface/advetise_repo_interface.dart';

class AdvertiseRepo implements AdvertiseRepoInterface {
  final ApiConsumer api;
  AdvertiseRepo({required this.api});

  @override
  Future<Either<ErrorModel, List<BannerModel>>> getAdvertise() async {
    final t = 'AdvertiseRepo - getAdvertise'.prt;
    try {
      final response = await api.get(EndPoint.advertise);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<BannerModel> bannerList = jsonList.map((json) => BannerModel.fromJson(json)).toList();
        '$bannerList'.prm(t);
        return Right(bannerList);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }
}
