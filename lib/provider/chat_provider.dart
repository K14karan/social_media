import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatProvider with ChangeNotifier {
  List<ZIMKitConversation> _conversations = [];
  List<ZIMKitConversation> _filteredConversations = [];
  String _searchQuery = ''; // Store the search query

  // Getter for the list of conversations
  List<ZIMKitConversation> get conversations => _filteredConversations;

  // Getter for the search query
  String get searchQuery => _searchQuery;

  // Fetch conversations dynamically from ZIMKit
  Future<void> loadConversations() async {
    try {
      // Assuming Zego ZIMKit provides a method to fetch conversation list
      List<ZIMKitConversation> fetchedConversations = (await ZIMKit()
          .getConversationListNotifier()) as List<ZIMKitConversation>;
      _conversations = fetchedConversations;
      _filteredConversations =
          _conversations; // Initially show all conversations
      notifyListeners(); // Notify listeners when the data is updated
    } catch (error) {
      // Handle error (show message, log, etc.)
      print('Error loading conversations: $error');
    }
  }

  // Function to filter conversations based on the search query
  void searchConversations(String query) {
    _searchQuery = query;
    _filteredConversations = _conversations
        .where((conversation) =>
            conversation.name?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();
    notifyListeners(); // Notify listeners when the search query changes
  }
}
