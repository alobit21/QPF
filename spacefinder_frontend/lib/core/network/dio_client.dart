import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shared_prefs_provider.dart';

String getBaseUrl() {
  const envUrl = String.fromEnvironment('API_URL');
  if (envUrl.isNotEmpty) {
    return envUrl;
  }
  if (kIsWeb) {
    return 'http://127.0.0.1:3000';
  }
  if (Platform.isAndroid) {
    // 192.168.0.107 is the host computer's local IP address for physical device debugging
    return 'http://192.168.0.107:3000';
  }
  return 'http://127.0.0.1:3000';
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: getBaseUrl(),
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
