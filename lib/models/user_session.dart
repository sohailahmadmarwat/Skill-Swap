import 'student.dart';

// UserSession: Central session management for the authenticated user.
// Demonstrates: Dart Classes, static variables, methods, String processing,
// and null safety.
class UserSession {
  // Currently authenticated user (defaults to Yahya Khokhar)
  static Student currentUser = const Student(
    name: 'Yahya Khokhar',
    department: 'CS - 2nd Year',
    teaches: 'Python',
    wants: 'UI/UX Design',
    rating: 4.9,
    reviews: 16,
    image: 'assets/images/student2.png',
    bio: 'Tech enthusiast | Love coding, design and learning new skills. 🚀',
    teachSkills: ['Python', 'Web Development', 'UI/UX Design'],
    learnSkills: ['Flutter', 'Devops', 'Cloud'],
  );

  // Authenticate user dynamically on Login or Sign Up
  static void login({
    required String nameOrEmail,
    String? department,
  }) {
    String clean = nameOrEmail.trim();
    if (clean.contains('@')) {
      clean = clean.split('@').first;
    }

    String formattedName;
    if (clean.toLowerCase().contains('yahya')) {
      formattedName = 'Yahya Khokhar';
    } else if (clean.isNotEmpty) {
      // Capitalize user-provided name
      formattedName = clean
          .split(RegExp(r'[\s._]+'))
          .where((part) => part.isNotEmpty)
          .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
          .join(' ');
    } else {
      formattedName = 'Yahya Khokhar';
    }

    final dept = (department != null && department.trim().isNotEmpty)
        ? department.trim()
        : 'CS - 2nd Year';

    currentUser = Student(
      name: formattedName,
      department: dept,
      teaches: 'Python',
      wants: 'UI/UX Design',
      rating: 4.9,
      reviews: 16,
      image: formattedName.toLowerCase().contains('yahya')
          ? 'assets/images/student2.png'
          : null, // Dynamic first-letter fallback for any other logged-in user!
      bio: 'Tech enthusiast | Love coding, design and learning new skills. 🚀',
      teachSkills: ['Python', 'Web Development', 'UI/UX Design'],
      learnSkills: ['Flutter', 'Devops', 'Cloud'],
    );
  }

  // Update profile from Edit Profile screen
  static void updateProfile(Student updated) {
    currentUser = updated;
  }
}
