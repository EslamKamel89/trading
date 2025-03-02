import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/certification_model.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/news_model.dart';
import 'package:trading/features/notifications-news-certifications/domain/repo-abstract/news_repo_abstract.dart';

class NewsRepo implements NewsRepoAbstract {
  final ApiConsumer api;
  NewsRepo({required this.api});
  @override
  Future<Either<ErrorModel, List<NewsModel>>> getNews() async {
    final t = 'NewsRepo - getNews'.prt;
    try {
      final response = await api.get(EndPoint.news);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<NewsModel> news = jsonList.map((json) => NewsModel.fromJson(json)).toList();
        news.prm(t);
        return Right(news);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<CertificationModel>>> getCertifications() async {
    final t = 'NewsRepo - getCertifications'.prt;
    try {
      final response = await api.get(EndPoint.certifications);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<CertificationModel> certifications =
            jsonList.map((json) => CertificationModel.fromJson(json)).toList();
        certifications.prm(t);
        return Right(certifications);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<NewsModel>>> getBlogNews() async {
    final t = 'NewsRepo - getBlogNews'.prt;
    try {
      final response = await api.get(EndPoint.blogNews);
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final List jsonList = jsonDecode(response)[ApiKey.data];
        final List<NewsModel> news = jsonList.map((json) => NewsModel.fromJson(json)).toList();
        news.prm(t);
        return Right(news);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }
}
