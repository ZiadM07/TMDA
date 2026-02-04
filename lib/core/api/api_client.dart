import 'package:dio/dio.dart';
import '../framework/app_preferance.dart';
import '../utils/error_utils.dart';
import 'api_endpoints.dart';

class ApiClient {
  final Dio _dio;
  final AppPreferences _prefs;

  ApiClient(this._dio, this._prefs) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sessionId = await _prefs.getSessionId();

          options.queryParameters.addAll({
            'api_key': ApiEndpoints.apiKey,
            if (sessionId.isNotEmpty) 'session_id': sessionId,
          });

          return handler.next(options);
        },
        onError: (error, handler) {
          ErrorUtils.logError(error, context: 'ApiClient');
          return handler.next(error);
        },
      ),
    );
  }

  // ==========================
  // GENERIC HTTP METHODS
  // ==========================

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) {
    return _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? query,
    dynamic body,
  }) {
    return _dio.post<T>(path, queryParameters: query, data: body);
  }

  Future<Response<T>> delete<T>(String path, {Map<String, dynamic>? query}) {
    return _dio.delete<T>(path, queryParameters: query);
  }

  // ==========================
  // PAGINATION HELPERS
  // ==========================

  Future<Response> getPaginated(
    String path, {
    required int page,
    Map<String, dynamic>? query,
  }) {
    return get(path, query: {'page': page, ...?query});
  }

  Future<Response> searchPaginated(
    String path, {
    required String queryText,
    required int page,
    bool includeAdult = false,
  }) {
    return get(
      path,
      query: {'query': queryText, 'page': page, 'include_adult': includeAdult},
    );
  }
}
