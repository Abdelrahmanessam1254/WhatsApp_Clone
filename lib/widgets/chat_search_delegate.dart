import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../screens/chat_detail_screen.dart';

class ChatSearchDelegate extends SearchDelegate {
  final List<Chat> chats;

  ChatSearchDelegate(this.chats);

  @override
  String get searchFieldLabel => "Search chats";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = "",
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = chats.where((chat) =>
    chat.name.toLowerCase().contains(query.toLowerCase()) ||
        (chat.lastMessage?.text.toLowerCase().contains(query.toLowerCase()) ??
            false)).toList();

    return _buildList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = chats.where((chat) =>
        chat.name.toLowerCase().contains(query.toLowerCase())).toList();

    return _buildList(context, results);
  }

  Widget _buildList(BuildContext context, List<Chat> results) {
    if (results.isEmpty) {
      return const Center(child: Text("No chats found"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chat = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat.avatarUrl),
          ),
          title: Text(chat.name),
          subtitle: Text(chat.lastMessage?.text ?? ""),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(chat: chat),
              ),
            );
          },
        );
      },
    );
  }
}
