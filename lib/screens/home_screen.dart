import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/student_card.dart';
import '../widgets/user_avatar.dart';

// Screen 3: Home Screen (2 of 5 Fully Functional Screens)
// Demonstrates: StatefulWidget, setState, Dynamic Greetings based on DateTime,
// ListView.builder, Sets, Maps, Conditional operators, Card, ListTile,
// UserAvatar with first-letter fallback, BottomNavigationBar, and Navigation.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Active Bottom Navigation tab index
  int _currentTabIndex = 0;

  // Selected Category filter using Dart Sets (prevents duplicates)
  final Set<String> _selectedCategories = {};
  final Set<String> _favorites = {};

  // Search query controller & state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Notifications state
  bool _hasUnreadNotification = true;
  final List<String> _notifications = [
    'Sara Ahmed sent you a swap request for Figma!',
    'Ayesha Khan is now available for UI/UX Design.',
  ];

  // Master list of students
  final List<Student> _students = [
    const Student(
      name: 'Ayesha Khan',
      department: 'SE - 2nd Year',
      teaches: 'UI/UX Design',
      wants: 'Web Development',
      rating: 4.9,
      reviews: 14,
      image:
          null, // No image provided -> Demonstrates first letter 'A' fallback!
      teachSkills: ['UI/UX Design', 'Figma', 'Prototyping'],
      learnSkills: ['Flutter', 'Web Development'],
    ),
    const Student(
      name: 'Sohail',
      department: 'CS - 3rd Year',
      teaches: 'Python',
      wants: 'Figma',
      rating: 4.8,
      reviews: 12,
      image: 'assets/images/student1.png',
      teachSkills: [
        'Python',
        'Web Development',
        'UI/UX Design',
        'Data Structures',
      ],
      learnSkills: ['Figma', 'Graphic Design', 'Machine Learning'],
    ),
    const Student(
      name: 'Sara Ahmed',
      department: 'SE - 2nd Year',
      teaches: 'Graphic Design',
      wants: 'Python',
      rating: 4.6,
      reviews: 8,
      image: 'assets/images/student4.png',
      teachSkills: ['Design', 'Figma', 'Graphic Design'],
      learnSkills: ['Python', 'Dart'],
    ),
    const Student(
      name: 'Usman Tariq',
      department: 'CS - 4th Year',
      teaches: 'Data Science',
      wants: 'Devops',
      rating: 4.7,
      reviews: 10,
      image: 'assets/images/student3.png',
      teachSkills: ['Data Science', 'Machine Learning', 'Python'],
      learnSkills: ['Devops', 'Cloud'],
    ),
    const Student(
      name: 'Hamza Malik',
      department: 'BEE - 2nd Semester',
      teaches: 'Guitar',
      wants: 'English Speaking',
      rating: 4.2,
      reviews: 5,
      image: null, // Demonstrates first letter 'H' fallback!
      teachSkills: ['Guitar', 'Music Theory'],
      learnSkills: ['English Speaking'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Dynamic Greeting Function using DateTime and Conditional operators
  String _getDynamicGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  // Filtered list of students based on search query and category sets
  List<Student> get _filteredStudents {
    final currentUserName = UserSession.currentUser.name.trim().toLowerCase();
    return _students.where((student) {
      // Exclude logged in user from peer swapper listing
      if (student.name.trim().toLowerCase() == currentUserName) {
        return false;
      }

      final matchesQuery =
          _searchQuery.isEmpty ||
          student.name.toLowerCase().contains(_searchQuery) ||
          student.teaches.toLowerCase().contains(_searchQuery) ||
          student.wants.toLowerCase().contains(_searchQuery);

      final matchesCategory =
          _selectedCategories.isEmpty ||
          _selectedCategories.contains(student.category);

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // Toggle favorite using Dart Set.add / remove
  void _toggleFavorite(String name) {
    setState(() {
      if (!_favorites.add(name)) {
        _favorites.remove(name);
      }
    });
  }

  // Toggle category filter
  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.clear(); // single category focus or toggle
        _selectedCategories.add(category);
      }
    });
  }

  // Interactive notifications modal sheet
  void _showNotificationsSheet() {
    setState(() {
      _hasUnreadNotification = false;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131230),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_notifications.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _notifications.clear();
                              _hasUnreadNotification = false;
                            });
                            setSheetState(() {});
                          },
                          child: const Text(
                            'Clear All',
                            style: TextStyle(color: AppColors.accentCyan),
                          ),
                        ),
                    ],
                  ),
                  const Divider(color: AppColors.cardBorder),
                  if (_notifications.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No new notifications',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ..._notifications.map((notif) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: AppColors.glassBoxDecoration(radius: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.notifications_active_rounded,
                              color: AppColors.accentCyan,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                notif,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleStudents = _filteredStudents;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: const AppDrawer(currentRoute: '/home'),
      // Safe Area Body
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: visibleStudents.length + 1,
          itemBuilder: (context, index) {
            // Index 0 renders the full Home Dashboard header
            if (index == 0) {
              return _buildDashboardHeader();
            }
            final student = visibleStudents[index - 1];
            return StudentCard(
              student: student,
              isFavorite: _favorites.contains(student.name),
              onFavoriteToggle: () => _toggleFavorite(student.name),
            );
          },
        ),
      ),
      // Bottom Navigation Bar with dark neon styling
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Everything above the student list (Header, Banner, Categories, Match card)
  Widget _buildDashboardHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // Top Bar: App title, Notification Bell, User Avatar (opens Drawer)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & App Name
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SkillSwap',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              // Notification Bell & Yahya Avatar
              Row(
                children: [
                  // Bell Icon with unread badge
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: _showNotificationsSheet,
                      ),
                      if (_hasUnreadNotification && _notifications.isNotEmpty)
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  // User Avatar: Clicking opens Drawer
                  UserAvatar(
                    name: UserSession.currentUser.name,
                    image: UserSession.currentUser.image,
                    radius: 18,
                    showGlow: true,
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Dynamic Greeting Header based on DateTime.now().hour and logged-in user
          Text(
            '${_getDynamicGreeting()}, ${UserSession.currentUser.name.split(' ').first} 👋',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'What skill do you want to learn today?',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 18),

          // Search Bar TextField with onChanged listener
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
                  _searchQuery = val.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for skills, users, or categories...',
                hintStyle: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.accentCyan,
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.textMuted,
                          size: 18,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Featured Card: "Exchange Skills Not Money"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: AppColors.bannerGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Exchange Skills\nNot Money',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Teach what you know,\nLearn what you love.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // 3D high-five image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/highfive.jpg',
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Section 1: Popular Categories (with "See All")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Categories',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategories.clear();
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

          // Horizontal Category Chips
          Row(
            children: [
              _buildCategoryTile(
                'Coding',
                Icons.code_rounded,
                AppColors.accentCyan,
              ),
              const SizedBox(width: 10),
              _buildCategoryTile(
                'Design',
                Icons.palette_outlined,
                AppColors.accentPink,
              ),
              const SizedBox(width: 10),
              _buildCategoryTile(
                'Languages',
                Icons.language_rounded,
                AppColors.primaryLight,
              ),
              const SizedBox(width: 10),
              _buildCategoryTile(
                'Music',
                Icons.headphones_rounded,
                AppColors.accentGold,
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Section 2: New Matches For You (with Ayesha Khan card)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Matches For You',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
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

          // Featured Match Card (Ayesha Khan)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: AppColors.glassBoxDecoration(radius: 16),
            child: Row(
              children: [
                // Avatar with dynamic 'A' first-letter fallback
                const UserAvatar(
                  name: 'Ayesha Khan',
                  image: null,
                  radius: 24,
                  showGlow: true,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ayesha Khan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Web Development • UI/UX Design',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Skill hashtags (Wrap prevents any overflow)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          _buildHashTag('#Figma'),
                          _buildHashTag('#Design'),
                          _buildHashTag('#UI/UX'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Gradient "Connect" Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Send Swap Request screen
                    Navigator.pushNamed(context, '/request');
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Section 3: Available Matches Title
          Text(
            _selectedCategories.isEmpty
                ? 'All Skill Swappers (${_filteredStudents.length})'
                : 'Filtered: ${_selectedCategories.first} (${_filteredStudents.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // Helper widget function for category card
  Widget _buildCategoryTile(String title, IconData icon, Color color) {
    final isSelected = _selectedCategories.contains(title);
    return Expanded(
      child: GestureDetector(
        onTap: () => _toggleCategory(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.25)
                : const Color(0x80161536),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? color : AppColors.cardBorder,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Small hashtag chip
  Widget _buildHashTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: AppColors.accentCyan,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Bottom Navigation Bar with dark neon glass styling
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF100F29),
        border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
          if (index == 1) {
            Navigator.pushNamed(context, '/search');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/messages');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/my-profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
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
