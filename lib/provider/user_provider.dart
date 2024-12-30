import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/services/api_services.dart';

class UserProvider with ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();
  bool isLoading = false;
  String? errorMessage;
  List<Map<String, dynamic>> searchResults = [];

  /// Search users by their name (case-insensitive)
  void searchUsers(String query) async {
    if (query.isEmpty) {
      clearResults();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final results = await FirebaseFirestore.instance
          .collection('users')
           .where('name', isEqualTo: query)
          .get();

      searchResults = results.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      errorMessage = null;
    } catch (error) {
      errorMessage = 'Something went wrong. Please try again.';
      searchResults = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Clear search results
  void clearResults() {
    searchResults = [];
    errorMessage = null;
    notifyListeners();
  }
}
