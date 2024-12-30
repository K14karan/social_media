// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_media/router/routes_name.dart';
// import 'package:video_player/video_player.dart';
// import 'package:social_media/model/search_user_profile.dart';
// import 'package:social_media/resources/resources.dart';
//
// class MediaItem {
//   final String url;
//   final bool isVideo;
//
//   MediaItem({required this.url, required this.isVideo});
// }
//
// class UserProfilePage extends StatefulWidget {
//   final User user;
//
//   const UserProfilePage({super.key, required this.user});
//
//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }
//
// class _UserProfilePageState extends State<UserProfilePage> {
//   List<VideoPlayerController?> _videoControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoControllers();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _videoControllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }
//
//   void _initializeVideoControllers() {
//     List<MediaItem> galleryItems = [
//       MediaItem(
//           url:
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s',
//           isVideo: false),
//       MediaItem(
//           url:
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//           isVideo: true),
//       MediaItem(
//           url:
//               'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
//           isVideo: false),
//       MediaItem(
//           url:
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//           isVideo: true),
//       MediaItem(
//           url:
//               'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360',
//           isVideo: false),
//     ];
//
//     _videoControllers = galleryItems.map((item) {
//       if (item.isVideo) {
//         var controller = VideoPlayerController.network(item.url);
//         controller.initialize();
//         return controller;
//       } else {
//         return null;
//       }
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           widget.user.name,
//           style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: NetworkImage(widget.user.profilePicture),
//                   ),
//                   const SizedBox(height: 5),
//                   _buildUserStats(),
//                   const SizedBox(height: 5),
//                   _buildActionButtons(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 8.0),
//                     child: Divider(
//                       color: Resources.colors.greyColor,
//                     ),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * .004),
//                   _buildGallery(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserStats() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildStatColumn('Followers', 20),
//         const SizedBox(width: 20),
//         _buildStatColumn('Following', 120),
//       ],
//     );
//   }
//
//   Widget _buildStatColumn(String label, int count) {
//     return Column(
//       children: [
//         Text(
//           count.toString(),
//           style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           label,
//           style: Resources.styles.kTextStyle14B(Colors.grey),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Resources.colors.themeColor,
//             foregroundColor: Colors.white,
//           ),
//           child: Text(
//             'Follow',
//             style: Resources.styles.kTextStyle14B(Colors.white),
//           ),
//         ),
//         const SizedBox(width: 20),
//         ElevatedButton(
//           onPressed: () {
//             GoRouter.of(context).pushNamed(RoutesName.chatScreen);
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Resources.colors.themeColor,
//           ),
//           child: Text(
//             'Message',
//             style: Resources.styles.kTextStyle14B(Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildGallery() {
//     List<MediaItem> galleryItems = [
//       MediaItem(
//           url:
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s',
//           isVideo: false),
//       MediaItem(
//           url:
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//           isVideo: true),
//       MediaItem(
//           url:
//               'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
//           isVideo: false),
//       MediaItem(
//           url:
//               'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//           isVideo: true),
//       MediaItem(
//           url:
//               'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360',
//           isVideo: false),
//     ];
//
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         childAspectRatio: 1 / 1.4,
//         crossAxisSpacing: 0,
//         mainAxisSpacing: 2,
//       ),
//       itemCount: galleryItems.length,
//       itemBuilder: (context, index) {
//         final item = galleryItems[index];
//         final videoController = _videoControllers[index];
//
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FullScreenMediaPage(mediaItem: item),
//               ),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: item.isVideo && videoController != null
//                 ? Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height,
//                         width: MediaQuery.of(context).size.width,
//                         child: AspectRatio(
//                           aspectRatio: videoController.value.aspectRatio,
//                           child: VideoPlayer(videoController),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.play_circle_outline,
//                         color: Colors.white,
//                         size: 25,
//                       ),
//                     ],
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       item.url,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class FullScreenMediaPage extends StatelessWidget {
//   final MediaItem mediaItem;
//
//   const FullScreenMediaPage({super.key, required this.mediaItem});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title:
//             Text('Post', style: TextStyle(color: Resources.colors.whiteColor)),
//         iconTheme: IconThemeData(color: Resources.colors.whiteColor),
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: mediaItem.isVideo
//                       ? VideoPlayerWidget(url: mediaItem.url)
//                       : Image.network(
//                           mediaItem.url,
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                         ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 20,
//             right: 20,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.thumb_up_alt_outlined,
//                           color: Resources.colors.whiteColor, size: 20),
//                       const SizedBox(width: 5),
//                       Text('Like',
//                           style: Resources.styles
//                               .kTextStyle12B(Resources.colors.whiteColor)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.comment,
//                           color: Resources.colors.whiteColor, size: 20),
//                       const SizedBox(width: 5),
//                       Text('Comment',
//                           style: Resources.styles
//                               .kTextStyle12B(Resources.colors.whiteColor)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.share,
//                           color: Resources.colors.whiteColor, size: 20),
//                       const SizedBox(width: 5),
//                       Text('Share',
//                           style: Resources.styles
//                               .kTextStyle12B(Resources.colors.whiteColor)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String url;
//
//   const VideoPlayerWidget({super.key, required this.url});
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/router/routes_name.dart';
import 'package:social_media/view/screens/chat/chat_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({super.key, required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<Map<String, dynamic>> _userData;
  late Future<List<Map<String, dynamic>>> _userGallery;
  int _followerCount = 0;
  int _followingCount = 0;
  bool _isFollowing = false;
  @override
  void initState() {
    super.initState();
    _userData = _fetchUserData();
    _userGallery = _fetchUserGallery();
    _checkFollowStatus();
  }

  Future<void> followUser() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('followers')
            .doc(currentUserId)
            .set({'followedAt': Timestamp.now()});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('following')
            .doc(widget.userId)
            .set({'followedAt': Timestamp.now()});

        setState(() {
          _isFollowing = true;
          _followerCount++;
        });

        log("Followed user ${widget.userId}");
      }
    } catch (e) {
      log("Error following user: $e");
    }
  }

  Future<void> unfollowUser() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('followers')
            .doc(currentUserId)
            .delete();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .collection('following')
            .doc(widget.userId)
            .delete();

        setState(() {
          _isFollowing = false;
          _followerCount--;
        });

        log("Unfollowed user ${widget.userId}");
      }
    } catch (e) {
      log("Error unfollowing user: $e");
    }
  }

  Future<void> _checkFollowStatus() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('followers')
            .doc(currentUserId)
            .get();

        setState(() {
          _isFollowing = doc.exists;
        });
      }
    } catch (e) {
      log("Error checking follow status: $e");
    }
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // Fetch the follower and following count
    QuerySnapshot followersSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .collection("followers")
        .get();
    _followerCount = followersSnapshot.docs.length;

    QuerySnapshot followingSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .collection("following")
        .get();
    _followingCount = followingSnapshot.docs.length;

    return userData;
  }

  Future<List<Map<String, dynamic>>> _fetchUserGallery() async {
    QuerySnapshot gallerySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .collection("posts")
        .get();

    // Return dynamic list of media items from Firestore documents
    return gallerySnapshot.docs.map((doc) {
      return {
        'url': doc['url'],
        'isVideo': doc['isVideo'] ?? false,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userData,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!userSnapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text("User not found")),
          );
        }

        Map<String, dynamic> user = userSnapshot.data!;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              user['name'] ?? 'User',
              style:
                  Resources.styles.kTextStyle16B(Resources.colors.blackColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user['profilePic'] ?? ''),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user["bio"],
                        style: Resources.styles.kTextStyle14B(Colors.black),
                      ),
                      const SizedBox(height: 5),
                      _buildUserStats(),
                      const SizedBox(height: 5),
                      _buildActionButtons(user),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8.0),
                        child: Divider(
                          color: Resources.colors.greyColor,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .004),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: _userGallery,
                        builder: (context, gallerySnapshot) {
                          if (gallerySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!gallerySnapshot.hasData ||
                              gallerySnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("No media available"));
                          }
                          return _buildGallery(gallerySnapshot.data!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatColumn('Followers', _followerCount),
        const SizedBox(width: 20),
        _buildStatColumn('Following', _followingCount),
      ],
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _isFollowing ? unfollowUser : followUser,
          style: ElevatedButton.styleFrom(
              backgroundColor: Resources.colors.themeColor),
          child: Text(
            _isFollowing ? 'Unfollow' : 'Follow',
            style: Resources.styles.kTextStyle12B(Colors.white),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .05,
        ),
        ElevatedButton(
          onPressed: () async {
            await ZIMKit().connectUser(id: widget.userId, name: user['name']);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  userId: widget.userId,
                  name: user['name'],
                  image: user['profilePic'] ?? '',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Resources.colors.themeColor),
          child: Text(
            'Message',
            style: Resources.styles.kTextStyle12B(Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildGallery(List<Map<String, dynamic>> galleryItems) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 2,
      ),
      itemCount: galleryItems.length,
      itemBuilder: (context, index) {
        final item = galleryItems[index];
        log("item:$item");
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenMediaPage(mediaData: item),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: item['isVideo']
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayerWidget(url: item['url']),
                        ),
                      ),
                      const Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['url'],
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class FullScreenMediaPage extends StatelessWidget {
  final Map<String, dynamic> mediaData;

  const FullScreenMediaPage({super.key, required this.mediaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            Text('Post', style: TextStyle(color: Resources.colors.whiteColor)),
        iconTheme: IconThemeData(color: Resources.colors.whiteColor),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: mediaData['isVideo']
                ? VideoPlayerWidget(url: mediaData['url'])
                : Image.network(mediaData['url'],
                    fit: BoxFit.contain, width: double.infinity),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined,
                          color: Resources.colors.whiteColor, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        '10 Likes',
                        style: Resources.styles
                            .kTextStyle14B(Resources.colors.whiteColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment,
                          color: Resources.colors.whiteColor, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        '5 Comments',
                        style: Resources.styles
                            .kTextStyle14B(Resources.colors.whiteColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.url)
//       ..initialize().then((_) {
//         setState(() {
//           _controller.play();
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//         : const Center(
//             child: SizedBox(
//               width: 30,
//               height: 30,
//               child: CircularProgressIndicator(strokeWidth: 2),
//             ),
//           );
//   }
// }
class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
  }
}
