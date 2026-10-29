import 'package:flutter/material.dart';
import '../theme/colors.dart';

// Screen 9: Scheduling Screen ("Schedule Session")
// Demonstrates: StatefulWidget, setState, GridView/Custom Calendar Grid,
// Row, Column, Container, Buttons, Icons, and Navigation.
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDay = 26; // Default active day matching mockup
  String _selectedTime = '5:00 PM'; // Default active time matching mockup

  final List<String> _timeSlots = [
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
  ];

  final List<String> _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Schedule Session',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Box Container matching Screen 9
            Container(
              padding: const EdgeInsets.all(18),
              decoration: AppColors.glassBoxDecoration(radius: 20),
              child: Column(
                children: [
                  // Month Header with Prev & Next Arrows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.white),
                        onPressed: () {},
                      ),
                      const Text(
                        'April 2025',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Weekday Header Row: Sun, Mon, Tue...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _weekdays.map((day) {
                      return SizedBox(
                        width: 36,
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // 30 Days Grid for April 2025
                  // April 2025 starts on Tuesday (offset = 2)
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      // Leading offset spaces (Sun, Mon)
                      for (int i = 0; i < 2; i++)
                        const SizedBox(width: 36, height: 36),
                      // Days 1 through 30
                      for (int day = 1; day <= 30; day++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDay = day;
                            });
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: _selectedDay == day
                                  ? AppColors.primaryGradient
                                  : null,
                              border: Border.all(
                                color: _selectedDay == day
                                    ? AppColors.accentCyan
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                              boxShadow: _selectedDay == day
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                '$day',
                                style: TextStyle(
                                  color: _selectedDay == day
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: _selectedDay == day
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // "Select Time" Title
            const Text(
              'Select Time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),

            // Time Slots Row matching Screen 9: 4:00 PM, 5:00 PM, 6:00 PM, 7:00 PM, 8:00 PM
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _timeSlots.map((time) {
                  final isSelected = _selectedTime == time;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient : null,
                        color: isSelected ? null : const Color(0x80161536),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.accentCyan : AppColors.cardBorder,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),

            // Confirm Gradient Button
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.cardBg,
                      content: Text(
                        'Session Confirmed for April $_selectedDay, 2025 at $_selectedTime!',
                        style: const TextStyle(color: AppColors.accentCyan),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
