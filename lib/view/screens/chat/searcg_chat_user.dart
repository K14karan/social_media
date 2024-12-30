import 'package:flutter/material.dart';
import 'package:social_media/router/routes_name.dart';

class ChatSearchDelegate extends SearchDelegate<String?> {
  final List<Map<String, dynamic>> chats;

  ChatSearchDelegate(this.chats);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredChats = chats.where((chat) {
      return chat['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        final chat = filteredChats[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(chat['avatarUrl']),
          ),
          title: Text(chat['name']),
          subtitle: Text(chat['lastMessage']),
          onTap: () {
            // Navigate to the chat screen
            Navigator.pushNamed(context, RoutesName.chatScreen, arguments: chat['chatId']);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredChats = chats.where((chat) {
      return chat['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        final chat = filteredChats[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(chat['avatarUrl']),
          ),
          title: Text(chat['name']),
          subtitle: Text(chat['lastMessage']),
          onTap: () {
            // Navigate to the chat screen
            Navigator.pushNamed(context, RoutesName.chatScreen, arguments: chat['chatId']);
          },
        );
      },
    );
  }
}
