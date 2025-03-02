// ignore_for_file: unnecessary_overrides

import 'package:dio/dio.dart';

// the interceptor works as police officer that governs all the requests and responses
// 1>> you could add the headers here once and it will be sended every time

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // options.headers[ApiKey.token] = 'FOODAPI ${sharedPreferences.getString(ApiKey.token) ?? ''}';
    // options.headers['Accept-Language'] = 'en ';
    options.headers['Accept'] = '*/*';
    // options.headers['Content-Type'] = 'multipart/form-data';

    super.onRequest(options, handler);
  }

  /// Called when the response is about to be resolved.
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
  }

  /// Called when an exception was occurred during the request.
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    super.onError(err, handler);
  }
}
