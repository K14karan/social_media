// auth_provider.dart
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/services/api_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // user registration
  Future<User?> registerUser(
    String name,
    String email,
    String password,
    String phone,
    String bio,
    String dob,
    String gender,
    String profilePic,
    String backgroundPic,
  ) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final userInfo = {
        'name': name,
        'email': email,
        'phone': phone,
        'bio': bio,
        'dob': dob,
        'gender': gender,
        'profilePic': profilePic,
        'backgroundPic': backgroundPic,
      };

      User? user =
          await _firebaseServices.registerUser(email, password, userInfo);
      log("userRegister: $user");
      return user;
    } catch (e) {
      log("Error during registration: $e");
      _setErrorMessage("Registration failed. Please try again.");
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // login with  firebase
  Future<User?> loginUser(String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      User? user = await _firebaseServices.loginUser(email, password);
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', user.uid); // Save UID for later use
        _setLoading(false);
        return user;
      }
    } catch (e) {
      _setErrorMessage("Login failed. Please check your credentials.");
      _setLoading(false);
    }

    return null;
  }

  Future<String?> getSessionUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  void clearError() {
    _setErrorMessage(null);
  }

  // get user profile details
  Map<String, dynamic>? _userDetails;

  Map<String, dynamic>? get userDetails => _userDetails;

  Future<void> fetchUserDetails() async {
    try {
      _setLoading(true);
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        // Fetch user details using FirebaseServices
        final userData = await _firebaseServices.getUserDetails(uid);

        if (userData != null) {
          _userDetails = userData;
        } else {
          _setErrorMessage("User details not found.");
        }
      } else {
        _setErrorMessage("No authenticated user found.");
      }
    } catch (e) {
      log("Error fetching user details: $e");
      _setErrorMessage("Failed to fetch user details.");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // update user profile and user background profile

  final picker = ImagePicker();
  XFile? _image;
  XFile? _profileImage;

  XFile? get image => _image;
  XFile? get profileImage => _profileImage;

  // open for camera
  Future<void> openCamera(BuildContext context, String type) async {
    try {
      final pickFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (pickFile != null) {
        _setLoading(true);
        if (type == 'backgroundPic') {
          _image = XFile(pickFile.path);
        } else if (type == 'profilePic') {
          _profileImage = XFile(pickFile.path);
        }
        await uploadImageToCloudinary(
          File(type == 'backgroundPic' ? _image!.path : _profileImage!.path),
          context,
          type,
        );
        _setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Camera error: $e");
      _setLoading(false);
    }
  }

  // open for gallery
  Future<void> openGallery(BuildContext context, String type) async {
    try {
      final pickFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickFile != null) {
        _setLoading(true);
        if (type == 'backgroundPic') {
          _image = XFile(pickFile.path);
        } else if (type == 'profilePic') {
          _profileImage = XFile(pickFile.path);
        }
        await uploadImageToCloudinary(
          File(type == 'backgroundPic' ? _image!.path : _profileImage!.path),
          context,
          type,
        );
        _setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Camera error: $e");
      _setLoading(false);
    }
  }

  // background
  void pickImage(context, String type) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(context).size.height * .15,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      openCamera(context, type);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.camera_alt,
                      color: Resources.colors.themeColor,
                    ),
                    title: Text(
                      "Camera",
                      style: Resources.styles.kTextStyle14B(
                        Resources.colors.greyColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      openGallery(context, type);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: Resources.colors.themeColor,
                    ),
                    title: Text(
                      "Gallery",
                      style: Resources.styles.kTextStyle14B(
                        Resources.colors.greyColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadImageToCloudinary(
      File imageFile, BuildContext context, String type) async {
    const String cloudName = 'dugtetvns';
    const String uploadPreset = 'imageUpload';

    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseData);
        final imageUrl = jsonResponse['secure_url'];

        await saveImageUrlToDatabase(imageUrl, type);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully: $imageUrl')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image upload failed!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading image!')),
      );
    }
  }

  // save image in database
  Future<void> saveImageUrlToDatabase(String imageUrl, type) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("User not logged in");
      }

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        type == 'backgroundPic' ? 'backgroundPic' : 'profilePic': imageUrl,
      });

      log("Image URL saved to Firestore successfully.");
    } catch (e) {
      log("Error saving image URL to Firestore: $e");
    }
  }

  // update user profile
  Future<void> updateUserDetails(
      String name, String dob, String bio, String gender) async {
    try {
      _setLoading(true);
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await _firebaseServices.updateUserDetails(uid, {
          'name': name,
          'dob': dob,
          'bio': bio,
          'gender': gender,
        });
        // Update local user details
        _userDetails = {
          ..._userDetails ?? {},
          'name': name,
          'dob': dob,
          'bio': bio,
          'gender': gender,
        };
        notifyListeners();
      } else {
        _setErrorMessage("No authenticated user found.");
      }
    } catch (e) {
      _setErrorMessage("Failed to update profile details.");
    } finally {
      _setLoading(false);
    }
  }

  // follow list
  int _followersCount = 0;
  int _followingCount = 0;
  List<String> _followers = [];
  List<String> _following = [];

  int get followersCount => _followersCount;
  int get followingCount => _followingCount;
  List<String> get followers => _followers;
  List<String> get following => _following;

  // Fetch follower and following counts
  Future<dynamic> fetchFollowerFollowingCount(String userId) async {
    try {
      var counts = await _firebaseServices.getFollowerFollowingCount(userId);
      _followersCount = counts['followers'] ?? 0;
      _followingCount = counts['following'] ?? 0;
      notifyListeners();
    } catch (e) {
      print('Error fetching counts: $e');
    }
  }

  // Fetch followers list
  Future<dynamic> fetchFollowersList(String userId) async {
    try {
      _followers = await _firebaseServices.getFollowersList(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching followers: $e');
    }
  }

  // Fetch following list
  Future<dynamic> fetchFollowingList(String userId) async {
    try {
      _following = await _firebaseServices.getFollowingList(userId);
      notifyListeners();
    } catch (e) {
      print('Error fetching following: $e');
    }
  }
}
