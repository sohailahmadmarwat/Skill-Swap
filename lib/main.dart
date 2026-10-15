import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/student_detail_screen.dart';
import 'screens/add_skill_screen.dart';
import 'theme/colors.dart';

void main() => runApp(const SkillSwapApp());

// Root widget configuring MaterialApp and screen routes
class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill-Swap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      // Starts on the Splash Screen
      initialRoute: '/',
      // Screen routes allowing tap-to-navigate everywhere
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/student-detail': (context) => const StudentDetailScreen(),
        '/add-skill': (context) => const AddSkillScreen(),
      },
    );
  }
}
