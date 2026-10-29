import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 12: Edit Profile Screen (5 of 5 Fully Functional Screens)
// Demonstrates: StatefulWidget, setState, TextEditingController, Form validation,
// UserAvatar with live first-letter updates as name is typed, Row, Column,
// Container, Buttons, Icons, and Navigation.pop with result.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _deptController;
  late final TextEditingController _bioController;
  final TextEditingController _skillInputController = TextEditingController();

  // Skills list with tags
  late List<String> _skills;

  // Current avatar name for live letter updating
  late String _currentName;

  @override
  void initState() {
    super.initState();
    final user = UserSession.currentUser;
    _nameController = TextEditingController(text: user.name);
    _deptController = TextEditingController(text: user.department);
    _bioController = TextEditingController(text: user.bio);
    _skills = List.from(user.teachSkills.isNotEmpty ? user.teachSkills : ['Python', 'Web Dev', 'UI/UX']);
    _currentName = user.name;

    _nameController.addListener(() {
      setState(() {
        _currentName = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _deptController.dispose();
    _bioController.dispose();
    _skillInputController.dispose();
    super.dispose();
  }

  // Add new skill chip
  void _addSkill() {
    final skill = _skillInputController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _skillInputController.clear();
      });
    }
  }

  // Remove skill chip
  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  // Save changes and return to previous screen
  void _saveChanges() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name')),
      );
      return;
    }

    final updatedStudent = Student(
      name: _nameController.text.trim(),
      department: _deptController.text.trim().isEmpty
          ? 'CS - 2nd Year'
          : _deptController.text.trim(),
      teaches: _skills.isNotEmpty ? _skills.first : 'Python',
      wants: _skills.length > 1 ? _skills[1] : 'Figma',
      rating: UserSession.currentUser.rating,
      bio: _bioController.text.trim(),
      teachSkills: List.from(_skills),
      image: UserSession.currentUser.image,
    );

    // Update global user session
    UserSession.updateProfile(updatedStudent);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.cardBg,
        content: Text(
          'Profile updated successfully!',
          style: TextStyle(color: AppColors.accentCyan),
        ),
      ),
    );

    Navigator.pop(context, updatedStudent);
  }

  // Input decoration helper
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      filled: true,
      fillColor: const Color(0x80161536),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.cardBorder, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Picture with live first-letter fallback and "Change Photo" button
            Center(
              child: Column(
                children: [
                  UserAvatar(
                    name: _currentName,
                    image: 'assets/images/student2.png',
                    radius: 44,
                    showGlow: true,
                  ),
                  const SizedBox(height: 10),
                  // "Change Photo" pill button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.white, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Change Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Full Name TextField
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Full Name'),
            ),
            const SizedBox(height: 16),

            // Department / Year TextField
            TextField(
              controller: _deptController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Department / Year'),
            ),
            const SizedBox(height: 16),

            // Bio TextField (multiline)
            TextField(
              controller: _bioController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Bio'),
            ),
            const SizedBox(height: 20),

            // Skills (Teach & Learn) Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: AppColors.glassBoxDecoration(radius: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Skills (Teach & Learn)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Skills Chips Wrap with delete option
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _skills.map((skill) {
                      return Chip(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.25),
                        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        label: Text(
                          skill,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        deleteIcon: const Icon(Icons.close, size: 14, color: AppColors.textMuted),
                        onDeleted: () => _removeSkill(skill),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  // Add skill input row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _skillInputController,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Add new skill (e.g. Flutter)...',
                            hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                            filled: true,
                            fillColor: const Color(0xFF131230),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColors.cardBorder),
                            ),
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: AppColors.accentCyan, size: 28),
                        onPressed: _addSkill,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Save Changes Gradient CTA Button
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
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
                onPressed: _saveChanges,
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
