import 'package:flutter/material.dart';

// AppColors: Centralized color constants defining our futuristic dark neon palette.
// Dart Classes & static const properties.
class AppColors {
  // Deep space dark background colors
  static const Color background = Color(0xFF0B0B1E);
  static const Color surface = Color(0xFF13132B);
  static const Color cardBg = Color(0xFF181738);
  static const Color cardBorder = Color(0xFF2E2C60);

  // Vibrant neon brand gradients & primary colors
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFF8A2BE2);
  static const Color secondary = Color(0xFF5352ED);
  static const Color accentCyan = Color(0xFF00D2D3);
  static const Color accentPink = Color(0xFFFF477E);
  static const Color accentGold = Color(0xFFFFC048);

  // Text & neutral colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9E9EC2);
  static const Color textMuted = Color(0xFF63658A);

  // Neon gradient used for primary CTAs and active states
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFF8A2BE2)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Subtle dark gradient for card surfaces
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x33302B63), Color(0x1F24243E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Banner gradient for the featured "Exchange Skills Not Money" card
  static const LinearGradient bannerGradient = LinearGradient(
    colors: [Color(0xFF4834D4), Color(0xFF686DE0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphic box decoration helper
  static BoxDecoration glassBoxDecoration({
    double radius = 16,
    Color? borderColor,
    Color? fillColor,
  }) {
    return BoxDecoration(
      color: fillColor,
      gradient: fillColor == null
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.10),
                const Color(0xFF6C5CE7).withValues(alpha: 0.08),
              ],
            )
          : null,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ?? const Color(0xFF7C6CFF).withValues(alpha: 0.55),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6C5CE7).withValues(alpha: 0.25),
          blurRadius: 14,
          spreadRadius: 0.5,
        ),
      ],
    );
  }
}

