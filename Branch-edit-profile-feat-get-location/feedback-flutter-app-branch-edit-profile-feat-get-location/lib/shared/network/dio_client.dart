import 'package:dio/dio.dart';
import 'interceptors/interceptors.dart';

const String baseURL = 'https://feedback24.ru/api';
const int receiveTimeout = 5000;
const int connectionTimeout = 3000;

class DioClient {
  final _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: receiveTimeout,
      receiveTimeout: connectionTimeout,
      responseType: ResponseType.json))
    ..interceptors.add(AuthorizationInterceptor());
  Dio get dio => _dio;
}
