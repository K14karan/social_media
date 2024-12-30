import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/add_post_model.dart';
import 'package:social_media/provider/add_post_controller.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';
import 'package:social_media/view/screens/profile/following_list.dart';
import 'package:video_player/video_player.dart';

import 'followers_list.dart';

class ProfileScreen extends StatefulWidget {
final String userId;
  const ProfileScreen({super.key, required this.userId,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<VideoPlayerController?> _videoControllers = [];
  late AddPostController addPostController;

  void _initializeVideoControllers() {
    log('Initializing video controllers with posts: ${addPostController.posts.length}');

    _videoControllers = addPostController.posts.map((PostModel item) {
      if (item.mediaType == "video") {
        log('Initializing video controller for: ${item.mediaUrl}');
        return VideoPlayerController.network(item.mediaUrl)
          ..initialize().then((_) {
            setState(() {});
          });
      } else {
        return null;
      }
    }).toList();
  }

  late AuthProvider authProvider;
  loadData() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.fetchUserDetails();
    addPostController = Provider.of<AddPostController>(context, listen: false);
    addPostController.fetchPosts();
    _initializeVideoControllers();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  void dispose() {
    // Dispose of all video controllers when the widget is disposed
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(
      context,
    );
    addPostController = Provider.of<AddPostController>(
      context,
    );

    log("dataaa:${addPostController.posts}");
    log('Posts: ${addPostController.posts.length}, VideoControllers: ${_videoControllers.length}');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${authProvider.userDetails?["name"]}",
              style:
                  Resources.styles.kTextStyle16B(Resources.colors.blackColor),
            ),
            Text(
              "${authProvider.userDetails?["phone"]}",
              style: Resources.styles.kTextStyle14(Resources.colors.blackColor),
            ),
          ],
        ),
      ),
      body: authProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Resources.colors.themeColor,
              ),
            )
          : Consumer<AuthProvider>(builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            provider.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Resources.colors.themeColor,
                                  ))
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        .22,
                                    decoration: BoxDecoration(
                                      image: provider.image != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                  File(provider.image!.path)),
                                              fit: BoxFit.cover,
                                            )
                                          : provider.userDetails?[
                                                      "backgroundPic"] !=
                                                  null
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    provider.userDetails![
                                                        "backgroundPic"],
                                                  ),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image: NetworkImage(Resources
                                                      .images.noImages),
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                            Positioned(
                              top: 10,
                              right: 15,
                              child: InkWell(
                                onTap: () => provider.pickImage(
                                    context, 'backgroundPic'),
                                child: Icon(Icons.edit,
                                    color: Resources.colors.themeColor),
                              ),
                            ),
                            // Profile Image
                            Positioned(
                              bottom: -35,
                              left: MediaQuery.of(context).size.width * 0.03,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                backgroundImage: provider.profileImage != null
                                    ? FileImage(
                                        File(provider.profileImage!.path))
                                    : provider.userDetails?["profilePic"] !=
                                            null
                                        ? NetworkImage(
                                            provider.userDetails!["profilePic"])
                                        : NetworkImage(
                                                Resources.images.noImages)
                                            as ImageProvider,
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.15,
                              bottom: -30,
                              child: GestureDetector(
                                onTap: () {
                                  print("Tapped on profile image edit.");
                                  provider.pickImage(context, 'profilePic');
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: Resources.colors.themeColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -35,
                              left: MediaQuery.of(context).size.width * 0.25,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.78,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Text(
                                    "${provider.userDetails?["bio"]}",
                                    style: Resources.styles
                                        .kTextStyle14(Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .08),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.userDetails?["dob"]}",
                                    style: Resources.styles
                                        .kTextStyle14(Colors.black),
                                  ),
                                  Text(
                                    "dob",
                                    style: Resources.styles
                                        .kTextStyle14B(Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.userDetails?["gender"]}",
                                    style: Resources.styles
                                        .kTextStyle14(Colors.black),
                                  ),
                                  Text(
                                    "Gender",
                                    style: Resources.styles
                                        .kTextStyle14B(Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.userDetails?["email"]}",
                                    style: Resources.styles
                                        .kTextStyle14(Colors.black),
                                  ),
                                  Text(
                                    "Email",
                                    style: Resources.styles
                                        .kTextStyle14B(Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowersListScreen(userId: widget.userId),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${provider.followersCount}",
                                        style: Resources.styles.kTextStyle14B(
                                            Resources.colors.greyColor),
                                      ),
                                      Text(
                                        "Followers",
                                        style: Resources.styles.kTextStyle14B(
                                            Resources.colors.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .05,
                                ),
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FollowingListScreen(userId: widget.userId),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${provider.followingCount}",
                                        style: Resources.styles.kTextStyle14B(
                                            Resources.colors.greyColor),
                                      ),
                                      Text(
                                        "Following",
                                        style: Resources.styles.kTextStyle14B(
                                            Resources.colors.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                        RoutesName.editProfileScreen);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    decoration: BoxDecoration(
                                        color: Resources.colors.themeColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Edit Profile",
                                      style: Resources.styles.kTextStyle12B(
                                          Resources.colors.whiteColor),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8.0),
                          child: Divider(
                            color: Resources.colors.greyColor,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .004),
                        _buildGallery(),
                      ],
                    ),
                  ],
                ),
              );
            }),
    );
  }

  Widget _buildGallery() {
    if (addPostController.posts.isEmpty) {
      return const Center(
        child: Text(
          "No posts available",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 2,
      ),
      itemCount: addPostController.posts.length,
      itemBuilder: (context, index) {
        final PostModel item = addPostController.posts[index];
        final videoController = _videoControllers[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenMediaPage(postModel: item),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.mediaType == "video" && videoController != null
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
                      item.mediaUrl,
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
  final PostModel postModel;
  const FullScreenMediaPage({
    super.key,
    required this.postModel,
  });

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
                  child: postModel.mediaType == "video"
                      ? VideoPlayerWidget(url: postModel.mediaUrl)
                      : Image.network(
                          postModel.mediaUrl,
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
