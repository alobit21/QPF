import 'package:go_router/go_router.dart';
import '../../features/spaces/presentation/screens/home_discover_screen.dart';
import '../../features/spaces/presentation/screens/office_details_screen.dart';
import '../../features/spaces/presentation/screens/search_results_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeDiscoverScreen(),
    ),
    GoRoute(
      path: '/office-details',
      builder: (context, state) => const OfficeDetailsScreen(),
    ),
    GoRoute(
      path: '/search-results',
      builder: (context, state) => const SearchResultsScreen(),
    ),
  ],
);
