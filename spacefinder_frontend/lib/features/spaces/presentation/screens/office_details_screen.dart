import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../providers/office_provider.dart';
import '../../domain/office_model.dart';
import '../../domain/amenity_model.dart';
import '../../domain/slot_model.dart';

class OfficeDetailsScreen extends ConsumerWidget {
  final String officeId;
  const OfficeDetailsScreen({Key? key, required this.officeId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (officeId.isEmpty) return const Scaffold(body: Center(child: Text('Invalid Office ID')));

    final officeAsync = ref.watch(officeDetailsProvider(officeId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: officeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
          data: (office) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageHeader(context, office),
                        _buildTitleAndRating(office),
                        _buildBadges(),
                        _buildAmenities(office.amenities),
                        _buildAvailableRooms(context, office),
                        _buildReviews(),
                      ],
                    ),
                  ),
                ),
                _buildStickyBookingBar(context, office),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // Explore tab selected based on design
    );
  }

  Widget _buildImageHeader(BuildContext context, Office office) {
    final imageUrl = (office.images != null && office.images!.isNotEmpty) 
        ? office.images!.first 
        : 'https://storage.googleapis.com/banani-generated-images/generated-images/823dbf9f-229c-4617-b6af-ca32ee681b99.jpg';
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: 230,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(height: 230, color: AppColors.muted),
        ),
        Positioned(
          top: 12,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildIconButton(Icons.arrow_back, onTap: () => context.pop()),
              Row(
                children: [
                  _buildIconButton(Icons.favorite_border),
                  const SizedBox(width: 8),
                  _buildIconButton(Icons.share_outlined),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(isActive: true),
              _buildDot(isActive: false),
              _buildDot(isActive: false),
              _buildDot(isActive: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.card.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Icon(icon, size: 18, color: icon == Icons.arrow_back ? AppColors.foreground : AppColors.mutedForeground),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.card : AppColors.card.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildTitleAndRating(Office office) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  office.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.foreground, height: 1.2),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 13, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text('${office.city}, Tanzania', style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                    ),
                  ],
                ),
                if (office.description.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    office.description,
                    style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground, height: 1.4),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: const [
                    Icon(Icons.star, size: 13, color: AppColors.primaryForeground),
                    SizedBox(width: 4),
                    Text('4.8', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryForeground)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text('124 reviews', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(4)),
            child: const Text('Open Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondaryForeground)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(4)),
            child: const Text('24/7 Access', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondaryForeground)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(4)),
            child: const Text('50 Seats', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenities(List<Amenity>? amenities) {
    if (amenities == null || amenities.isEmpty) {
      return const SizedBox();
    }

    // Helper map for string to IconData
    IconData getIcon(String name) {
      switch (name.toLowerCase()) {
        case 'wifi': return Icons.wifi;
        case 'monitor': return Icons.monitor;
        case 'print': return Icons.print;
        case 'coffee': return Icons.local_cafe;
        case 'video': return Icons.videocam;
        case 'lock': return Icons.lock;
        case 'parking': return Icons.directions_car;
        case 'phone': return Icons.phone;
        default: return Icons.check_circle_outline;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Amenities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: amenities.length,
            itemBuilder: (context, index) {
              final amenity = amenities[index];
              return Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(8)),
                    child: Icon(getIcon(amenity.icon), color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(amenity.name, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRooms(BuildContext context, Office office) {
    final slots = office.slots;
    if (slots == null || slots.isEmpty) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text('No available rooms right now.', style: TextStyle(color: AppColors.mutedForeground)),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Available Rooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
          const SizedBox(height: 12),
          ...slots.where((s) => s.isAvailable).map((slot) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(slot.roomNumber, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 11, color: AppColors.mutedForeground),
                            const SizedBox(width: 4),
                            Text('${slot.startTime} - ${slot.endTime} · ', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            const Text('Available', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.success)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/book-slot?officeId=${office.id}&slotId=${slot.id}');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: const Text('Book', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    final reviews = [
      {'name': 'Amina H.', 'date': 'Jan 2024', 'text': 'Amazing space! Super fast WiFi and very clean.', 'img': 'https://storage.googleapis.com/banani-avatars/avatar/female/25-35/African/1'},
      {'name': 'David M.', 'date': 'Dec 2023', 'text': 'Great location and helpful staff. Will come back!', 'img': 'https://storage.googleapis.com/banani-avatars/avatar/male/35-50/African/2'},
      {'name': 'Sara K.', 'date': 'Dec 2023', 'text': 'Perfect for deep work sessions. Love the vibe.', 'img': 'https://storage.googleapis.com/banani-avatars/avatar/female/18-25/East Asian/3'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Text('See All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 12),
          ...reviews.map((review) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(review['img']!),
                            backgroundColor: AppColors.muted,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                              Text(review['date']!, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(5, (index) => const Icon(Icons.star, size: 12, color: AppColors.warning)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(review['text']!, style: const TextStyle(fontSize: 14, color: AppColors.foreground, height: 1.4)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStickyBookingBar(BuildContext context, Office office) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${office.pricePerHour ?? 0}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  const Text('/hr · From', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.star, size: 14, color: AppColors.warning),
                  SizedBox(width: 4),
                  Text('4.8', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                  SizedBox(width: 4),
                  Text('(124)', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // Pass the first available slot as a quick book option
              final firstAvailable = office.slots?.firstWhere((s) => s.isAvailable);
              if (firstAvailable != null) {
                context.push('/book-slot?officeId=${office.id}&slotId=${firstAvailable.id}');
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.calendar_month, color: AppColors.accentForeground, size: 18),
                  SizedBox(width: 8),
                  Text('Book Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accentForeground)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
