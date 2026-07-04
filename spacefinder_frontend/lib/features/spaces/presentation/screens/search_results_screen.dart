import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../providers/office_provider.dart';
import '../../domain/office_model.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final officesAsyncValue = ref.watch(officesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSearch(context),
            _buildFilters(),
            _buildListMapToggle(officesAsyncValue),
            _buildSortBy(),
            Expanded(
              child: _buildResultsList(context, officesAsyncValue),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildTopSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1)),
                ],
              ),
              child: const Icon(Icons.arrow_back, size: 18, color: AppColors.foreground),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1)),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 16, color: AppColors.mutedForeground),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Coworking in Dodoma', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                  ),
                  const Icon(Icons.close, size: 16, color: AppColors.mutedForeground),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip('All', isActive: true),
          _buildFilterChip('Price', icon: Icons.local_offer_outlined, hasChevron: true),
          _buildFilterChip('Rating', icon: Icons.star_border, hasChevron: true),
          _buildFilterChip('Amenities', icon: Icons.grid_view, hasChevron: true),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false, IconData? icon, bool hasChevron = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: isActive ? AppColors.primaryForeground : AppColors.foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.primaryForeground : AppColors.foreground,
            ),
          ),
          if (hasChevron) ...[
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.mutedForeground),
          ],
        ],
      ),
    );
  }

  Widget _buildListMapToggle(AsyncValue<List<Office>> officesAsyncValue) {
    final countText = officesAsyncValue.maybeWhen(
      data: (offices) => '${offices.length} ',
      orElse: () => '... ',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: countText, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.foreground, fontSize: 14)),
                const TextSpan(text: 'spaces found', style: TextStyle(color: AppColors.mutedForeground, fontSize: 14)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: const [
                      Icon(Icons.list, size: 14, color: AppColors.primaryForeground),
                      SizedBox(width: 4),
                      Text('List', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryForeground)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: const [
                      Icon(Icons.map_outlined, size: 14, color: AppColors.mutedForeground),
                      SizedBox(width: 4),
                      Text('Map', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortBy() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          const Text('Sort by:', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: const [
                Text('Recommended', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 12, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(BuildContext context, AsyncValue<List<Office>> officesAsyncValue) {
    return officesAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error loading results: $e', style: const TextStyle(color: Colors.red))),
      data: (offices) {
        if (offices.isEmpty) {
          return const Center(
            child: Text(
              'No spaces found for this search.',
              style: TextStyle(color: AppColors.mutedForeground),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          itemCount: offices.length,
          itemBuilder: (context, index) {
            final space = offices[index];
            final image = (space.images != null && space.images!.isNotEmpty) 
                ? space.images!.first 
                : 'https://storage.googleapis.com/banani-generated-images/generated-images/2fa80919-a285-4482-93ed-60cb955006d7.jpg';
            
            // Hardcode amenities based on active status for placeholder purposes
            final mockAmenities = [Icons.wifi, Icons.local_cafe, Icons.monitor];

            return GestureDetector(
              onTap: () => context.push('/office-details?id=${space.id}'), // Pass ID dynamically
              child: Container(
                height: 110,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                      child: Image.network(
                        image,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(width: 110, height: 110, color: AppColors.muted),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(space.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 10, color: AppColors.mutedForeground),
                                    const SizedBox(width: 4),
                                    Expanded(child: Text(space.city, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: mockAmenities.map((icon) {
                                return Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(4)),
                                  child: Icon(icon, size: 13, color: AppColors.primary),
                                );
                              }).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.star, size: 12, color: AppColors.warning),
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
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
