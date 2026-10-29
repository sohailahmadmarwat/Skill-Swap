import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 4: Search & Explore Screen (3 of 5 Fully Functional Screens)
// Demonstrates: StatefulWidget, setState, ListView.builder, Sets, Maps,
// TextField with live search, Row, Column, Container, UserAvatar fallback,
// BottomNavigationBar, and Navigation.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'All';

  // Categories list
  final List<String> _categories = [
    'All',
    'Coding',
    'Design',
    'Languages',
    'Music',
    'Sports',
    'Academic',
    'Others',
  ];

  // Popular skills list
  final List<String> _popularSkills = [
    'Python',
    'JavaScript',
    'UI/UX Design',
    'Graphic Design',
    'Data Science',
    'English',
  ];

  // Student database
  final List<Student> _allStudents = [
    const Student(
      name: 'Sohail',
      department: 'CS - 3rd Year',
      teaches: 'Python',
      wants: 'Figma',
      rating: 4.8,
      reviews: 12,
      image: 'assets/images/student1.png',
      teachSkills: ['Python', 'Web Dev', 'Data Structures'],
      learnSkills: ['Figma', 'UI/UX Design'],
    ),
    const Student(
      name: 'Sara Ahmed',
      department: 'SE - 2nd Year',
      teaches: 'UI/UX Design',
      wants: 'Python',
      rating: 4.6,
      reviews: 8,
      image: 'assets/images/student4.png',
      teachSkills: ['Design', 'Figma', 'UI/UX'],
      learnSkills: ['Python', 'Dart'],
    ),
    const Student(
      name: 'Usman Tariq',
      department: 'CS - 4th Year',
      teaches: 'Data Science',
      wants: 'Web Dev',
      rating: 4.7,
      reviews: 10,
      image: 'assets/images/student3.png',
      teachSkills: ['ML', 'Data Science', 'Python'],
      learnSkills: ['Devops', 'Web Dev'],
    ),
    const Student(
      name: 'Zainab Farooq',
      department: 'BSE - 3rd Year',
      teaches: 'English',
      wants: 'Flutter',
      rating: 4.9,
      reviews: 15,
      image: null, // First letter 'Z' fallback!
      teachSkills: ['English', 'Communication'],
      learnSkills: ['Flutter', 'Coding'],
    ),
    const Student(
      name: 'Hamza Ali',
      department: 'BEE - 2nd Semester',
      teaches: 'Guitar',
      wants: 'Graphic Design',
      rating: 4.4,
      reviews: 6,
      image: null, // First letter 'H' fallback!
      teachSkills: ['Guitar', 'Music'],
      learnSkills: ['Graphic Design'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter students based on query and category
  List<Student> get _filteredStudents {
    final myName = UserSession.currentUser.name.trim().toLowerCase();
    return _allStudents.where((student) {
      if (student.name.trim().toLowerCase() == myName) {
        return false;
      }
      final matchesQuery = _query.isEmpty ||
          student.name.toLowerCase().contains(_query) ||
          student.teaches.toLowerCase().contains(_query) ||
          student.wants.toLowerCase().contains(_query) ||
          student.teachSkills.any((s) => s.toLowerCase().contains(_query));

      final matchesCategory = _selectedCategory == 'All' ||
          student.category.toLowerCase() == _selectedCategory.toLowerCase();

      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredStudents;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),

              // Search Input Bar with Filter Action Icon
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x80161536),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) {
                    setState(() {
                      _query = val.trim().toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search skills or categories...',
                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.accentCyan, size: 20),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_query.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _query = '';
                              });
                            },
                          ),
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: AppColors.accentCyan,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Horizontal Category Filter Pills: [All], [Coding], [Design]...
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.primaryGradient : null,
                          color: isSelected ? null : const Color(0x80161536),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : AppColors.cardBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),

              // Popular Skills Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Skills',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _query = '';
                        _selectedCategory = 'All';
                      });
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.accentCyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Popular Skills Chips Wrap
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _popularSkills.map((skill) {
                  return GestureDetector(
                    onTap: () {
                      _searchController.text = skill;
                      setState(() {
                        _query = skill.toLowerCase();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A193D),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),

              // Available Students Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Students',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _query = '';
                        _searchController.clear();
                        _selectedCategory = 'All';
                      });
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.accentCyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Available Students List
              if (filtered.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded, color: AppColors.textMuted, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        'No students found matching your criteria',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                )
              else
                ...filtered.map((student) => _buildStudentSearchTile(student)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Student Card specifically matching Screen 4 layout
  Widget _buildStudentSearchTile(Student student) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: AppColors.glassBoxDecoration(radius: 16),
      child: Row(
        children: [
          // Avatar with first-letter fallback
          UserAvatar(
            name: student.name,
            image: student.image,
            radius: 22,
            showGlow: true,
          ),
          const SizedBox(width: 12),
          // Student details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  student.department,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                // Skills pills row & Rating (Flexible to prevent any horizontal overflow)
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: student.teachSkills.take(2).map((skill) => Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: AppColors.accentCyan,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star, color: AppColors.accentGold, size: 13),
                    const SizedBox(width: 3),
                    Text(
                      '${student.rating} (${student.reviews})',
                      style: const TextStyle(
                        color: AppColors.accentGold,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Circular "+" Connect Button -> Navigates to Send Swap Request
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/request',
                arguments: student,
              );
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar with Search selected
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF100F29),
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 1, // Search active
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/messages');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/my-profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
