import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 11: Rating & Review Screen ("Rate Your Session")
// Connected via navigation: Opened after a swap session or from Chat.
// Demonstrates: StatefulWidget, setState, UserAvatar fallback,
// Row, Column, Container, Buttons, Icons, and Navigation.
class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 4; // Default 4 stars matching mockup
  final TextEditingController _feedbackController = TextEditingController();

  // Dynamic rating descriptions based on selected star count
  String _getRatingFeedbackText() {
    switch (_rating) {
      case 5:
        return 'Outstanding session! 🌟';
      case 4:
        return 'Great experience!';
      case 3:
        return 'Good session';
      case 2:
        return 'Could be better';
      default:
        return 'Needs improvement';
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentArg = ModalRoute.of(context)?.settings.arguments as Student?;
    final peer = studentArg ??
        const Student(
          name: 'Sara Ahmed',
          department: 'SE - 2nd Year',
          teaches: 'Design • Figma',
          wants: 'Python • Web Dev',
          rating: 4.8,
          image: 'assets/images/student4.png',
        );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // 3D Floating Glowing Stars image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/stars.jpg',
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Title: Rate Your Session
            const Text(
              'Rate Your Session',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Intersecting / Connected Avatars Pair: Logged-in User x Peer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    UserAvatar(
                      name: UserSession.currentUser.name,
                      image: UserSession.currentUser.image,
                      radius: 30,
                      showGlow: true,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      UserSession.currentUser.name,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.cardBorder,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: AppColors.textSecondary, size: 14),
                  ),
                ),
                Column(
                  children: [
                    UserAvatar(
                      name: peer.name,
                      image: peer.image,
                      radius: 30,
                      showGlow: true,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      peer.name,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),

            // 5 Stars Rating Bar with Tap Gestures
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNumber = index + 1;
                final isFilled = starNumber <= _rating;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = starNumber;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: isFilled ? AppColors.accentGold : AppColors.cardBorder,
                      size: 38,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),

            // Dynamic Rating Feedback Text: "Great experience!"
            Text(
              _getRatingFeedbackText(),
              style: const TextStyle(
                color: AppColors.accentCyan,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Feedback Textarea: "Write your feedback..."
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0x80161536),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: TextField(
                controller: _feedbackController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  hintText: 'Write your feedback...',
                  hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // Submit Gradient CTA Button
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.cardBg,
                      content: Text(
                        'Thank you for rating this session!',
                        style: TextStyle(color: AppColors.accentCyan),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Submit',
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
