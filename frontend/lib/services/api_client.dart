import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/constants.dart';
import 'auth_service.dart';

final apiClientProvider = FutureProvider((ref) async {
  final authService = ref.watch(authServiceProvider);
  return ApiClient(authService);
});

class ApiClient {
  final AuthService authService;
  late final Dio _dio;

  ApiClient(this.authService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000/api/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Add interceptor to include auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await authService.getIdToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          print('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<T> put<T>(
    String path, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
