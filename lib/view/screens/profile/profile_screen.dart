import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';
import 'package:video_player/video_player.dart';

class MediaItem {
  final String url;
  final bool isVideo;

  MediaItem({required this.url, required this.isVideo});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<VideoPlayerController?> _videoControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers();
  }

  @override
  void dispose() {
    // Dispose of all video controllers when the widget is disposed
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  void _initializeVideoControllers() {
    // Sample gallery items (images and videos)
    List<MediaItem> galleryItems = [
      MediaItem(
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s',
          isVideo: false),
      MediaItem(
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          isVideo: true),
      MediaItem(
          url:
              'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
          isVideo: false),
      MediaItem(
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          isVideo: true),
      MediaItem(
          url:
              'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360',
          isVideo: false),
    ];

    // Initialize video controllers for video items
    _videoControllers = galleryItems.map((item) {
      if (item.isVideo) {
        var controller = VideoPlayerController.network(item.url);
        controller.initialize();
        return controller;
      } else {
        return null;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Nikol Kidman",
          style: Resources.styles.kTextStyle16B(Resources.colors.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://t4.ftcdn.net/jpg/05/49/86/39/360_F_549863991_6yPKI08MG7JiZX83tMHlhDtd6XLFAMce.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Icon(
                        Icons.edit,
                        color: Resources.colors.whiteColor,
                      ),
                    ),
                    Positioned(
                      bottom: -35,
                      left: MediaQuery.of(context).size.width * 0.03,
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360"),
                      ),
                    ),
                    Positioned(
                      bottom: -45,
                      left: MediaQuery.of(context).size.width * 0.25,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Text(
                            "I'm a software Engineer at the Tata Consultancy Services.",
                            style: Resources.styles.kTextStyle14(Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .08),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "20",
                              style: Resources.styles
                                  .kTextStyle14B(Resources.colors.greyColor),
                            ),
                            Text(
                              "Followers",
                              style: Resources.styles
                                  .kTextStyle14B(Resources.colors.blackColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "20",
                              style: Resources.styles
                                  .kTextStyle14B(Resources.colors.greyColor),
                            ),
                            Text(
                              "Following",
                              style: Resources.styles
                                  .kTextStyle14B(Resources.colors.blackColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RoutesName.editProfileScreen);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * .04,
                            width: MediaQuery.of(context).size.width * .25,
                            decoration: BoxDecoration(
                                color: Resources.colors.themeColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Edit Profile",
                              style: Resources.styles
                                  .kTextStyle12B(Resources.colors.whiteColor),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                  child: Divider(
                    color: Resources.colors.greyColor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .004),
                _buildGallery(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallery() {
    // Sample gallery items (images and videos)
    List<MediaItem> galleryItems = [
      MediaItem(
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS6xn1hVT8NIz70qdzI-1bYTFecpqNOhNCkQ&s',
          isVideo: false),
      MediaItem(
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          isVideo: true),
      MediaItem(
          url:
              'https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg',
          isVideo: false),
      MediaItem(
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          isVideo: true),
      MediaItem(
          url:
              'https://img.freepik.com/premium-photo/beautiful-russian-girl-city-park_333900-3225.jpg?w=360',
          isVideo: false),
    ];

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
        final videoController = _videoControllers[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenMediaPage(mediaItem: item),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.isVideo && videoController != null
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        ),
                      ),
                      const Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 25,
                      ),
                      Positioned(
                          left: 5,
                          bottom: 5,
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_arrow_outlined,
                                color: Resources.colors.whiteColor,
                              ),
                              Text(
                                "212",
                                style: Resources.styles
                                    .kTextStyle12B(Resources.colors.whiteColor),
                              )
                            ],
                          ))
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.url,
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
  final MediaItem mediaItem;

  const FullScreenMediaPage({super.key, required this.mediaItem});

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
            child: Column(
              children: [
                Expanded(
                  child: mediaItem.isVideo
                      ? VideoPlayerWidget(url: mediaItem.url)
                      : Image.network(
                          mediaItem.url,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                ),
              ],
            ),
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
                      Text('Like',
                          style: Resources.styles
                              .kTextStyle12B(Resources.colors.whiteColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment,
                          color: Resources.colors.whiteColor, size: 20),
                      const SizedBox(width: 5),
                      Text('Comment',
                          style: Resources.styles
                              .kTextStyle12B(Resources.colors.whiteColor)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.share,
                          color: Resources.colors.whiteColor, size: 20),
                      const SizedBox(width: 5),
                      Text('Share',
                          style: Resources.styles
                              .kTextStyle12B(Resources.colors.whiteColor)),
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

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
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
