import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/shared_prefs_provider.dart';
import '../../data/auth_repository.dart';
import '../../domain/user_model.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final token = prefs.getString('access_token');
    
    if (token != null) {
      try {
        final user = await ref.read(authRepositoryProvider).getProfile();
        return user;
      } catch (e) {
        // Token invalid or expired
        await prefs.remove('access_token');
        return null;
      }
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(authRepositoryProvider).login(email, password);
      final token = res['access_token'];
      
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('access_token', token);
      
      return await ref.read(authRepositoryProvider).getProfile();
    });
  }

  Future<void> register(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(authRepositoryProvider).register(data);
      final token = res['access_token'];
      
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString('access_token', token);
      
      return await ref.read(authRepositoryProvider).getProfile();
    });
  }

  Future<void> logout() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove('access_token');
    state = const AsyncValue.data(null);
  }
}
