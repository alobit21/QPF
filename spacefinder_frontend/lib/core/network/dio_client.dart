import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shared_prefs_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_URL', defaultValue: 'http://127.0.0.1:3000'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  
  // Interceptor for Auth token
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final prefs = ref.read(sharedPreferencesProvider);
      final token = prefs.getString('access_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ));

  dio.interceptors.add(LogInterceptor(responseBody: true));
  
  return dio;
});
