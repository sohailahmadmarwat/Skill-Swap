import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../models/student.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 7: Chat Screen
// Demonstrates: StatefulWidget, ListView.builder, TextEditingController,
// UserAvatar with first-letter fallback, Row, Column, Container,
// BoxDecoration, Icons, and Navigation.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  // Chat message list matching Screen 7 in mockup
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: "Hey! I saw your profile. I'm interested in learning Figma. Would you be open to a skill swap?",
      time: "9:20 AM",
      isMe: false,
    ),
    const ChatMessage(
      text: "Yes! I'd love to help you with Python, I want to learn Figma. Let's do it!",
      time: "9:24 AM",
      isMe: true,
    ),
    const ChatMessage(
      text: "Great! Shall we plan a session this weekend?",
      time: "9:28 AM",
      isMe: false,
    ),
    const ChatMessage(
      text: "Sounds good! I'm free Saturday evening. How about you?",
      time: "9:32 AM",
      isMe: true,
    ),
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final timeStr = "${now.hour > 12 ? now.hour - 12 : now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          time: timeStr,
          isMe: true,
        ),
      );
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    String partnerName = 'Sara Ahmed';
    String? partnerImage = 'assets/images/student4.png';
    if (arg is Student) {
      partnerName = arg.name;
      partnerImage = arg.image;
    } else if (arg is ChatConversation) {
      partnerName = arg.name;
      partnerImage = arg.image;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color(0xFF131230),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            // Chat Partner Avatar with online dot indicator
            Stack(
              children: [
                UserAvatar(
                  name: partnerName,
                  image: partnerImage,
                  radius: 19,
                  showGlow: true,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partnerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.accentCyan.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/schedule');
            },
          ),
          IconButton(
            icon: const Icon(Icons.star_outline_rounded, color: AppColors.accentGold),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/rating',
                arguments: arg is Student
                    ? arg
                    : Student(
                        name: partnerName,
                        department: 'SE - 2nd Year',
                        teaches: 'UI/UX Design',
                        wants: 'Python',
                        rating: 4.8,
                        image: partnerImage,
                      ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages Timeline ListView
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(msg);
              },
            ),
          ),

          // Message Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF131230),
              border: Border(top: BorderSide(color: AppColors.cardBorder, width: 1)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attachment Icon
                  IconButton(
                    icon: const Icon(Icons.attach_file_rounded, color: AppColors.textMuted),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attach study materials / link')),
                      );
                    },
                  ),
                  // Text Input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1A40),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Circular Send Gradient Button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chat bubble widget matching dark neon styling
  Widget _buildChatBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.76,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: msg.isMe ? AppColors.primaryGradient : null,
          color: msg.isMe ? null : const Color(0xFF1C1B3E),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
          border: Border.all(
            color: msg.isMe
                ? Colors.transparent
                : AppColors.cardBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
