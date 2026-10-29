import 'package:flutter/material.dart';
import '../theme/colors.dart';

// StatelessWidget: Reusable avatar with dynamic first-letter fallback.
// If the student/user does NOT have an image, it renders their name's first letter.
// Flutter Widgets: StatelessWidget, CircleAvatar, Container, Text, BoxDecoration.
class UserAvatar extends StatelessWidget {
  final String name;
  final String? image;
  final double radius;
  final bool showGlow;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.name,
    this.image,
    this.radius = 24,
    this.showGlow = false,
    this.onTap,
  });

  // Function with conditional operator to get first letter safely
  String _getFirstLetter(String val) {
    final clean = val.trim();
    return clean.isNotEmpty ? clean[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null && image!.trim().isNotEmpty;
    final initial = _getFirstLetter(name);

    final avatar = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Conditional operator: Add neon glow border if showGlow is true
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : null,
        border: Border.all(
          color: showGlow ? AppColors.accentCyan : AppColors.cardBorder,
          width: showGlow ? 2.0 : 1.2,
        ),
      ),
      // CircleAvatar: displays image if present, otherwise displays first letter of name
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primary,
        backgroundImage: hasImage ? AssetImage(image!) : null,
        child: !hasImage
            ? Text(
                initial,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: radius * 0.9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              )
            : null,
      ),
    );

    // If onTap is provided, wrap with GestureDetector
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }
    return avatar;
  }
}
