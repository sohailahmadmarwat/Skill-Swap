import 'package:flutter/material.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import 'user_avatar.dart';

// Screen 13 in Mockup: Navigation Drawer / Sidebar
// Demonstrates: Drawer, ListView, ListTile, CircleAvatar (first-letter fallback),
// Row, Column, Container, Icons, Buttons, and Navigation.
class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, this.currentRoute = '/home'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Header Container with user profile (Clickable -> Opens My Profile)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/my-profile');
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF261D52), AppColors.surface],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    // User Avatar with dynamic first letter fallback for logged-in user
                    UserAvatar(
                      name: UserSession.currentUser.name,
                      image: UserSession.currentUser.image,
                      radius: 28,
                      showGlow: true,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserSession.currentUser.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            UserSession.currentUser.department,
                            style: TextStyle(
                              color: AppColors.accentCyan.withValues(
                                alpha: 0.9,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(color: AppColors.cardBorder, height: 1),

          // Menu List of ListTiles
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  isSelected: currentRoute == '/home',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != '/home') {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.person_outline,
                  title: 'My Profile',
                  isSelected: currentRoute == '/my-profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/my-profile');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.swap_horiz,
                  title: 'My Requests',
                  isSelected: currentRoute == '/request',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/request');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.chat_bubble_outline,
                  title: 'Messages',
                  badge: '1',
                  isSelected: currentRoute == '/messages',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/messages');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  isSelected: currentRoute == '/edit-profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Help & Support: support@skillswap.edu'),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(color: AppColors.cardBorder),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  title: 'Log Out',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),

          // Footer with mountain landscape aesthetic and slogan
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.surface, const Color(0xFF1D1B42)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.terrain,
                      color: AppColors.primaryLight,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'SkillSwap Platform',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Better Skills,\nBigger Opportunities',
                  style: TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget function for each Drawer ListTile
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? badge,
    bool isSelected = false,
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    final activeColor = isDestructive
        ? Colors.redAccent
        : (isSelected ? AppColors.accentCyan : AppColors.textSecondary);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.4))
            : null,
      ),
      child: ListTile(
        leading: Icon(icon, color: activeColor, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.redAccent : AppColors.textPrimary,
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
