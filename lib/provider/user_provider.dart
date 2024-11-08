import 'package:flutter/material.dart';
import 'package:social_media/model/search_user_profile.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [
    User(
        id: '1',
        name: 'Alice',
        profilePicture:
            'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3371.jpg'),
    User(
        id: '2',
        name: 'Bob',
        profilePicture:
            'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360'),
    User(
        id: '3',
        name: 'Charlie Kidman',
        profilePicture:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s'),
    // Add more users here
  ];

  List<User> _filteredUsers = [];
  List<User> get filteredUsers => _filteredUsers;

  void searchUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = [];
    } else {
      _filteredUsers = _users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void followUser(User user) {}
}
