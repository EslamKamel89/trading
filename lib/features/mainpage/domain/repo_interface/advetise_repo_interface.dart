import 'package:dartz/dartz.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/mainpage/domain/models/banner_model.dart';

abstract class AdvertiseRepoInterface {
  Future<Either<ErrorModel, List<BannerModel>>> getAdvertise();
}
