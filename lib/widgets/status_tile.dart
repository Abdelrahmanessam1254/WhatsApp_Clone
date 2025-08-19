import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/status.dart';
import '../theme/app_theme.dart';

class StatusTile extends StatelessWidget {
  final Status status;
  final VoidCallback onTap;

  const StatusTile({
    super.key,
    required this.status,
    required this.onTap,
  });

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d').format(timestamp);
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
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: status.unviewedCount > 0
                          ? [
                        isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                        isDark ? AppTheme.darkGreen.withValues(alpha: 0.7) : AppTheme.accentColor.withValues(alpha: 0.7),
                      ]
                          : [Colors.grey, Colors.grey],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(status.userAvatar),
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
                        status.userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _formatTime(status.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : AppTheme.mediumGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.latestUpdate?.content ?? 'No updates',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : AppTheme.mediumGray,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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