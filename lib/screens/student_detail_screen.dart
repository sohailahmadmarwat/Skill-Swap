import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 5: User Profile / Student Detail Screen (4 of 5 Fully Functional Screens)
// Demonstrates: StatefulWidget, setState, ModalRoute settings arguments,
// showDatePicker, Record destructuring, Row, Column, Container, UserAvatar fallback,
// Buttons, Icons, and Navigation.
class StudentDetailScreen extends StatefulWidget {
  final bool isMyProfile;

  const StudentDetailScreen({super.key, this.isMyProfile = false});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  bool _requestSent = false;
  DateTime? _scheduledDate;

  // Schedule Session with showDatePicker
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Color(0xFF1B1942),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (!mounted) return;
    if (picked != null) {
      setState(() {
        _scheduledDate = picked;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Session planned for ${picked.day}/${picked.month}/${picked.year}',
          ),
        ),
      );
    }
  }

  // Toggle request sent state
  void _toggleRequest(Student student) {
    setState(() {
      _requestSent = !_requestSent;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardBg,
        content: Text(
          _requestSent
              ? 'Swap request sent to ${student.name}!'
              : 'Request cancelled',
          style: const TextStyle(color: AppColors.accentCyan),
        ),
        action: _requestSent
            ? SnackBarAction(
                label: "View Match",
                textColor: AppColors.accentPink,
                onPressed: () {
                  Navigator.pushNamed(context, '/match', arguments: student);
                },
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic student: If isMyProfile is true OR no argument is passed OR argument matches current user,
    // ALWAYS display the actively logged-in user dynamically!
    final studentArg = ModalRoute.of(context)?.settings.arguments as Student?;
    final isMe = widget.isMyProfile ||
        studentArg == null ||
        (studentArg.name.trim().toLowerCase() ==
            UserSession.currentUser.name.trim().toLowerCase());
    final student = isMe ? UserSession.currentUser : studentArg;

    final teachList = student.teachSkills.isNotEmpty
        ? student.teachSkills
        : [student.teaches, 'Web Development', 'UI/UX Design'];
    final learnList = student.learnSkills.isNotEmpty
        ? student.learnSkills
        : [student.wants, 'Graphic Design', 'Machine Learning'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Cover Landscape Graphic with Back and Options Buttons
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Mountain sunset cover header
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/cover.jpg'),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Subtle decorative mountain icon
                      Positioned(
                        right: 20,
                        bottom: 10,
                        child: Icon(
                          Icons.landscape_rounded,
                          size: 110,
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      // Top navigation bar icons
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.more_vert, color: Colors.white),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Profile options')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Glowing Avatar (half-overlapping cover)
                Positioned(
                  bottom: -46,
                  child: UserAvatar(
                    name: student.name,
                    image: student.image,
                    radius: 46,
                    showGlow: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 54),

            // Name & Department
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              student.department,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                student.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats Counter Row: 5 Skills to Teach | 3 to Learn | 4.8 Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: AppColors.glassBoxDecoration(radius: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('${teachList.length}', 'Skills to Teach'),
                    Container(height: 30, width: 1, color: AppColors.cardBorder),
                    _buildStatItem('${learnList.length}', 'Skills to Learn'),
                    Container(height: 30, width: 1, color: AppColors.cardBorder),
                    _buildStatItem('${student.rating}', 'Rating'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Skills I Can Teach Section
            _buildSkillsSection(
              title: 'Skills I Can Teach',
              skills: teachList,
              color: AppColors.primary,
              showAdd: true,
            ),
            const SizedBox(height: 18),

            // Skills I Want to Learn Section
            _buildSkillsSection(
              title: 'Skills I Want to Learn',
              skills: learnList,
              color: AppColors.accentPink,
              showAdd: false,
            ),
            const SizedBox(height: 18),

            // Planned Session Date (if selected)
            if (_scheduledDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accentCyan.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, color: AppColors.accentCyan, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'Session Scheduled: ${_scheduledDate!.day}/${_scheduledDate!.month}/${_scheduledDate!.year}',
                        style: const TextStyle(
                          color: AppColors.accentCyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Action Buttons: Edit Profile for currentUser, or Send Request & Schedule for others
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isMe
                  ? Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/edit-profile');
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
                        label: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        // Full-width Send Request Button
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: _requestSent ? null : AppColors.primaryGradient,
                              color: _requestSent ? const Color(0xFF23224B) : null,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: _requestSent
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.4),
                                        blurRadius: 14,
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
                              onPressed: () => _toggleRequest(student),
                              child: Text(
                                _requestSent ? 'Request Pending ✓' : 'Send Request',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Schedule Date Button
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x80161536),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined, color: AppColors.accentCyan),
                            onPressed: _pickDate,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Stat item column (e.g. 5 | Skills to Teach)
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // Skills section with chips
  Widget _buildSkillsSection({
    required String title,
    required List<String> skills,
    required Color color,
    bool showAdd = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (showAdd)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: color, size: 16),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  skill,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
