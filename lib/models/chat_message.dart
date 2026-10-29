// Model representing a single chat bubble message in conversation.
// Dart Classes, final fields, const constructor
class ChatMessage {
  final String text;
  final String time;
  final bool isMe;

  const ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
  });
}

// Model representing a conversation thread on the Messages screen.
// Dart Classes, final fields, nullable String? avatar
class ChatConversation {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String? image;
  final bool isOnline;

  const ChatConversation({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.image,
    this.isOnline = false,
  });

  // Getter for first letter fallback
  String get firstLetter =>
      name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';
}
