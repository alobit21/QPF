import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_router.dart';
import 'core/constants/app_colors.dart';
import 'core/providers/shared_prefs_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const SpaceFinderApp(),
    ),
  );
}

class SpaceFinderApp extends StatelessWidget {
  const SpaceFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Space Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'DM Sans', // Set the font family from the design
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
