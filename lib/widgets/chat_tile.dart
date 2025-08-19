import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat.dart';
import '../theme/app_theme.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      return DateFormat('HH:mm').format(timestamp);
    } else {
      return DateFormat('dd/MM').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'chatAvatar_${chat.id}',
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(chat.avatarUrl),
                  ),
                ),
                if (chat.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                        border: Border.all(
                          color: isDark ? AppTheme.darkBackground : Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        chat.lastMessage != null
                            ? _formatTime(chat.lastMessage!.timestamp)
                            : '',
                        style: TextStyle(
                          fontSize: 12,
                          color: chat.unreadCount > 0
                              ? (isDark ? AppTheme.darkGreen : AppTheme.accentColor)
                              : (isDark ? Colors.white54 : AppTheme.mediumGray),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (chat.lastMessage?.isMe == true)
                        Icon(
                          Icons.done_all,
                          size: 16,
                          color: isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                        ),
                      if (chat.lastMessage?.isMe == true)
                        const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          chat.lastMessage?.text ?? 'No messages yet',
                          style: TextStyle(
                            fontSize: 14,
                            color: chat.unreadCount > 0
                                ? (isDark ? Colors.white : Colors.black87)
                                : (isDark ? Colors.white54 : AppTheme.mediumGray),
                            fontWeight: chat.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
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