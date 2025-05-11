import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl, required String apiKey})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-api-key': apiKey,
          },
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool includeApiKeyAsQuery = false,
  }) async {
    try {
      final params = Map<String, dynamic>.from(queryParameters ?? {});
      if (includeApiKeyAsQuery) {
        params['api_key'] = _dio.options.headers['x-api-key'];
      }
      return await _dio.get(path, queryParameters: params);
    } on DioException catch (e) {
      throw Exception('Failed to load data: ${e.message}');
    }
  }

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);
  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);
  Future<Response> delete(String path, {dynamic data}) =>
      _dio.delete(path, data: data);
}
