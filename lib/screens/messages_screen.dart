import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../theme/colors.dart';
import '../widgets/user_avatar.dart';

// Screen 10: Messages Screen
// Connected via navigation: Opened from Home bottom nav, Drawer, or directly.
// Demonstrates: StatefulWidget, ListView.builder, ListTile, UserAvatar fallback,
// Row, Column, Container, BottomNavigationBar, and Navigation.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // Conversations list matching Screen 10 in mockup
  final List<ChatConversation> _conversations = [
    const ChatConversation(
      name: 'Sara Ahmed',
      lastMessage: 'Sounds good! See you tomorrow.',
      time: '2h',
      unreadCount: 1,
      image: 'assets/images/student4.png',
      isOnline: true,
    ),
    const ChatConversation(
      name: 'Sohail',
      lastMessage: "Let's plan for the weekend!",
      time: '4h',
      unreadCount: 0,
      image: 'assets/images/student1.png',
      isOnline: true,
    ),
    const ChatConversation(
      name: 'Usman Tariq',
      lastMessage: "Okay, I'll send you the link.",
      time: '1d',
      unreadCount: 0,
      image: 'assets/images/student3.png',
      isOnline: false,
    ),
    const ChatConversation(
      name: 'Ayesha Khan',
      lastMessage: 'Perfect! Thank you!',
      time: '2d',
      unreadCount: 0,
      image: null, // First letter 'A' fallback!
      isOnline: true,
    ),
    const ChatConversation(
      name: 'Zainab Farooq',
      lastMessage: 'Same here! 😊',
      time: '3d',
      unreadCount: 0,
      image: null, // First letter 'Z' fallback!
      isOnline: false,
    ),
    const ChatConversation(
      name: 'Hamza Ali',
      lastMessage: 'Yes! Sure, no problem.',
      time: '4d',
      unreadCount: 0,
      image: null, // First letter 'H' fallback!
      isOnline: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ChatConversation> get _filteredConversations {
    if (_query.isEmpty) return _conversations;
    return _conversations
        .where((c) =>
            c.name.toLowerCase().contains(_query) ||
            c.lastMessage.toLowerCase().contains(_query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredConversations;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.accentCyan),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Conversations Input Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
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
                  hintText: 'Search conversations...',
                  hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  prefixIcon: const Icon(Icons.search, color: AppColors.accentCyan, size: 20),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _query = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Conversations List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: list.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFF1C1A3F),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final item = list[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  leading: Stack(
                    children: [
                      UserAvatar(
                        name: item.name,
                        image: item.image,
                        radius: 24,
                        showGlow: item.unreadCount > 0,
                      ),
                      if (item.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E676),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.background, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.lastMessage,
                      style: TextStyle(
                        color: item.unreadCount > 0 ? Colors.white : AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: item.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.time,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (item.unreadCount > 0)
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${item.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 18),
                    ],
                  ),
                  onTap: () {
                    // Navigation: Opens Chat Screen with active conversation
                    Navigator.pushNamed(context, '/chat', arguments: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Bottom Navigation Bar with Messages tab selected
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF100F29),
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 2, // Messages tab active
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
          } else if (index == 1) {
            Navigator.pushNamed(context, '/search');
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
            icon: Icon(Icons.chat_bubble_rounded),
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
