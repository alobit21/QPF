import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class OfficeDetailsScreen extends StatelessWidget {
  const OfficeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageHeader(context),
                    _buildTitleAndRating(),
                    _buildBadges(),
                    _buildAmenities(),
                    _buildAvailableRooms(),
                    _buildReviews(),
                  ],
                ),
              ),
            ),
            _buildStickyBookingBar(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // Explore tab selected based on design
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://storage.googleapis.com/banani-generated-images/generated-images/823dbf9f-229c-4617-b6af-ca32ee681b99.jpg',
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
              _buildIconButton(Icons.arrow_back, onTap: () => Navigator.of(context).pop()),
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

  Widget _buildTitleAndRating() {
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
                const Text(
                  'Dodoma Tech Hub',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.foreground, height: 1.2),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 13, color: AppColors.primary),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text('Dodoma City Centre, Tanzania', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                    ),
                  ],
                ),
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

  Widget _buildAmenities() {
    final amenities = [
      {'icon': Icons.wifi, 'label': 'High-Speed WiFi'},
      {'icon': Icons.monitor, 'label': 'HD Monitors'},
      {'icon': Icons.print, 'label': 'Printer'},
      {'icon': Icons.local_cafe, 'label': 'Coffee Bar'},
      {'icon': Icons.videocam, 'label': 'Video Conf.'},
      {'icon': Icons.lock, 'label': '24/7 Access'},
      {'icon': Icons.directions_car, 'label': 'Parking'},
      {'icon': Icons.phone, 'label': 'Phone Booth'},
    ];

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
                    child: Icon(amenity['icon'] as IconData, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(amenity['label'] as String, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRooms() {
    final rooms = [
      {'title': 'Hot Desk', 'pax': '1', 'slots': '8', 'price': '8'},
      {'title': 'Private Office', 'pax': '4', 'slots': '3', 'price': '25'},
      {'title': 'Meeting Room A', 'pax': '8', 'slots': '2', 'price': '40'},
      {'title': 'Conference Hall', 'pax': '20', 'slots': '1', 'price': '80'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Available Rooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
          const SizedBox(height: 12),
          ...rooms.map((room) {
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
                        Text(room['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.people, size: 11, color: AppColors.mutedForeground),
                            const SizedBox(width: 4),
                            Text('Up to ${room['pax']} people · ', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            Text('${room['slots']} slots left', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.success)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${room['price']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      const Text('/hr', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                    ],
                  ),
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

  Widget _buildStickyBookingBar() {
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
                children: const [
                  Text('\$8', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text('/hr · From', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
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
          Container(
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
        ],
      ),
    );
  }
}
