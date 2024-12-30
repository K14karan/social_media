import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/view/screens/search/user_search_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  // Method to follow the user
  Future<void> followUser(String userId) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('followers')
            .doc(currentUserId)
            .set({
          'followedAt': Timestamp.now(),
        });
        log("Followed user $userId");
        setState(() {});
      }
    } catch (e) {
      log("Error following user: $e");
    }
  }

  // Method to unfollow the user
  Future<void> unfollowUser(String userId) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('followers')
            .doc(currentUserId)
            .delete();
        log("Unfollowed user $userId");
        setState(() {}); // Trigger a rebuild to refresh the button
      }
    } catch (e) {
      log("Error unfollowing user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<UserProvider>(context);
    log("user: ${searchProvider.searchResults}");

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  labelText: 'Search',
                  hintText: 'Type a name...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 0.5),
                  ),
                ),
                onChanged: (value) {
                  if (value.trim().length > 2) {
                    searchProvider.searchUsers(value.trim());
                  } else {
                    searchProvider.clearResults();
                  }
                },
              ),
            ),
            if (searchProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (searchProvider.errorMessage != null)
              Center(
                child: Text(
                  searchProvider.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
            else if (searchProvider.searchResults.isEmpty)
              const Center(
                child: Text(
                  "No users found",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = searchProvider.searchResults[index];
                    log("User data: $user");
                    log("UserId: ${user["id"]}");

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          user['profilePic'] ?? '',
                        ),
                      ),
                      title: Text(user['name'] ?? ''),
                      trailing: FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(user['id'])
                            .collection("followers")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasData && snapshot.data!.exists) {
                            return TextButton(
                              onPressed: () {
                                unfollowUser(user['id']);
                              },
                              child: Text(
                                'Unfollow',
                                style: Resources.styles
                                    .kTextStyle14B(Resources.colors.themeColor),
                              ),
                            );
                          } else {
                            return TextButton(
                              onPressed: () {
                                followUser(user['id']);
                              },
                              child: Text(
                                'Follow',
                                style: Resources.styles
                                    .kTextStyle14B(Resources.colors.themeColor),
                              ),
                            );
                          }
                        },
                      ),
                      onTap: () {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        log("userId:$userId");
                        if (userId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserProfilePage(userId: user["id"]),
                            ),
                          );
                        } else {
                          log("User ID is null");
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
