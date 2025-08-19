import '../models/status.dart';

class StatusService {
  static List<Status> _statuses = [];

  static List<Status> getStatuses() {
    if (_statuses.isEmpty) {
      _initializeStatuses();
    }
    return _statuses;
  }

  static Status? getStatusById(String id) {
    return _statuses.firstWhere((status) => status.id == id);
  }

  static void addStatus(Status status) {
    _statuses.insert(0, status);
  }

  static void _initializeStatuses() {
    _statuses = [
      Status(
        id: '1',
        userId: '1',
        userName: 'Alice Johnson',
        userAvatar: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=150',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        updates: [
          StatusUpdate(
            id: '1',
            content: 'Beautiful sunset today! 🌅',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            backgroundColor: '#FF6B6B',
          ),
          StatusUpdate(
            id: '2',
            content: 'Having a great day at the beach!',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
            backgroundColor: '#4ECDC4',
          ),
        ],
      ),
      Status(
        id: '2',
        userId: '2',
        userName: 'Bob Smith',
        userAvatar: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=150',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        updates: [
          StatusUpdate(
            id: '3',
            content: 'Working from home today 💻',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            backgroundColor: '#45B7D1',
          ),
        ],
      ),
      Status(
        id: '3',
        userId: '3',
        userName: 'Emma Wilson',
        userAvatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=150',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        updates: [
          StatusUpdate(
            id: '4',
            content: 'Coffee time! ☕',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
            backgroundColor: '#F7DC6F',
          ),
        ],
      ),
      Status(
        id: '4',
        userId: '4',
        userName: 'David Chen',
        userAvatar: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=150',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        updates: [
          StatusUpdate(
            id: '5',
            content: 'New project launch! 🚀',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(hours: 6)),
            backgroundColor: '#BB8FCE',
          ),
        ],
      ),
      Status(
        id: '5',
        userId: '5',
        userName: 'Sarah Davis',
        userAvatar: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=150',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        updates: [
          StatusUpdate(
            id: '6',
            content: 'Weekend vibes! 🎉',
            type: StatusType.text,
            timestamp: DateTime.now().subtract(const Duration(hours: 8)),
            backgroundColor: '#85C1E9',
          ),
        ],
      ),
    ];
  }
}