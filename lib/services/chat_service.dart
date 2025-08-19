import '../models/chat.dart';
import '../models/message.dart';

class ChatService {
  static List<Chat> _chats = [];

  static List<Chat> getChats() {
    if (_chats.isEmpty) {
      _initializeChats();
    }
    return _chats;
  }

  static Chat? getChatById(String id) {
    return _chats.firstWhere((chat) => chat.id == id);
  }

  static void addMessage(String chatId, Message message) {
    final chat = getChatById(chatId);
    if (chat != null) {
      chat.messages.add(message);
    }
  }

  static void markChatAsRead(String chatId) {
    final chat = _chats.firstWhere((c) => c.id == chatId);
    for (int i = 0; i < chat.messages.length; i++) {
      final m = chat.messages[i];
      if (!m.isMe && m.status != MessageStatus.read) {
        chat.messages[i] = m.copyWith(status: MessageStatus.read);
      }
    }
  }

  static void _initializeChats() {
    _chats = [
      Chat(
        id: '1',
        name: 'Alice Johnson',
        avatarUrl: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=150',
        isOnline: true,
        lastSeen: DateTime.now().subtract(const Duration(minutes: 2)),
        messages: [
          Message(
            id: '1',
            text: 'Hey! How are you doing?',
            senderId: '1',
            senderName: 'Alice Johnson',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            isMe: false,
          ),
          Message(
            id: '2',
            text: 'I\'m doing great! Thanks for asking. How about you?',
            senderId: 'me',
            senderName: 'Me',
            timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
            isMe: true,
          ),
          Message(
            id: '3',
            text: 'Same here! Are we still on for dinner tonight?',
            senderId: '1',
            senderName: 'Alice Johnson',
            timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
            isMe: false,
          ),
        ],
      ),
      Chat(
        id: '2',
        name: 'Bob Smith',
        avatarUrl: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=150',
        isOnline: false,
        lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
        messages: [
          Message(
            id: '4',
            text: 'The meeting has been rescheduled to 3 PM',
            senderId: '2',
            senderName: 'Bob Smith',
            timestamp: DateTime.now().subtract(const Duration(hours: 3)),
            isMe: false,
          ),
          Message(
            id: '5',
            text: 'Perfect, I\'ll be there!',
            senderId: 'me',
            senderName: 'Me',
            timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 45)),
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '3',
        name: 'Emma Wilson',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=150',
        isOnline: true,
        lastSeen: DateTime.now(),
        messages: [
          Message(
            id: '6',
            text: 'Happy birthday! 🎉🎂',
            senderId: '3',
            senderName: 'Emma Wilson',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            isMe: false,
          ),
          Message(
            id: '7',
            text: 'Thank you so much! 😊',
            senderId: 'me',
            senderName: 'Me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '4',
        name: 'David Chen',
        avatarUrl: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=150',
        isOnline: false,
        lastSeen: DateTime.now().subtract(const Duration(hours: 5)),
        messages: [
          Message(
            id: '8',
            text: 'Can you send me the project files?',
            senderId: '4',
            senderName: 'David Chen',
            timestamp: DateTime.now().subtract(const Duration(hours: 6)),
            isMe: false,
          ),
          Message(
            id: '9',
            text: 'Sure, I\'ll send them in a few minutes',
            senderId: 'me',
            senderName: 'Me',
            timestamp: DateTime.now().subtract(const Duration(hours: 5, minutes: 30)),
            isMe: true,
          ),
        ],
      ),
      Chat(
        id: '5',
        name: 'Sarah Davis',
        avatarUrl: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=150',
        isOnline: true,
        lastSeen: DateTime.now().subtract(const Duration(minutes: 1)),
        messages: [
          Message(
            id: '10',
            text: 'The weather is so nice today!',
            senderId: '5',
            senderName: 'Sarah Davis',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            isMe: false,
          ),
          Message(
            id: '11',
            text: 'I know right! Perfect for a walk in the park.',
            senderId: 'me',
            senderName: 'Me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
            isMe: true,
          ),
        ],
      ),
    ];
  }
}