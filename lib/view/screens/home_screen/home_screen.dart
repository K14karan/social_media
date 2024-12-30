import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/add_story_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes_name.dart';
import 'package:social_media/services/api_services.dart';
import 'package:social_media/view/screens/chat/chat_list.dart';
import 'package:social_media/view/screens/home_screen/story_view.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      "name": "User 2",
      "time": "4 hours ago",
      "title": "Just another reel for the day!",
      "type": "video",
      "mediaUrl":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
    {
      "name": "User 1",
      "time": "2 hours ago",
      "title": "All I do is win, win, win. No matter what",
      "type": "image",
      "mediaUrl":
          "https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg",
    },
    {
      "name": "User 1",
      "time": "2 hours ago",
      "title": "Adventure Time!",
      "type": "video",
      "mediaUrl":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
    {
      "name": "User 2",
      "time": "4 hours ago",
      "title": "What a great view!",
      "type": "video",
      "mediaUrl":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
  ];

  final Map<int, VideoPlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  VideoPlayerController _getVideoController(String url, int index) {
    if (!_videoControllers.containsKey(index)) {
      _videoControllers[index] = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {}); // Refresh to display the video when initialized
        });
    }
    return _videoControllers[index]!;
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    //final authProvider=Provider.of<AuthProvider>(context,listen:false );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'ConnectMe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Resources.colors.themeColor,
            ),
            onPressed: () async {
              await FirebaseServices().logoutUser();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have logged out successfully'),
                  duration: Duration(seconds: 2),
                ),
              );

              // Navigate to the login screen after a short delay
              Future.delayed(const Duration(seconds: 1), () {
                GoRouter.of(context).pushNamed(RoutesName.loginScreen);
              });
            },
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Resources.colors.themeColor,
              ),
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(RoutesName.navigationScreen, extra: 1);
              }),
          IconButton(
              icon: Icon(
                Icons.notification_add,
                color: Resources.colors.themeColor,
              ),
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  RoutesName.notificationScreen,
                );
              }),
          IconButton(
            icon: Icon(
              Icons.chat,
              color: Resources.colors.themeColor,
            ),
            onPressed: () {
              // Display the alert dialog for user ID and username
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController idController = TextEditingController();
                  TextEditingController nameController =
                      TextEditingController();

                  return AlertDialog(
                    title: Text("Enter User ID and Name"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: idController,
                          decoration: const InputDecoration(labelText: 'User ID'),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'User Name'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          String userId = idController.text.trim();
                          String userName = nameController.text.trim();

                        await  ZIMKit()
                              .connectUser(id: userId, name: userName);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ChatList(),
                              ),
                            );


                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(RoutesName.addPostScreen);
              },
              backgroundColor: Resources.colors.whiteColor.withOpacity(.6),
              child: Icon(Icons.add, color: Resources.colors.themeColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stories Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Stories',
                style: Resources.styles.kTextStyle18B(Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: storyProvider.friendStories.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // User story (Add Story or display uploaded story)
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => storyProvider.addStory(context),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: storyProvider.userStory != null
                              ? FileImage(storyProvider.userStory!)
                                  as ImageProvider
                              : null,
                          child: storyProvider.userStory == null
                              ? Icon(
                                  Icons.add,
                                  color: Resources.colors.themeColor,
                                  size: 28,
                                )
                              : null,
                        ),
                      ),
                    );
                  } else {
                    // Friend's stories
                    final friendStory = storyProvider.friendStories[index - 1];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => _showStoryDialog(context, friendStory),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(friendStory),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),

            const Divider(),
            // Posts Feed Section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final controller = _getVideoController(post['mediaUrl'], index);

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://wallpapers.com/images/hd/russian-girl-actress-ekaterina-kuznetsova-u2itufn94o8sfzvl.jpg",
                            ),
                          ),
                        ),
                        title: Text(
                          "${post['name']}",
                          style: Resources.styles.kTextStyle14B(Colors.black),
                        ),
                        subtitle: Text(
                          "${post['time']}",
                          style: Resources.styles
                              .kTextStyle12B(Resources.colors.greyColor),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Follow/Unfollow button
                            StatefulBuilder(
                              builder: (context, setState) {
                                bool isFollowing =
                                    false; // Initial follow state
                                return TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isFollowing =
                                          !isFollowing; // Toggle follow state
                                    });
                                    // You can add additional logic here for API calls or state management
                                  },
                                  child: Text(
                                    isFollowing ? 'Unfollow' : 'Follow',
                                    style: Resources.styles.kTextStyle14B(
                                        Resources.colors.themeColor),
                                  ),
                                );
                              },
                            ),
                            // More icon with a PopupMenuButton
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'not_interested') {
                                  Fluttertoast.showToast(
                                      msg: "Marked as not interested");
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem<String>(
                                  value: 'not_interested',
                                  child: Text('Not Interested'),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Text(
                          "${post['title']}",
                          style: Resources.styles
                              .kTextStyle14(Resources.colors.blackColor),
                        ),
                      ),
                      if (post['type'] == 'image')
                        Container(
                          height: MediaQuery.of(context).size.height * .32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage("${post['mediaUrl']}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (post['type'] == 'video')
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.value.isPlaying
                                  ? controller.pause()
                                  : controller.play();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                height:
                                    MediaQuery.of(context).size.height * .55,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (controller.value.isInitialized)
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(8),
                                          bottom: Radius.circular(8),
                                        ),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .55,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: SizedBox(
                                              width:
                                                  controller.value.size.width,
                                              height:
                                                  controller.value.size.height,
                                              child: VideoPlayer(controller),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.value.isPlaying)
                                      const Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    Positioned(
                                      bottom: 5,
                                      left: 0,
                                      right: 0,
                                      child: VideoProgressIndicator(
                                        controller,
                                        allowScrubbing: true,
                                        colors: VideoProgressColors(
                                          playedColor:
                                              Resources.colors.blueColor,
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.5),
                                          bufferedColor: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined,
                                    color: Resources.colors.greyColor,
                                    size: 20),
                                const SizedBox(width: 5),
                                Text('Like',
                                    style: Resources.styles.kTextStyle12B(
                                        Resources.colors.greyColor)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.comment,
                                    color: Resources.colors.greyColor,
                                    size: 20),
                                const SizedBox(width: 5),
                                Text('Comment',
                                    style: Resources.styles.kTextStyle12B(
                                        Resources.colors.greyColor)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.share,
                                    color: Resources.colors.greyColor,
                                    size: 20),
                                const SizedBox(width: 5),
                                Text('Share',
                                    style: Resources.styles.kTextStyle12B(
                                        Resources.colors.greyColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showStoryDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StoryViewer(
          imageUrl: imageUrl,
          onClose: () => Navigator.pop(context),
        );
      },
    );
  }
}
