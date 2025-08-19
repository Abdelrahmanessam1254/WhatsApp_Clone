import 'message.dart';

class Chat {
  final String id;
  final String name;
  final String avatarUrl;
  final List<Message> messages;
  final bool isOnline;
  final DateTime lastSeen;

  Chat({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.messages,
    this.isOnline = false,
    required this.lastSeen,
  });

  Message? get lastMessage => messages.isNotEmpty ? messages.last : null;

  int get unreadCount => messages.where((m) => !m.isMe && m.status != MessageStatus.read).length;
}