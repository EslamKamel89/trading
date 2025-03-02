// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:trading/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;
  ServerException({
    required this.errModel,
  });
}

// class BadResponseException implements Exception {
//   final ErrorModel errorModel;
//   BadResponseException({required this.errorModel});
// }

void handleDioException(DioException e) {
  throw ServerException(
    errModel: ErrorModel.serverFailure(statusCode: e.response?.statusCode),
  );
  /* switch (e.type) {
    // all of the exception is connectoin failure with the server except bad response which
    // occurs when the backend reply with status code 403
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
     
    //! the only exception that the connection with the server is successful but there are problem
    //! with the sended data
    case DioExceptionType.badResponse:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    // switch (e.response!.statusCode) {
    //   case 400: // Bad Request
    //   case 401: // unauthorized

    //   case 403: // forbidden

    //   case 404: // not found

    //   case 409: // cofficient

    //   case 422: // unprocessable entity

    //   case 504: // server exception
    // }
  } */
}
