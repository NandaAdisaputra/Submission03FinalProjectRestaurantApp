import 'package:dio/dio.dart';
import 'package:submission3nanda/utils/network_helper/failure.dart';
import '../resource_helper/strings.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic) {
    if (dynamic is DioException) {
      failure = _handleError(dynamic);
    } else {
      failure = DataSource.defaultDataSource.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOutDataSource.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOutDataSource.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.reCiEveTimoOutDataSource.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.data["message"] ?? "");
      } else {
        return DataSource.defaultDataSource.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancelDataSource.getFailure();
    default:
      return DataSource.defaultDataSource.getFailure();
  }
}

enum DataSource {
  successDataSource,
  noContentDataSource,
  badRequestDataSource,
  forbiddenDataSource,
  unAutoRiSedDataSource,
  notFoundDataSource,
  internalServerErrorDataSource,
  connectTimeOutDataSource,
  cancelDataSource,
  reCiEveTimoOutDataSource,
  sendTimeOutDataSource,
  cacheErrorDataSource,
  noInternetConnectionDataSource,
  defaultDataSource
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.successDataSource:
        return Failure(
            ResponseCode.successDataSource, ResponseMessage.successDataSource);
      case DataSource.noContentDataSource:
        return Failure(ResponseCode.noContentDataSource,
            ResponseMessage.noContentDataSource);
      case DataSource.badRequestDataSource:
        return Failure(ResponseCode.badRequestDataSource,
            ResponseMessage.badRequestDataSource);
      case DataSource.forbiddenDataSource:
        return Failure(ResponseCode.forbiddenDataSource,
            ResponseMessage.forbiddenDataSource);
      case DataSource.unAutoRiSedDataSource:
        return Failure(ResponseCode.unAutoRiSedDataSource,
            ResponseMessage.unAutoRiSedDataSource);
      case DataSource.notFoundDataSource:
        return Failure(ResponseCode.notFoundDataSource,
            ResponseMessage.notFoundDataSource);
      case DataSource.internalServerErrorDataSource:
        return Failure(ResponseCode.internalServerErrorDataSource,
            ResponseMessage.internalServerErrorDataSource);
      case DataSource.connectTimeOutDataSource:
        return Failure(ResponseCode.connectTimeOutDataSource,
            ResponseMessage.connectTimeOutDataSource);
      case DataSource.cancelDataSource:
        return Failure(
            ResponseCode.cancelDataSource, ResponseMessage.cancelDataSource);
      case DataSource.reCiEveTimoOutDataSource:
        return Failure(ResponseCode.reCiEveTimoOutDataSource,
            ResponseMessage.reCiEveTimoOutDataSource);
      case DataSource.sendTimeOutDataSource:
        return Failure(ResponseCode.sendTimeOutDataSource,
            ResponseMessage.sendTimeOutDataSource);
      case DataSource.cacheErrorDataSource:
        return Failure(ResponseCode.cacheErrorDataSource,
            ResponseMessage.cacheErrorDataSource);
      case DataSource.noInternetConnectionDataSource:
        return Failure(ResponseCode.noInternetConnectionDataSource,
            ResponseMessage.noInternetConnectionDataSource);
      case DataSource.defaultDataSource:
        return Failure(
            ResponseCode.defaultDataSource, ResponseMessage.defaultDataSource);
    }
  }
}

class ResponseCode {
  static const int successDataSource = 200; // success with data
  static const int noContentDataSource =
      201; // success with no data (no content)
  static const int badRequestDataSource = 400; // failure, API rejected request
  static const int unAutoRiSedDataSource =
      401; // failure, user is not authorised
  static const int forbiddenDataSource = 403; //  failure, API rejected request
  static const int internalServerErrorDataSource =
      500; // failure, crash in server side
  static const int notFoundDataSource = 404; // failure, not found

  // local status code
  static const int connectTimeOutDataSource = -1;
  static const int cancelDataSource = -2;
  static const int reCiEveTimoOutDataSource = -3;
  static const int sendTimeOutDataSource = -4;
  static const int cacheErrorDataSource = -5;
  static const int noInternetConnectionDataSource = -6;
  static const int defaultDataSource = -7;
}

class ResponseMessage {
  static const String successDataSource =
      AppStrings.success; // success with data
  static const String noContentDataSource =
      AppStrings.success; // success with no data (no content)
  static const String badRequestDataSource =
      AppStrings.strBadRequestError; // failure, API rejected request
  static const String unAutoRiSedDataSource =
      AppStrings.strUnauthorizedError; // failure, user is not authorised
  static const String forbiddenDataSource =
      AppStrings.strForbiddenError; //  failure, API rejected request
  static const String internalServerErrorDataSource =
      AppStrings.strInternalServerError; // failure, crash in server side
  static const String notFoundDataSource =
      AppStrings.strNotFoundError; // failure, crash in server side

  // local status code
  static const String connectTimeOutDataSource = AppStrings.strTimeoutError;
  static const String cancelDataSource = AppStrings.strDefaultError;
  static const String reCiEveTimoOutDataSource = AppStrings.strTimeoutError;
  static const String sendTimeOutDataSource = AppStrings.strTimeoutError;
  static const String cacheErrorDataSource = AppStrings.strCacheError;
  static const String noInternetConnectionDataSource =
      AppStrings.strNoInternetError;
  static const String defaultDataSource = AppStrings.strDefaultError;
}

class ApiInternalStatus {
  static const int successDataSource = 200;
  static const int failureDataSource = 400;
}
