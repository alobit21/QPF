import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  _buildInfoBanner(),
                  const SizedBox(height: 16),
                  _buildBookingCard(
                    title: 'Dodoma Tech Hub',
                    location: 'Dodoma, Tanzania',
                    date: 'Mon, 22 Jan 2024',
                    time: '09:00 - 11:00',
                    cost: '16',
                    image: 'https://storage.googleapis.com/banani-generated-images/generated-images/2fa80919-a285-4482-93ed-60cb955006d7.jpg',
                  ),
                  const SizedBox(height: 16),
                  _buildBookingCard(
                    title: 'InnoSpace Mwanza',
                    location: 'Mwanza, Tanzania',
                    date: 'Wed, 24 Jan 2024',
                    time: '14:00 - 17:00',
                    cost: '21',
                    image: 'https://storage.googleapis.com/banani-generated-images/generated-images/88916177-1582-4821-95b1-dab2054963b2.jpg',
                  ),
                  const SizedBox(height: 24),
                  _buildSummaryCard(
                    title: '1 Accepted Booking',
                    subtitle: 'Creative Space Arusha · Fri 19 Jan · 10:00–14:00',
                    actionText: 'View All Accepted',
                    icon: Icons.check_circle_outline,
                    backgroundColor: AppColors.success.withOpacity(0.1),
                    iconColor: AppColors.success,
                    borderColor: AppColors.success,
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryCard(
                    title: '2 Completed Bookings',
                    subtitle: 'Dar Hub Central, Kilimanjaro Works',
                    actionText: 'View History',
                    icon: Icons.history,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    iconColor: AppColors.primary,
                    borderColor: AppColors.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('My Bookings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.foreground)),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(Icons.tune, size: 20, color: AppColors.foreground),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTab('Pending', count: '2', isActive: true)),
          Expanded(child: _buildTab('Accepted', count: '1', isActive: false)),
          Expanded(child: _buildTab('Completed', count: '2', isActive: false)),
        ],
      ),
    );
  }

  Widget _buildTab(String label, {required String count, required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? AppColors.primaryForeground : AppColors.mutedForeground)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? AppColors.warning : AppColors.border,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(count, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? AppColors.primaryForeground : AppColors.mutedForeground)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Your booking requests are awaiting approval from the space owner.',
              style: TextStyle(fontSize: 12, color: AppColors.primary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard({required String title, required String location, required String date, required String time, required String cost, required String image}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(height: 120, color: AppColors.muted),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Pending', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.warningForeground)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.mutedForeground),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: AppColors.mutedForeground),
                          const SizedBox(width: 4),
                          Text(date, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: AppColors.mutedForeground),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Cost', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                    Text('\$$cost', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: AppColors.foreground, fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('View Details', style: TextStyle(color: AppColors.primaryForeground, fontWeight: FontWeight.w600, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({required String title, required String subtitle, required String actionText, required IconData icon, required Color backgroundColor, required Color iconColor, required Color borderColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(actionText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}
