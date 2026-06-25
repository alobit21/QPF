import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const CustomBottomNavBar({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 24), // Added bottom padding for safe area
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.home_rounded, label: 'Home', isSelected: currentIndex == 0),
          _buildNavItem(icon: Icons.search_rounded, label: 'Explore', isSelected: currentIndex == 1),
          _buildNavItem(icon: Icons.calendar_today_rounded, label: 'Bookings', isSelected: currentIndex == 2),
          _buildNavItem(icon: Icons.person_outline_rounded, label: 'Profile', isSelected: currentIndex == 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required bool isSelected}) {
    final color = isSelected ? AppColors.primary : AppColors.mutedForeground;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        if (isSelected) ...[
          const SizedBox(height: 4),
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ] else ...[
          // Spacer to keep layout balanced when not selected
          const SizedBox(height: 8),
        ]
      ],
    );
  }
}
