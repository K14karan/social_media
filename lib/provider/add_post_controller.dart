import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:social_media/model/add_post_model.dart';
import 'package:social_media/services/api_services.dart';

class AddPostController with ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();

  // State for posts and loading indicator
  List<PostModel> _posts = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  // Create a new post
  Future<void> createPost(String text, XFile file, String mediaType) async {
    try {
      _isLoading = true;
      notifyListeners();

      final mediaUrl =
          await _firebaseServices.uploadToCloudinary(file, mediaType);
      if (mediaUrl != null) {
        final postId = DateTime.now().millisecondsSinceEpoch.toString();
        final timestamp = DateTime.now();

        // Save post to Firebase
        await _firebaseServices.savePost(
            postId, text, mediaUrl, mediaType, timestamp);

        // After saving, update the posts list
        await fetchPosts();
      } else {
        print('Failed to upload media');
      }
    } catch (e) {
      print('Error creating post: $e');
    } finally {
      // Set loading state to false after operation is complete
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch posts from Firestore
  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Fetch posts using Firebase service
      final postsData = await _firebaseServices.fetchPosts();
      _posts = postsData;
      print('posts data: $posts');
      notifyListeners();
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
