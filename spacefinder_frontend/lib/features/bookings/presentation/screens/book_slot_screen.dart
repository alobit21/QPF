import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class BookSlotScreen extends StatelessWidget {
  const BookSlotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  _buildCalendar(),
                  const SizedBox(height: 24),
                  _buildSelectRoom(),
                  const SizedBox(height: 24),
                  _buildTimeSlots(),
                  const SizedBox(height: 24),
                  _buildDuration(),
                  const SizedBox(height: 24),
                  _buildPriceSummary(),
                  const SizedBox(height: 24),
                  _buildProceedButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2), // Keep bookings tab active as per image
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            children: const [
              Text('Book a Slot', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Text('Dodoma Tech Hub', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
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

  Widget _buildSelectRoom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
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
              const Icon(Icons.desk, size: 20, color: AppColors.primary), // Close enough to the room icon
              const SizedBox(width: 12),
              const Text('Hot Desk', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              const SizedBox(width: 8),
              const Text('— 1 person', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              const Spacer(),
              const Text('\$8/hr', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.mutedForeground),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots() {
    final slots = [
      {'time': '08:00', 'status': 'available'},
      {'time': '09:00', 'status': 'selected'},
      {'time': '10:00', 'status': 'booked'},
      {'time': '11:00', 'status': 'selected'},
      {'time': '12:00', 'status': 'available'},
      {'time': '13:00', 'status': 'booked'},
      {'time': '14:00', 'status': 'available'},
      {'time': '15:00', 'status': 'available'},
      {'time': '16:00', 'status': 'available'},
      {'time': '17:00', 'status': 'booked'},
      {'time': '18:00', 'status': 'available'},
      {'time': '19:00', 'status': 'available'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Time Slots', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.foreground)),
            Row(
              children: [
                _buildLegend(AppColors.primary, 'Selected'),
                const SizedBox(width: 12),
                _buildLegend(AppColors.border, 'Booked'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: slots.length,
          itemBuilder: (context, index) {
            final slot = slots[index];
            final status = slot['status'];
            final time = slot['time'];
            
            Color bgColor = AppColors.card;
            Color textColor = AppColors.foreground;
            Color borderColor = AppColors.border;

            if (status == 'selected') {
              bgColor = AppColors.primary;
              textColor = AppColors.primaryForeground;
              borderColor = AppColors.primary;
            } else if (status == 'booked') {
              bgColor = AppColors.border.withOpacity(0.5);
              textColor = AppColors.mutedForeground;
              borderColor = Colors.transparent;
            }

            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
              ),
              child: Text(time!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor)),
            );
          },
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

  Widget _buildPriceSummary() {
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
            children: const [
              Text('Hot Desk × 2 hrs', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              Text('\$16.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
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
            children: const [
              Text('Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.foreground)),
              Text('\$17.50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return Container(
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
    );
  }
}
