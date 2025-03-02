import 'package:dartz/dartz.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/certification_model.dart';
import 'package:trading/features/notifications-news-certifications/domain/models/news_model.dart';

abstract class NewsRepoAbstract {
  Future<Either<ErrorModel, List<NewsModel>>> getNews();
  Future<Either<ErrorModel, List<CertificationModel>>> getCertifications();
  Future<Either<ErrorModel, List<NewsModel>>> getBlogNews();
}
