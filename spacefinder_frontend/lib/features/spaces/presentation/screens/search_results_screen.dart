import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSearch(context),
            _buildFilters(),
            _buildListMapToggle(),
            _buildSortBy(),
            Expanded(
              child: _buildResultsList(context),
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

  Widget _buildListMapToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: '24 ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.foreground, fontSize: 14)),
                TextSpan(text: 'spaces found', style: TextStyle(color: AppColors.mutedForeground, fontSize: 14)),
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

  Widget _buildResultsList(BuildContext context) {
    final results = [
      {
        'title': 'Dodoma Tech Hub',
        'location': 'Dodoma, Tanzania',
        'image': 'https://storage.googleapis.com/banani-generated-images/generated-images/2fa80919-a285-4482-93ed-60cb955006d7.jpg',
        'rating': '4.8',
        'reviews': '124',
        'price': '8',
        'amenities': [Icons.wifi, Icons.monitor, Icons.print],
      },
      {
        'title': 'Creative Space Arusha',
        'location': 'Arusha, Tanzania',
        'image': 'https://storage.googleapis.com/banani-generated-images/generated-images/eaed6f24-7bf7-474f-b9f4-9a0cb105c4bf.jpg',
        'rating': '4.7',
        'reviews': '98',
        'price': '10',
        'amenities': [Icons.wifi, Icons.videocam, Icons.local_cafe],
      },
      {
        'title': 'Dar Hub Central',
        'location': 'Dar es Salaam, Tanzania',
        'image': 'https://storage.googleapis.com/banani-generated-images/generated-images/b64a87cf-e206-4fa0-89e6-ffecc368ed3b.jpg',
        'rating': '4.9',
        'reviews': '210',
        'price': '12',
        'amenities': [Icons.wifi, Icons.monitor, Icons.phone],
      },
      {
        'title': 'InnoSpace Mwanza',
        'location': 'Mwanza, Tanzania',
        'image': 'https://storage.googleapis.com/banani-generated-images/generated-images/88916177-1582-4821-95b1-dab2054963b2.jpg',
        'rating': '4.5',
        'reviews': '56',
        'price': '7',
        'amenities': [Icons.wifi, Icons.print, Icons.local_cafe],
      },
      {
        'title': 'Kilimanjaro Works',
        'location': 'Moshi, Tanzania',
        'image': 'https://storage.googleapis.com/banani-generated-images/generated-images/f984e8e9-7943-487a-8a85-ee0d5f1ef74e.jpg',
        'rating': '4.6',
        'reviews': '73',
        'price': '9',
        'amenities': [Icons.wifi, Icons.videocam, Icons.monitor],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return GestureDetector(
          onTap: () => context.push('/office-details'),
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
                    item['image'] as String,
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
                            Text(item['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 10, color: AppColors.mutedForeground),
                                const SizedBox(width: 4),
                                Expanded(child: Text(item['location'] as String, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: (item['amenities'] as List<IconData>).map((icon) {
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
                              children: [
                                const Icon(Icons.star, size: 12, color: AppColors.warning),
                                const SizedBox(width: 4),
                                Text(item['rating'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                                const SizedBox(width: 4),
                                Text('(${item['reviews']})', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\$${item['price']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
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
  }
}
