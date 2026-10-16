import 'package:flutter/material.dart';
import '../models/student.dart';
import '../theme/colors.dart';
import '../widgets/student_card.dart';

// Home screen showing the greeting, banner, and suggested student cards
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dummy list of 4 students
  static const List<Student> students = [
    Student(
      name: 'Sohail Ahmad',
      department: 'BCS - 6th Semester',
      teaches: 'Flutter',
      wants: 'Graphic Design',
      rating: 4.8,
      image: 'assets/images/student1.png',
    ),
    Student(
      name: 'Muhammad Yahya Khokhar',
      department: 'BCS - 6th Semester',
      teaches: 'ML/AI Developer',
      wants: 'Devops',
      rating: 4.8,
      image: 'assets/images/student2.png',
    ),
    Student(
      name: 'Hamza Malik',
      department: 'BEE - 2nd Semester',
      teaches: 'Guitar',
      wants: 'English Speaking',
      rating: 4.2,
      image: 'assets/images/student3.png',
    ),
    Student(
      name: 'Zainab Ahmed',
      department: 'BSE - 8th Semester',
      teaches: 'English Speaking',
      wants: 'Web Development',
      rating: 4.9,
      image: 'assets/images/student4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Skill-Swap',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        // Gradient AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.appBarGradient),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top greeting
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Hi, find your skill match',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
            // Rounded banner image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/banner.png',
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.fill,
                  // fit: BoxFit.fitWidth,
                ), 
              ),
            ),
            // Section heading
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Text(
                'Suggested Matches',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            // 4 student cards (tap any card to view student profile)
            for (final student in students) StudentCard(student: student),
            const SizedBox(height: 16),
          ],
        ),
      ),
      // Floating button navigates to AddSkillScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.teal,
        onPressed: () {
          Navigator.pushNamed(context, '/add-skill');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
