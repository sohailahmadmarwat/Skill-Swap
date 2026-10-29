import 'package:flutter/material.dart';
import '../models/user_session.dart';
import '../theme/colors.dart';

// Screen 2: Login & Sign Up Screen (1 of 5 Fully Functional Screens)
// Demonstrates: StatefulWidget, setState, TextEditingController, Form validation with
// Dart Records: (bool, String), Conditional operator, Row, Column, Container,
// Buttons, Icons, GestureDetector, and Navigation.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Mode flag: true for Login, false for Sign Up
  bool _isLogin = true;

  // TextEditingControllers: Reads user inputs
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _deptController = TextEditingController();

  // State variables changed with setState
  bool _obscurePassword = true;
  bool _rememberMe = true;
  String? _emailError;
  String? _passwordError;
  String? _nameError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _deptController.dispose();
    super.dispose();
  }

  // Dart Records: Function returning a Record (bool isValid, String errorMessage)
  (bool, String) _validateEmail(String email) {
    if (email.trim().isEmpty) return (false, 'Email or username is required');
    if (_isLogin) {
      if (email.length < 3) return (false, 'Must be at least 3 characters');
    } else {
      if (!email.contains('@') || !email.contains('.')) {
        return (false, 'Enter a valid student email');
      }
    }
    return (true, '');
  }

  (bool, String) _validatePassword(String password) {
    if (password.isEmpty) return (false, 'Password is required');
    if (password.length < 6) return (false, 'At least 6 characters required');
    return (true, '');
  }

  (bool, String) _validateName(String name) {
    if (name.trim().isEmpty) return (false, 'Full name is required');
    return (true, '');
  }

  // Handle form submission (Login or Sign Up)
  void _submit() {
    final (emailOk, emailMsg) = _validateEmail(_emailController.text);
    final (passwordOk, passwordMsg) = _validatePassword(_passwordController.text);
    final (nameOk, nameMsg) = !_isLogin
        ? _validateName(_nameController.text)
        : (true, '');

    // setState updates errors on the screen
    setState(() {
      _emailError = emailOk ? null : emailMsg;
      _passwordError = passwordOk ? null : passwordMsg;
      _nameError = nameOk ? null : nameMsg;
    });

    if (emailOk && passwordOk && nameOk) {
      // Set the global authenticated user session dynamically
      UserSession.login(
        nameOrEmail: _isLogin ? _emailController.text : _nameController.text,
        department: _deptController.text,
      );

      // Navigation: Proceed to Home Screen upon successful validation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.cardBg,
          content: Text(
            _isLogin
                ? 'Welcome back, ${UserSession.currentUser.name}!'
                : 'Account created for ${UserSession.currentUser.name}!',
            style: const TextStyle(color: AppColors.accentCyan),
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  // Shared dark neon InputDecoration helper
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
      errorText: errorText,
      prefixIcon: Icon(prefixIcon, color: AppColors.accentCyan, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0x80161536),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.cardBorder, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Header: Title on Left, 3D Glowing Purple Gem on Right (Figma Screen 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isLogin ? 'Welcome Back 👋' : 'Create Account 🚀',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isLogin
                              ? 'Log in to continue your skill journey'
                              : 'Join the student skill-swapping network',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  // SkillSwap logo
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: 18,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Pill Tab Switcher: [ Login | Sign Up ]
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0x80161536),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLogin = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            gradient: _isLogin ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: _isLogin ? Colors.white : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLogin = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            gradient: !_isLogin ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: !_isLogin ? Colors.white : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Extra Sign Up Fields
              if (!_isLogin) ...[
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration(
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    errorText: _nameError,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _deptController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration(
                    hintText: 'Department / Year (e.g. CS - 2nd Year)',
                    prefixIcon: Icons.school_outlined,
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // Email / Username TextField
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hintText: _isLogin ? 'Email or Username' : 'Student Email',
                  prefixIcon: Icons.email_outlined,
                  suffixIcon: _isLogin
                      ? const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted, size: 14)
                      : null,
                  errorText: _emailError,
                ),
              ),
              const SizedBox(height: 14),

              // Password TextField with Eye Toggle
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  errorText: _passwordError,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Remember Me & Forgot Password Row
              if (_isLogin)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.primary,
                            checkColor: Colors.white,
                            side: const BorderSide(color: AppColors.cardBorder, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password reset instructions sent to email'),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 24),

              // Full-Width Gradient CTA Button: Log In / Sign Up
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
                  onPressed: _submit,
                  child: Text(
                    _isLogin ? 'Log In' : 'Create Account',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // "— or continue with —" Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.cardBorder)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.cardBorder)),
                ],
              ),
              const SizedBox(height: 20),

              // Social Buttons Row: Google & Facebook
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      label: 'Google',
                      icon: Icons.g_mobiledata_rounded,
                      iconColor: Colors.redAccent,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildSocialButton(
                      label: 'Facebook',
                      icon: Icons.facebook,
                      iconColor: const Color(0xFF1877F2),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bottom Account Toggle Text
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: _isLogin ? "Don't have an account? " : "Already have an account? ",
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      children: [
                        TextSpan(
                          text: _isLogin ? 'Sign Up' : 'Log In',
                          style: const TextStyle(
                            color: AppColors.accentCyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget function for social login buttons
  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0x80161536),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
