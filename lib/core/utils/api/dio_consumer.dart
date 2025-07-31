import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../../network/local/flutter_secure_storage.dart';
import 'endpoint.dart';
import 'api_consumer.dart';


class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.headers = {
      'Accept-Language': 'ar',
    };

    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          maxStale: const Duration(minutes: 30),
          priority: CachePriority.high,
          keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        ),
      ),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Map<String, String>> _buildHeaders({bool withAuth = true}) async {
    final token = await SecureStorageService.read(SecureStorageService.token);
    print("🔑 Token being sent: $token");

    return {
      'Accept-Language': 'ar',
      if (withAuth && token != null)
        'Authorization': 'Bearer $token',
    };
  }


  /// Use this to send body as JSON with GET (required by some APIs)
  @override
  Future get(
      String path, {
        Object? data,
        Duration? cacheDuration,
        Map<String, dynamic>? queryParameters,
        bool useCache = true,
        bool withAuth = true,
      }) async {
    try {
      final response = await dio.request(
        path,
        data: data, // << send body for GET
        queryParameters: queryParameters,
        options: Options(
          method: 'GET',
          headers: await _buildHeaders(withAuth: withAuth),
          contentType: 'application/json',
          extra: {
            'cache': useCache,
            if (useCache && cacheDuration != null) 'maxStale': cacheDuration,
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future post(
      String path, {
        Object? data,
        bool isFromData = false,
        Map<String, dynamic>? queryParameters,
        bool withAuth = true,  Options ?options,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: await _buildHeaders(withAuth: withAuth),
          contentType: isFromData ? 'multipart/form-data' : 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future patch(
      String path, {
        Object? data,
        bool isFromData = false,
        Map<String, dynamic>? queryParameters,
        bool withAuth = true,
      }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: await _buildHeaders(withAuth: withAuth),
          contentType: isFromData ? 'multipart/form-data' : 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future delete(
      String path, {
        Object? data,
        bool isFromData = false,
        Map<String, dynamic>? queryParameters,
        bool withAuth = true,
      }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: await _buildHeaders(withAuth: withAuth),
          contentType: 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future put(
      String path, {
        Object? data,
        bool isFromData = false,
        Map<String, dynamic>? queryParameters,
        bool withAuth = true,
      }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: await _buildHeaders(withAuth: withAuth),
          contentType: isFromData ? 'multipart/form-data' : 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  void handleDioExceptions(DioException e) {
    if (e.response != null) {
      print('Dio error: ${e.response!.statusCode} - ${e.response!.data}');
    } else {
      print('Dio error: ${e.message}');
    }
  }
}