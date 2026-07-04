import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../providers/office_provider.dart';
import '../../domain/office_model.dart';

class HomeDiscoverScreen extends ConsumerWidget {
  const HomeDiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final officesAsyncValue = ref.watch(officesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(context),
              _buildFilters(),
              _buildFeaturedSpaces(context, officesAsyncValue),
              const SizedBox(height: 16),
              _buildNearYou(context, officesAsyncValue),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Good Morning, Alex 👋',
                style: TextStyle(color: AppColors.mutedForeground, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                'Find Your Space',
                style: TextStyle(
                  color: AppColors.foreground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://storage.googleapis.com/banani-avatars/avatar/male/25-35/African/0'),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => context.push('/search-results'),
        child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.mutedForeground, size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Search coworking spaces...',
                style: TextStyle(color: AppColors.mutedForeground, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.tune, color: AppColors.primaryForeground, size: 16),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Location', 'Price', 'Amenities', 'Rating'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: filters.map((filter) {
          final isSelected = filter == 'All';
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
            ),
            child: Row(
              children: [
                if (filter == 'Location') ...[
                  const Icon(Icons.location_on_outlined, size: 14, color: AppColors.foreground),
                  const SizedBox(width: 4),
                ],
                if (filter == 'Price') ...[
                  const Icon(Icons.local_offer_outlined, size: 14, color: AppColors.foreground),
                  const SizedBox(width: 4),
                ],
                if (filter == 'Amenities') ...[
                  const Icon(Icons.grid_view, size: 14, color: AppColors.foreground),
                  const SizedBox(width: 4),
                ],
                if (filter == 'Rating') ...[
                  const Icon(Icons.star_outline, size: 14, color: AppColors.foreground),
                  const SizedBox(width: 4),
                ],
                Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryForeground : AppColors.foreground,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!isSelected) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.mutedForeground),
                ]
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedSpaces(BuildContext context, AsyncValue<List<Office>> officesAsyncValue) {
    return officesAsyncValue.when(
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
      error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      data: (offices) {
        if (offices.isEmpty) {
          return const Center(child: Text('No spaces available', style: TextStyle(color: AppColors.mutedForeground)));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Featured Spaces', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                  Text('See All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: offices.take(3).map((space) {
                  final image = (space.images != null && space.images!.isNotEmpty) 
                      ? space.images!.first 
                      : 'https://storage.googleapis.com/banani-generated-images/generated-images/41453429-4199-4d32-9dbd-47e5fe4a45ce.jpg';
                  return GestureDetector(
                    onTap: () => context.push('/office-details'),
                    child: Container(
                      width: 240,
                      margin: const EdgeInsets.only(right: 16, bottom: 12),
                      decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                image,
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(height: 140, color: AppColors.muted),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Popular', style: TextStyle(color: AppColors.primaryForeground, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: AppColors.card, shape: BoxShape.circle),
                                child: const Icon(Icons.favorite_border, size: 16, color: AppColors.mutedForeground),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(space.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: AppColors.mutedForeground),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text('${space.city}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.star, size: 14, color: AppColors.warning),
                                      SizedBox(width: 4),
                                      Text('4.8', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                                      SizedBox(width: 4),
                                      Text('(124)', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('\$${space.pricePerHour ?? 0}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      const Text('/hr', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
                }).toList(),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _buildNearYou(BuildContext context, AsyncValue<List<Office>> officesAsyncValue) {
    return officesAsyncValue.when(
      loading: () => const SizedBox(),
      error: (e, s) => const SizedBox(),
      data: (offices) {
        if (offices.length <= 3) return const SizedBox();
        final nearYouOffices = offices.skip(3).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                  Text('See All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 12),
              ...nearYouOffices.map((space) {
                final image = (space.images != null && space.images!.isNotEmpty) 
                    ? space.images!.first 
                    : 'https://storage.googleapis.com/banani-generated-images/generated-images/abc459d2-e1c8-448e-9414-b57e520658f1.jpg';
                return GestureDetector(
                  onTap: () => context.push('/office-details'),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                        child: Image.network(
                          image,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(width: 90, height: 90, color: AppColors.muted),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(space.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: AppColors.mutedForeground),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text('${space.city}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.star, size: 14, color: AppColors.warning),
                                      SizedBox(width: 4),
                                      Text('4.5', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('\$${space.pricePerHour ?? 0}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      const Text('/hr', style: TextStyle(fontSize: 10, color: AppColors.mutedForeground)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
