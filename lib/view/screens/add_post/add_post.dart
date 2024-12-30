// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_media/resources/resources.dart';
// import 'package:video_player/video_player.dart';
//
// class AddPost extends StatefulWidget {
//   const AddPost({super.key});
//
//   @override
//   State<AddPost> createState() => _AddPostState();
// }
//
// class _AddPostState extends State<AddPost> {
//   final TextEditingController _textController = TextEditingController();
//   final ValueNotifier<File?> _mediaFileNotifier = ValueNotifier<File?>(null);
//   final ValueNotifier<VideoPlayerController?> _videoControllerNotifier =
//       ValueNotifier<VideoPlayerController?>(null);
//   final ValueNotifier<double?> _aspectRatioNotifier =
//       ValueNotifier<double?>(null);
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickMedia(bool isPhoto) async {
//     final XFile? pickedFile;
//     if (isPhoto) {
//       pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final file = File(pickedFile.path);
//         _mediaFileNotifier.value = file;
//
//         final decodedImage =
//             await decodeImageFromList(await file.readAsBytes());
//         _aspectRatioNotifier.value = decodedImage.width / decodedImage.height;
//       }
//     } else {
//       pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final videoFile = File(pickedFile.path);
//         final videoController = VideoPlayerController.file(videoFile);
//         await videoController.initialize();
//
//         if (videoController.value.duration <= const Duration(seconds: 60)) {
//           _mediaFileNotifier.value = videoFile;
//           _videoControllerNotifier.value = videoController;
//           _aspectRatioNotifier.value = videoController.value.aspectRatio;
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content:
//                   Text("Please select a video that is 60 seconds or less."),
//             ),
//           );
//           videoController.dispose();
//         }
//       }
//     }
//   }
//
//   void _clearMedia() {
//     _mediaFileNotifier.value = null;
//     _videoControllerNotifier.value?.dispose();
//     _videoControllerNotifier.value = null;
//     _aspectRatioNotifier.value = null;
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     _videoControllerNotifier.value?.dispose();
//     _mediaFileNotifier.dispose();
//     _videoControllerNotifier.dispose();
//     _aspectRatioNotifier.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create a Post"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Add logic for posting content
//             },
//             child: Text(
//               "Post",
//               style:
//                   Resources.styles.kTextStyle16B(Resources.colors.themeColor),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage(Resources.images.noImage),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _textController,
//                       maxLines: null,
//                       decoration: const InputDecoration(
//                         hintText: "What do you want to write..?",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ValueListenableBuilder<File?>(
//                 valueListenable: _mediaFileNotifier,
//                 builder: (context, mediaFile, child) {
//                   return mediaFile != null
//                       ? Stack(
//                           children: [
//                             ValueListenableBuilder<double?>(
//                               valueListenable: _aspectRatioNotifier,
//                               builder: (context, aspectRatio, child) {
//                                 return AspectRatio(
//                                   aspectRatio: aspectRatio ?? 1.0,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Resources.colors.themeColor,
//                                         width: 0.5,
//                                       ),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: ValueListenableBuilder<
//                                           VideoPlayerController?>(
//                                         valueListenable:
//                                             _videoControllerNotifier,
//                                         builder:
//                                             (context, videoController, child) {
//                                           return videoController != null
//                                               ? VideoPlayer(videoController)
//                                               : Image.file(
//                                                   mediaFile,
//                                                   fit: BoxFit.cover,
//                                                 );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: GestureDetector(
//                                 onTap: _clearMedia,
//                                 child: const CircleAvatar(
//                                   backgroundColor: Colors.black54,
//                                   radius: 15,
//                                   child: Icon(
//                                     Icons.close,
//                                     color: Colors.white,
//                                     size: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(
//                           height: MediaQuery.of(context).size.height * .35,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             border: Border.all(
//                               color: Resources.colors.themeColor,
//                               width: 0.5,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "No media selected",
//                             style: Resources.styles
//                                 .kTextStyle12B(Colors.grey[600]),
//                           ),
//                         );
//                 },
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * .05),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.photo, color: Resources.colors.themeColor),
//                     onPressed: () => _pickMedia(true),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.videocam,
//                         color: Resources.colors.themeColor),
//                     onPressed: () => _pickMedia(false),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/provider/add_post_controller.dart';
import 'package:social_media/resources/resources.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<File?> _mediaFileNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<VideoPlayerController?> _videoControllerNotifier =
      ValueNotifier<VideoPlayerController?>(null);
  final ValueNotifier<double?> _aspectRatioNotifier =
      ValueNotifier<double?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia(bool isPhoto) async {
    final XFile? pickedFile;
    if (isPhoto) {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        _mediaFileNotifier.value = file;

        final decodedImage =
            await decodeImageFromList(await file.readAsBytes());
        _aspectRatioNotifier.value = decodedImage.width / decodedImage.height;
      }
    } else {
      pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        final videoFile = File(pickedFile.path);
        final videoController = VideoPlayerController.file(videoFile);
        await videoController.initialize();

        if (videoController.value.duration <= const Duration(seconds: 60)) {
          _mediaFileNotifier.value = videoFile;
          _videoControllerNotifier.value = videoController;
          _aspectRatioNotifier.value = videoController.value.aspectRatio;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Please select a video that is 60 seconds or less."),
            ),
          );
          videoController.dispose();
        }
      }
    }
  }

  void _clearMedia() {
    _mediaFileNotifier.value = null;
    _videoControllerNotifier.value?.dispose();
    _videoControllerNotifier.value = null;
    _aspectRatioNotifier.value = null;
  }

  Future<void> _createPost() async {
    final text = _textController.text;
    final mediaFile = _mediaFileNotifier.value;

    if (text.isEmpty && mediaFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter text or select media")),
      );
      return;
    }

    // Set the mediaType
    String mediaType = 'image';
    if (mediaFile != null && mediaFile.path.endsWith('.mp4')) {
      mediaType = 'video';
    }

    // Create the post using the FirebaseProvider
    final firebaseProvider =
        Provider.of<AddPostController>(context, listen: false);
    await firebaseProvider.createPost(
      text,
      XFile(mediaFile!.path),
      mediaType,
    );

    // After posting, clear the form
    _textController.clear();
    _clearMedia();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post created successfully!")),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _videoControllerNotifier.value?.dispose();
    _mediaFileNotifier.dispose();
    _videoControllerNotifier.dispose();
    _aspectRatioNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a Post",
          style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
        ),
        actions: [
          Consumer<AddPostController>(
            builder: (context, provider, child) {
              return SizedBox(
                width: 160,
                child: TextButton(
                  onPressed: provider.isLoading ? null : _createPost,
                  child: provider.isLoading
                      ? CircularProgressIndicator(
                          color: Resources.colors.themeColor,
                        )
                      : Text(
                          "Post",
                          style: Resources.styles
                              .kTextStyle16B(Resources.colors.themeColor),
                        ),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Resources.images.noImage),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "What do you want to write..?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<File?>(
                valueListenable: _mediaFileNotifier,
                builder: (context, mediaFile, child) {
                  return mediaFile != null
                      ? Stack(
                          children: [
                            ValueListenableBuilder<double?>(
                              valueListenable: _aspectRatioNotifier,
                              builder: (context, aspectRatio, child) {
                                return AspectRatio(
                                  aspectRatio: aspectRatio ?? 1.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Resources.colors.themeColor,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ValueListenableBuilder<
                                          VideoPlayerController?>(
                                        valueListenable:
                                            _videoControllerNotifier,
                                        builder:
                                            (context, videoController, child) {
                                          return videoController != null
                                              ? VideoPlayer(videoController)
                                              : Image.file(
                                                  mediaFile,
                                                  fit: BoxFit.cover,
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: _clearMedia,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  radius: 15,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * .35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Resources.colors.themeColor,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "No media selected",
                            style: Resources.styles
                                .kTextStyle12B(Colors.grey[600]),
                          ),
                        );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo, color: Resources.colors.themeColor),
                    onPressed: () => _pickMedia(true),
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam,
                        color: Resources.colors.themeColor),
                    onPressed: () => _pickMedia(false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
