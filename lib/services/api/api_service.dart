import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_mvvm/configurations/environment_config.dart';
import 'package:flutter_mvvm/services/api/api_exception.dart';

enum MethodType { get, post, put, delete }

class ApiService {
  late final Dio _dio;

  ApiService() {
    final baseOptions = BaseOptions(
      baseUrl: EnvironmentConfig.baseURL,
      connectTimeout: Duration(milliseconds: EnvironmentConfig.connectTimeout),
      validateStatus: (status) {
        return status! <= 500;
      },
    );
    _dio = Dio(baseOptions);
    if (EnvironmentConfig.allowNetworkLogs) {
      addLogInterceptor();
    }
  }

  addLogInterceptor() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future get(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers,
  ) async {
    try {
      _dio.options.headers = headers;
      final response = await _dio.get(path, queryParameters: queryParameters);
      return returnResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return returnResponse(error.response!);
      }
      throw Exception(error.error);
    }
  }

  Future post(
    String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic> headers,
  ) async {
    try {
      _dio.options.headers = headers;
      final response =
          await _dio.post(path, queryParameters: queryParameters, data: data);
      return returnResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return returnResponse(error.response!);
      }
      throw Exception(error.error);
    }
  }

  Future put(
    String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic> headers,
  ) async {
    try {
      _dio.options.headers = headers;
      final response =
          await _dio.put(path, queryParameters: queryParameters, data: data);
      return returnResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return returnResponse(error.response!);
      }
      throw Exception(error.error);
    }
  }

  Future delete(
    String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> headers,
  ) async {
    try {
      _dio.options.headers = headers;
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return returnResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return returnResponse(error.response!);
      }
      throw Exception(error.error);
    }
  }

  dynamic returnResponse(Response response) {
    dynamic responseJson = response.data;
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(response.statusCode, responseJson['error']);
      case 401:
      case 403:
        throw UnauthorisedException(response.statusCode, responseJson['error']);
      case 404:
        throw NotFoundException(response.statusCode, responseJson['error']);
      case 500:
      default:
        throw FetchDataException(
          response.statusCode,
          responseJson['error'] ??
              'Error occurred while communication with the server with status code: ${response.statusCode}',
        );
    }
  }
}
