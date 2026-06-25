import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/spaces/presentation/screens/office_details_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SpaceFinderApp(),
    ),
  );
}

class SpaceFinderApp extends StatelessWidget {
  const SpaceFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'DM Sans', // Set the font family from the design
        useMaterial3: true,
      ),
      home: const OfficeDetailsScreen(),
    );
  }
}
