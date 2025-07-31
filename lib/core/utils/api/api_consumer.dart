abstract class ApiConsumer {
  Future<dynamic> get(
      String path, {
        Duration? cacheDuration,
        Map<String, dynamic>? queryParameters,
        bool useCache,
        bool withAuth,
      });

  Future<dynamic> post(
      String path, {
        Object? data,
        bool isFromData,
        Map<String, dynamic>? queryParameters,
        bool withAuth,
      });

  Future<dynamic> patch(
      String path, {
        Object? data,
        bool isFromData,
        Map<String, dynamic>? queryParameters,
        bool withAuth,
      });

  Future<dynamic> delete(
      String path, {
        Object? data,
        bool isFromData,
        Map<String, dynamic>? queryParameters,
        bool withAuth,
      });

  Future<dynamic> put(
      String path, {
        Object? data,
        bool isFromData,
        Map<String, dynamic>? queryParameters,
        bool withAuth,
      });

}