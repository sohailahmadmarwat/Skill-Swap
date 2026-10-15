import 'package:flutter/material.dart';

void main() => runApp(const SkillSwapApp());

// ---------------------------------------------------------------
// App (one MaterialApp, one theme)
// To see a different screen, change the home: line below and run.
// Screens: SplashScreen, LoginScreen, HomeScreen,
//          StudentDetailScreen, AddSkillScreen
// ---------------------------------------------------------------
class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill-Swap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        // same AppBar color on every screen
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(), // <-- change this to show other screens
    );
  }
}

// ---------------------------------------------------------------
// Reusable widget for the main entity: Student
// Fields: name, department, teaches, wants, rating, image
// ---------------------------------------------------------------
class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.name,
    required this.department,
    required this.teaches,
    required this.wants,
    required this.rating,
    required this.image,
  });

  final String name;
  final String department;
  final String teaches;
  final String wants;
  final double rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(image, width: 70, height: 70),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(department),
                  const SizedBox(height: 6),
                  Text('Teaches: $teaches'),
                  Text('Wants: $wants'),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text('$rating'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Screen 1: Splash
// ---------------------------------------------------------------
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 20),
            const Text(
              'Skill-Swap',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Teach what you know. Learn what you want.',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Screen 2: Login (look only)
// ---------------------------------------------------------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', width: 120, height: 120),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            const Text('Do not have an account? Sign up'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Screen 3: Home (browse students)
// ---------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill-Swap'),
        actions: const [
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/banner.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Suggested Matches',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // the same widget used 4 times with different dummy data
            StudentCard(
              name: 'Ali Raza',
              department: 'BCS - 4th Semester',
              teaches: 'Flutter',
              wants: 'Graphic Design',
              rating: 4.8,
              image: 'assets/images/student1.png',
            ),
            StudentCard(
              name: 'Sara Khan',
              department: 'BBA - 6th Semester',
              teaches: 'Graphic Design',
              wants: 'Python',
              rating: 4.5,
              image: 'assets/images/student2.png',
            ),
            StudentCard(
              name: 'Hamza Malik',
              department: 'BEE - 2nd Semester',
              teaches: 'Guitar',
              wants: 'English Speaking',
              rating: 4.2,
              image: 'assets/images/student3.png',
            ),
            StudentCard(
              name: 'Zainab Ahmed',
              department: 'BSE - 8th Semester',
              teaches: 'English Speaking',
              wants: 'Web Development',
              rating: 4.9,
              image: 'assets/images/student4.png',
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Screen 4: Student Detail
// ---------------------------------------------------------------
class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/images/student1.png', width: 120, height: 120),
            const SizedBox(height: 12),
            const Text(
              'Ali Raza',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('BCS - 4th Semester'),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.orange),
                Text('4.8 (12 swaps)'),
              ],
            ),
            const SizedBox(height: 16),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Can teach'),
                    subtitle: Text('Flutter, Dart'),
                  ),
                  ListTile(
                    leading: Icon(Icons.lightbulb),
                    title: Text('Wants to learn'),
                    subtitle: Text('Graphic Design'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Contact'),
                    subtitle: Text('Visible after request is accepted'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Send Request'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Schedule'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Screen 5: Add Skill / Profile Setup form (look only)
// ---------------------------------------------------------------
class AddSkillScreen extends StatelessWidget {
  const AddSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Setup')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Department / Year',
                prefixIcon: Icon(Icons.apartment),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Skill I can teach',
                prefixIcon: Icon(Icons.school),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Skill I want to learn',
                prefixIcon: Icon(Icons.lightbulb),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save Profile'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
