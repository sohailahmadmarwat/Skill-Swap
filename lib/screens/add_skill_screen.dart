import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

// Compatibility wrapper: Routes to the new EditProfileScreen
// Demonstrates: StatelessWidget and Widget composition.
class AddSkillScreen extends StatelessWidget {
  const AddSkillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EditProfileScreen();
  }
}
