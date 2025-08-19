import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../theme/app_theme.dart';
import '../widgets/message_bubble.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isPressed = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Widget _buildAnimatedMessage(Message message, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: FadeTransition(
        opacity: animation,
        child: MessageBubble(message: message),
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: _messageController.text.trim(),
        senderId: 'me',
        senderName: 'Me',
        timestamp: DateTime.now(),
        isMe: true,
      );

      ChatService.addMessage(widget.chat.id, message);
      _messageController.clear();

      setState(() {});
      _listKey.currentState?.insertItem(widget.chat.messages.length - 1);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });

      Future.delayed(const Duration(seconds: 2), () {
        final replyMessages = [
          "That's interesting!",
          "I see what you mean.",
          "Thanks for letting me know!",
          "Got it! 👍",
          "Sounds good to me.",
          "I'll get back to you on that.",
          "Perfect timing!",
          "That works for me.",
        ];

        final randomReply =
        replyMessages[DateTime.now().millisecond % replyMessages.length];

        final replyMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: randomReply,
          senderId: widget.chat.id,
          senderName: widget.chat.name,
          timestamp: DateTime.now(),
          isMe: false,
        );

        ChatService.addMessage(widget.chat.id, replyMessage);

        if (mounted) {
          setState(() {});
          _listKey.currentState?.insertItem(widget.chat.messages.length - 1);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }
      });
    }
  }


  String _getLastSeenText() {
    if (widget.chat.isOnline) {
      return 'online';
    }

    final now = DateTime.now();
    final difference = now.difference(widget.chat.lastSeen);

    if (difference.inMinutes < 1) {
      return 'last seen just now';
    } else if (difference.inMinutes < 60) {
      return 'last seen ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return 'last seen ${difference.inHours}h ago';
    } else {
      return 'last seen ${DateFormat('MMM d').format(widget.chat.lastSeen)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Hero(
              tag: 'chatAvatar_${widget.chat.id}',
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.chat.avatarUrl),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    _getLastSeenText(),
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white70 : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(isDark
                ? 'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                : 'https://images.pexels.com/photos/3568520/pexels-photo-3568520.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            fit: BoxFit.cover,
            opacity: isDark ? 0.05 : 0.1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                initialItemCount: widget.chat.messages.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index, animation) {
                  final message = widget.chat.messages[index];
                  return _buildAnimatedMessage(message, animation);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: isDark ? AppTheme.darkSurface : Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color:
                                  isDark ? Colors.white54 : AppTheme.mediumGray,
                            ),
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.grey[600],
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.attach_file,
                              color:
                                  isDark ? Colors.white54 : AppTheme.mediumGray,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color:
                                  isDark ? Colors.white54 : AppTheme.mediumGray,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _isPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isPressed = false;
                      });
                      _sendMessage();
                    },
                    child: AnimatedScale(
                      scale: _isPressed ? 0.8 : 1.0,
                      duration: const Duration(milliseconds: 150),
                      child: FloatingActionButton(
                        backgroundColor: isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                        mini: true,
                        onPressed: _sendMessage,
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
