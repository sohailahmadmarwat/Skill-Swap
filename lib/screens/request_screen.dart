import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 8: Send Swap Request Screen ("Request / Connect")
// Demonstrates: StatefulWidget, TextEditingController, UserAvatar fallback,
// Row, Column, Container, Buttons, Icons, and Navigation.
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final TextEditingController _messageController = TextEditingController(
    text: "Hi! I'd love to swap skills with you. I can teach Python and I'm eager to learn Figma.",
  );

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = (ModalRoute.of(context)?.settings.arguments as Student?) ??
        const Student(
          name: 'Sara Ahmed',
          department: 'SE - 2nd Year',
          teaches: 'Figma',
          wants: 'Python',
          rating: 4.8,
          image: 'assets/images/student4.png',
          teachSkills: ['UI/UX', 'Figma', 'Design'],
        );

    final tags = student.teachSkills.isNotEmpty
        ? student.teachSkills
        : ['UI/UX', 'Figma', 'Design'];

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
          'Send Swap Request',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Card Preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppColors.glassBoxDecoration(radius: 18),
              child: Row(
                children: [
                  UserAvatar(
                    name: student.name,
                    image: student.image,
                    radius: 26,
                    showGlow: true,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          student.department,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Tags row
                        Wrap(
                          spacing: 6,
                          children: tags.map((t) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                t,
                                style: const TextStyle(
                                  color: AppColors.accentCyan,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Skill Exchange Details Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: AppColors.glassBoxDecoration(radius: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // You will teach
                  const Text(
                    'You will teach',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      UserSession.currentUser.teaches,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // You will learn
                  const Text(
                    'You will learn',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accentPink.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.accentPink.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      student.teaches,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Personal Message Label
            const Text(
              'Add a personal message (optional)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Personal Message Multiline TextField
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0x80161536),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    maxLength: 200,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Write a note introducing yourself...',
                      hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                      border: InputBorder.none,
                      counterStyle: TextStyle(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Send Request Gradient Button
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
                onPressed: () {
                  // Direct navigation to Screen 6: Matching Screen!
                  Navigator.pushReplacementNamed(
                    context,
                    '/match',
                    arguments: student,
                  );
                },
                child: const Text(
                  'Send Request',
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
