import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/student_detail_screen.dart';
import 'screens/matching_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/request_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/rating_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'theme/colors.dart';

// main(): Entry point, arrow function (=>) starts the SkillSwap application.
// Demonstrates: Dart main() entry point, arrow syntax, and runApp.
void main() => runApp(const SkillSwapApp());

// StatelessWidget: Root widget configuring MaterialApp, theme, and named routes.
// Demonstrates: StatelessWidget, MaterialApp, ThemeData, ColorScheme,
// and Navigator routing table using Dart Maps.
class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillSwap',
      debugShowCheckedModeBanner: false,
      // Dark Neon Theme configuration
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accentCyan,
          surface: AppColors.surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      // Global cosmic neon gradient behind all screens (glass effect)
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },
      // Starts on the Splash Screen
      initialRoute: '/',
      // Navigation: Named routes map connecting all 13 screens seamlessly
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/student-detail': (context) => const StudentDetailScreen(),
        '/my-profile': (context) => const StudentDetailScreen(isMyProfile: true),
        '/match': (context) => const MatchingScreen(),
        '/chat': (context) => const ChatScreen(),
        '/request': (context) => const RequestScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/rating': (context) => const RatingScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/add-skill': (context) => const EditProfileScreen(),
      },
    );
  }
}
