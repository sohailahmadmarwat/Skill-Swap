import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 6: Matching Screen ("It's a Match!")
// Connected via navigation: Launches when a swap request is sent or match occurs.
// Demonstrates: StatelessWidget, SingleChildScrollView (prevents overflow on all screens),
// Container, Row, Column, UserAvatar fallback, Glassmorphism, ElevatedButton,
// OutlinedButton, Icons, and Navigation.
class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Matched peer passed from caller, with fallback to Sara Ahmed
    final student = (ModalRoute.of(context)?.settings.arguments as Student?) ??
        const Student(
          name: 'Sara Ahmed',
          department: 'SE - 2nd Year',
          teaches: 'Design • Figma',
          wants: 'Python • Web Dev',
          rating: 4.8,
          image: 'assets/images/student4.png',
        );

    // Active logged-in user from UserSession
    final user = UserSession.currentUser;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // SafeArea + LayoutBuilder + SingleChildScrollView guarantees ZERO overflow on all viewports
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Sparkles Icon
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.accentGold.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: AppColors.accentGold,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Title: It's a Match!
                          const Text(
                            "It's a Match!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Subtitle
                          const Text(
                            'You both have skills to exchange',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Dual Connected Avatars (Logged-in User <-> Matched Peer)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logged-in User (dynamically binds to UserSession)
                              Column(
                                children: [
                                  UserAvatar(
                                    name: user.name,
                                    image: user.image,
                                    radius: 32,
                                    showGlow: true,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${user.teaches} • Web Dev',
                                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                                  ),
                                ],
                              ),

                              // Exchange Icon between avatars
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.swap_horiz_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),

                              // Matched Peer (e.g. Sara Ahmed)
                              Column(
                                children: [
                                  UserAvatar(
                                    name: student.name,
                                    image: student.image,
                                    radius: 32,
                                    showGlow: true,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    student.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    student.teaches,
                                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Glass Card: Your skills match!
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: AppColors.glassBoxDecoration(radius: 18),
                            child: Column(
                              children: [
                                const Text(
                                  'Your skills match!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildMatchRow(
                                  icon: Icons.check_circle_rounded,
                                  color: AppColors.accentCyan,
                                  text: 'You teach: ${user.teaches}',
                                ),
                                const SizedBox(height: 8),
                                _buildMatchRow(
                                  icon: Icons.check_circle_rounded,
                                  color: AppColors.accentPink,
                                  text: 'You want: ${student.teaches}',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // "Start Chat" Gradient Button -> Navigates to ChatScreen
                          Container(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                                  blurRadius: 14,
                                  offset: const Offset(0, 3),
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
                                Navigator.pushNamed(context, '/chat', arguments: student);
                              },
                              child: const Text(
                                'Start Chat',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // "View Profile" Outlined Glass Button -> Navigates to Profile
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.cardBorder, width: 1.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/student-detail', arguments: student);
                              },
                              child: const Text(
                                'View Profile',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper match row
  Widget _buildMatchRow({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
