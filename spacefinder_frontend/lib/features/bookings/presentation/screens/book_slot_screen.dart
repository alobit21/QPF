import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../spaces/presentation/providers/office_provider.dart';

class BookSlotScreen extends ConsumerWidget {
  final String officeId;
  final String slotId;

  const BookSlotScreen({
    Key? key,
    required this.officeId,
    required this.slotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (officeId.isEmpty || slotId.isEmpty) {
      return const Scaffold(body: Center(child: Text('Invalid Booking Info')));
    }

    final officeAsync = ref.watch(officeDetailsProvider(officeId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: officeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
          data: (office) {
            final slot = office.slots?.firstWhere((s) => s.id == slotId);
            if (slot == null) return const Center(child: Text('Slot not found'));

            return Column(
              children: [
                _buildHeader(context, office.name),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    children: [
                      _buildCalendar(),
                      const SizedBox(height: 24),
                      _buildSelectRoom(slot.roomNumber, office.pricePerHour ?? 0),
                      const SizedBox(height: 24),
                      _buildTimeSlots(slot.startTime, slot.endTime),
                      const SizedBox(height: 24),
                      _buildDuration(),
                      const SizedBox(height: 24),
                      _buildPriceSummary(slot.roomNumber, office.pricePerHour ?? 0),
                      const SizedBox(height: 24),
                      _buildProceedButton(context),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildHeader(BuildContext context, String officeName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.card,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
                ],
              ),
              child: const Icon(Icons.arrow_back, size: 20, color: AppColors.foreground),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Book a Slot', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Text(officeName, style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final days = [
      {'day': 'Mon', 'date': '22', 'isActive': false},
      {'day': 'Tue', 'date': '23', 'isActive': true},
      {'day': 'Wed', 'date': '24', 'isActive': false},
      {'day': 'Thu', 'date': '25', 'isActive': false},
      {'day': 'Fri', 'date': '26', 'isActive': false},
      {'day': 'Sat', 'date': '27', 'isActive': false},
      {'day': 'Sun', 'date': '28', 'isActive': false},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('January 2024', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Row(
                children: [
                  _buildCircleButton(Icons.chevron_left),
                  const SizedBox(width: 8),
                  _buildCircleButton(Icons.chevron_right),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((d) {
              final isActive = d['isActive'] as bool;
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(d['day'] as String, style: TextStyle(fontSize: 12, color: isActive ? AppColors.primaryForeground : AppColors.mutedForeground)),
                    const SizedBox(height: 8),
                    Text(d['date'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isActive ? AppColors.primaryForeground : AppColors.foreground)),
                    if (isActive) ...[
                      const SizedBox(height: 4),
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppColors.warning, shape: BoxShape.circle)),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, size: 16, color: AppColors.mutedForeground),
    );
  }

  Widget _buildSelectRoom(String roomNumber, double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selected Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.desk, size: 20, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(roomNumber, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              const Spacer(),
              Text('\$$price/hr', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots(String startTime, String endTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Time Slot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('$startTime - $endTime', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
      ],
    );
  }

  Widget _buildDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Duration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                child: const Icon(Icons.remove, size: 20, color: AppColors.foreground),
              ),
              const Text('2 hours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                child: const Icon(Icons.add, size: 20, color: AppColors.primaryForeground),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSummary(String roomNumber, double price) {
    final double total = price + 1.50; // Add fixed service fee for demo

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Price Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$roomNumber × 1 hr', style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Service Fee', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              Text('\$1.50', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // We will wire up the repository call here next!
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking flow coming right up!')),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.credit_card, color: AppColors.accentForeground, size: 18),
            SizedBox(width: 8),
            Text('Proceed to Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accentForeground)),
          ],
        ),
      ),
    );
  }
}
