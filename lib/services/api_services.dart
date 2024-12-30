// firebase_services.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/model/add_post_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

// user register
  Future<User?> registerUser(
    String email,
    String password,
    Map<String, dynamic> userInfo,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      log("Authenticated user UID: $uid");
      await _fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userInfo);

      log("register user: ${userCredential.user}");
      return userCredential.user;
    } catch (e) {
      log("Error in FirebaseServices.registerUser: $e");
      rethrow;
    }
  }

// user login
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("loginUser : ${userCredential.user}");
      return userCredential.user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // user logout
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await _auth.signOut();
  }

  // get user details
  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await _fireStore.collection('users').doc(currentUser.uid).get();
        return snapshot.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user details: $e");
      }
    }
    return null;
  }

  // Update user profile details
  Future<void> updateUserDetails(
      String uid, Map<String, dynamic> userDetails) async {
    try {
      await _fireStore.collection('users').doc(uid).update(userDetails);
    } catch (e) {
      throw Exception("Failed to update user details: $e");
    }
  }

  // add post
  Future<String?> uploadToCloudinary(XFile file, String mediaType) async {
    const String cloudName = 'dugtetvns';
    const String uploadPreset = 'imageUpload';
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/$mediaType/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString())
          as Map<String, dynamic>;
      return responseData['secure_url'] as String;
    } else {
      return null;
    }
  }

  // Save post to Firestore
  Future<void> savePost(String id, String text, String mediaUrl,
      String mediaType, DateTime timestamp) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final post = {
        'id': id,
        'text': text,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'timestamp': timestamp.toIso8601String(),
        "userId": uid
      };
      await _fireStore.collection('posts').add(post).then((value) {
        log("save :$value");
      }).onError((error, stackTrace) {
        log("errors :$error");
      });
    } catch (e) {
      print('Error saving post: $e');
    }
  }

  // Fetch posts from Firestore
  Future<List<PostModel>> fetchPosts() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // Correct the query
    final snapshot = await _fireStore
        .collection('posts')
        .where('userId', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .get();

    // Convert snapshot to PostModel list
    List<PostModel> posts =
        snapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();

    log("Fetched posts: $posts");
    return posts;
  }

  // Get total follower and following count
  Future<Map<String, int>> getFollowerFollowingCount(String userId) async {
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('users').doc(userId).get();
    int followersCount =
        (userSnapshot.data() as Map<String, dynamic>)['followers']?.length ?? 0;
    int followingCount =
        (userSnapshot.data() as Map<String, dynamic>)['following']?.length ?? 0;

    return {'followers': followersCount, 'following': followingCount};
  }

  // Get a list of followers
  Future<List<String>> getFollowersList(String userId) async {
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('users').doc(userId).get();
    List<String> followers = List<String>.from(
        (userSnapshot.data() as Map<String, dynamic>)['followers'] ?? []);
    return followers;
  }

  // Get a list of following users
  Future<List<String>> getFollowingList(String userId) async {
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('users').doc(userId).get();
    List<String> following = List<String>.from(
        (userSnapshot.data() as Map<String, dynamic>)['following'] ?? []);
    return following;
  }

  // get all user list
  Future<List<QueryDocumentSnapshot>> searchUsers(String name) async {
    try {
      final querySnapshot = await _fireStore
          .collection('users')
          .where('name',arrayContains : name)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }


}
