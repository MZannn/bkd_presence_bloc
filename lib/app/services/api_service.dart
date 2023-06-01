import 'package:bkd_presence_bloc/app/services/base_api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final API api = API();
  String? token;
  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenStorage = prefs.getString('token');
    if (tokenStorage != null) {
      token = tokenStorage;
    }
  }

  Future<dynamic> get<T>(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      bool requireToken = false}) async {
    if (requireToken) {
      await _getToken();
    }
    var customHeaders = requireToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};
    if (headers != null) {
      customHeaders.addAll(headers);
    }

    try {
      final response = await api.dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: customHeaders),
      );
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data['message'];
    }
  }

  Future<dynamic> post<T>({
    required String endpoint,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireToken = false,
  }) async {
    if (requireToken) {
      await _getToken();
    }
    var customHeaders = requireToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};
    if (headers != null) {
      customHeaders.addAll(headers);
    }
    try {
      final response = await api.dio.post(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: customHeaders,
        ),
      );
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data['message'];
    }
  }

  Future<dynamic> put<T>({
    required String endpoint,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requireToken = false,
  }) async {
    if (requireToken) {
      await _getToken();
    }
    var customHeaders = requireToken
        ? {'Accept': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Accept': 'application/json'};
    if (headers != null) {
      customHeaders.addAll(headers);
    }
    try {
      final response = await api.dio.put(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: customHeaders,
        ),
      );
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data['message'];
    }
  }
}
