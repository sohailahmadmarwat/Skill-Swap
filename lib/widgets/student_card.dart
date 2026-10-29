import 'package:flutter/material.dart';
import '../models/student.dart';
import '../theme/colors.dart';
import 'user_avatar.dart';

// Reusable StatelessWidget: Card displaying student information in dark neon glassmorphism.
// Demonstrates: StatelessWidget, Card, Row, Column, SizedBox, Container, CircleAvatar fallback,
// Buttons, Icons, GestureDetector, and Navigation.
class StudentCard extends StatelessWidget {
  final Student student;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onConnect;

  const StudentCard({
    super.key,
    required this.student,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    // Container with glassmorphism border and background
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: AppColors.glassBoxDecoration(radius: 18),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          // Navigation: Opens Student Profile with arguments
          onTap: () {
            Navigator.pushNamed(
              context,
              '/student-detail',
              arguments: student,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                // Top row: Avatar (first letter if no image), Info, and Actions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // UserAvatar with dynamic first-letter fallback
                    UserAvatar(
                      name: student.name,
                      image: student.image,
                      radius: 26,
                      showGlow: true,
                    ),
                    const SizedBox(width: 14),
                    // Expanded column with name and department
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            student.department,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Heart favorite toggle button
                    if (onFavoriteToggle != null)
                      GestureDetector(
                        onTap: onFavoriteToggle,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF23224B),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.redAccent : AppColors.textMuted,
                            size: 18,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    // Rating Badge (Container + Row + Icon + Text)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accentGold.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.accentGold,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            student.ratingLabel,
                            style: const TextStyle(
                              color: AppColors.accentGold,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Bottom row: Teaches pill, swap icon, Wants pill
                Row(
                  children: [
                    Expanded(
                      child: _buildSkillPill(
                        label: 'Teaches',
                        value: student.teaches,
                        color: AppColors.primary,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.swap_horiz,
                        color: AppColors.accentCyan,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: _buildSkillPill(
                        label: 'Wants',
                        value: student.wants,
                        color: AppColors.accentPink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget function returning a styled skill container
  Widget _buildSkillPill({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
