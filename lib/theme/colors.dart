import 'package:flutter/material.dart';

// AppColors stores all color constants used across the app in one place
class AppColors {
  // Primary teal brand color
  static const Color teal = Color(0xFF00897B);

  // Lighter teal/green used for AppBar and background gradients
  static const Color tealLight = Color(0xFF26A69A);

  // Secondary orange accent color
  static const Color orange = Color(0xFFFF8F00);

  // Soft background color for scaffolds
  static const Color background = Color(0xFFF5F7F6);

  // Common gradient used across AppBars
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [teal, tealLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
