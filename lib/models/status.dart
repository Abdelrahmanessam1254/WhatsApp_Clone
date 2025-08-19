class Status {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final List<StatusUpdate> updates;
  final DateTime timestamp;
  final bool isViewed;

  Status({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.updates,
    required this.timestamp,
    this.isViewed = false,
  });

  StatusUpdate? get latestUpdate => updates.isNotEmpty ? updates.last : null;
  int get unviewedCount => updates.where((update) => !update.isViewed).length;
}

class StatusUpdate {
  final String id;
  final String content;
  final StatusType type;
  final DateTime timestamp;
  final bool isViewed;
  final String? backgroundColor;

  StatusUpdate({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isViewed = false,
    this.backgroundColor,
  });
}

enum StatusType { text, image, video }