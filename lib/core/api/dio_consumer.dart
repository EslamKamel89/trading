import 'package:dio/dio.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/api_interceptors.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/functions/check_internet.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(DioInterceptor()); // i use the interceptor to add the header
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameter,
  }) async {
    final t = "DioConsumer - get".prt;
    try {
      if (!(await checkInternet())) {
        throw ServerException(errModel: ErrorModel.offlineError);
      }
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameter,
      );
      response.data.toString().prm(t);
      return response.data;
    } on DioException catch (e) {
      e.toString().prm('$t - Error');
      handleDioException(e);
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    final t = "DioConsumer - delete".prt;
    try {
      if (!(await checkInternet())) {
        throw ServerException(errModel: ErrorModel.offlineError);
      }
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      response.data.toString().prm(t);
      return response.data;
    } on DioException catch (e) {
      e.toString().prm('$t - Error');
      handleDioException(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    final t = "DioConsumer - patch ".prt;
    try {
      if (!(await checkInternet())) {
        throw ServerException(errModel: ErrorModel.offlineError);
      }
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      response.data.prm(t);
      return response.data;
    } on DioException catch (e) {
      e.toString().prm('$t - Error');
      handleDioException(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    final t = "DioConsumer - post".prt;
    try {
      if (!(await checkInternet())) {
        throw ServerException(errModel: ErrorModel.offlineError);
      }
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      );
      response.data.toString().prm(t);
      return response.data;
    } on DioException catch (e) {
      e.toString().prm('$t - Error');
      handleDioException(e);
    }
  }
}
