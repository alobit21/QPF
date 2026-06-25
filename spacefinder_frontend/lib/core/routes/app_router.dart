import 'package:go_router/go_router.dart';
import '../../features/spaces/presentation/screens/home_discover_screen.dart';
import '../../features/spaces/presentation/screens/office_details_screen.dart';
import '../../features/spaces/presentation/screens/search_results_screen.dart';
import '../../features/bookings/presentation/screens/my_bookings_screen.dart';
import '../../features/bookings/presentation/screens/book_slot_screen.dart';

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
    GoRoute(
      path: '/bookings',
      builder: (context, state) => const MyBookingsScreen(),
    ),
    GoRoute(
      path: '/book-slot',
      builder: (context, state) => const BookSlotScreen(),
    ),
  ],
);
