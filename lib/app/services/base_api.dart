import 'package:bkd_presence_bloc/app/services/api_constant.dart';
import 'package:dio/dio.dart';

class API {
  final Dio dio;
  static final API _api = API._internal(
    Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiUrl,
        connectTimeout: const Duration(
          seconds: 15,
        ),
        receiveTimeout: const Duration(
          seconds: 15,
        ),
      ),
    ),
  );
  factory API() => _api;
  API._internal(this.dio);
}
