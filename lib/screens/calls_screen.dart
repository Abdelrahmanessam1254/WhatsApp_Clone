import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CallType { incoming, outgoing, missed }

class Call {
  final String id;
  final String name;
  final String avatarUrl;
  final DateTime timestamp;
  final CallType type;

  Call({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.timestamp,
    required this.type,
  });
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  List<Call> get calls => [
    Call(
      id: "1",
      name: "John Doe",
      avatarUrl: "https://i.pravatar.cc/150?img=1",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      type: CallType.missed,
    ),
    Call(
      id: "2",
      name: "Sarah Smith",
      avatarUrl: "https://i.pravatar.cc/150?img=2",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: CallType.incoming,
    ),
    Call(
      id: "3",
      name: "Alex Johnson",
      avatarUrl: "https://i.pravatar.cc/150?img=3",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: CallType.outgoing,
    ),
  ];

  Icon _getCallIcon(CallType type, bool isDark) {
    switch (type) {
      case CallType.incoming:
        return Icon(Icons.call_received,
            color: isDark ? Colors.greenAccent : Colors.green, size: 18);
      case CallType.outgoing:
        return Icon(Icons.call_made,
            color: isDark ? Colors.blueAccent : Colors.blue, size: 18);
      case CallType.missed:
        return const Icon(Icons.call_missed,
            color: Colors.redAccent, size: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(call.avatarUrl),
              radius: 25,
            ),
            title: Text(
              call.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            subtitle: Row(
              children: [
                _getCallIcon(call.type, isDark),
                const SizedBox(width: 6),
                Text(
                  DateFormat('dd/MM hh:mm a').format(call.timestamp),
                  style: TextStyle(
                    color: call.type == CallType.missed
                        ? Colors.red
                        : (isDark ? Colors.white54 : Colors.black54),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () {
                // later: trigger call
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // later: new call action
        },
        child: const Icon(Icons.add_call),
      ),
    );
  }
}
