import 'package:flutter/material.dart';
import '../models/status.dart';
import '../services/status_service.dart';
import '../widgets/status_tile.dart';
import '../theme/app_theme.dart';
import 'status_view_screen.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<Status> statuses = [];

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  void _loadStatuses() {
    setState(() {
      statuses = StatusService.getStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          color: isDark ? AppTheme.darkSurface : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : AppTheme.mediumGray,
                  ),
                ),
              ),
              ListTile(
                leading: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=150',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkGreen : AppTheme.accentColor,
                          border: Border.all(
                            color: isDark ? AppTheme.darkSurface : Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                title: const Text(
                  'My status',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text('Tap to add status update'),
                onTap: () {
                  _showAddStatusDialog();
                },
              ),
              Divider(
                height: 1,
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
            ],
          ),
        ),
        if (statuses.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: isDark ? AppTheme.darkBackground : AppTheme.lightGray,
            child: Text(
              'Recent updates',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : AppTheme.mediumGray,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                final status = statuses[index];
                return StatusTile(
                  status: status,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatusViewScreen(status: status),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ] else ...[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.update,
                    size: 64,
                    color: isDark ? Colors.white24 : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recent updates',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? Colors.white54 : AppTheme.mediumGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showAddStatusDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Status'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'What\'s on your mind?',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final newStatus = Status(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  userId: 'me',
                  userName: 'You',
                  userAvatar: 'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=150',
                  timestamp: DateTime.now(),
                  updates: [
                    StatusUpdate(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      content: controller.text.trim(),
                      type: StatusType.text,
                      timestamp: DateTime.now(),
                      backgroundColor: '#25D366',
                    ),
                  ],
                );

                StatusService.addStatus(newStatus);
                _loadStatuses();
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}