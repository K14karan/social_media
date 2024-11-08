import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/resources/resources.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StoryProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? userStory; // Stores the user's story
  List<String> friendStories = [
    'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s',
    'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
    'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360',

  ];

  Future<void> addStory(BuildContext context) async {
    final String? mediaType = await _chooseMediaType(context);
    if (mediaType == 'image') {
      await _pickImage();
    } else if (mediaType == 'video') {
      await _pickVideo();
    }
  }

  Future<String?> _chooseMediaType(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Media Type',style: Resources.styles.kTextStyle14B(Colors.black),),
          content: Text('Choose whether to upload an image or a video.',style: Resources.styles.kTextStyle14B(Colors.grey),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'image'),
              child: Text('Image',style: Resources.styles.kTextStyle14B(Resources.colors.themeColor),),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'video'),
              child: Text('Video',style: Resources.styles.kTextStyle14B(Resources.colors.themeColor),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      userStory = File(image.path);
      _showUploadToast('Image');
      notifyListeners();
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
    );

    if (video != null) {
      VideoPlayerController controller = VideoPlayerController.file(File(video.path));
      await controller.initialize();
      final duration = controller.value.duration;
      if (duration.inSeconds <= 60) {
        userStory = File(video.path);
        _showUploadToast('Video');
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Please select a video of 60 seconds or less.");
      }
    }
  }

  void _showUploadToast(String mediaType) {
    Fluttertoast.showToast(msg: "$mediaType uploaded successfully!");
  }
}
