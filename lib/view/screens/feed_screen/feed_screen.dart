import 'package:flutter/material.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/view/screens/feed_screen/comment.dart';
import 'package:social_media/widget/animation.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  VideoController videoController = VideoController();
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  profilePhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                profilePhoto,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        itemCount: 15,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // Sample video data
          final videoData = VideoData(
            videoUrl:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            username: "username$index",
            caption: "caption$index",
            songName: "songName$index",
            profilePhoto:
                "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202209/meglanning_1200x768.jpeg?VersionId=FBiIKfIadFiqO0DcBpHmUvPwNiuj4IZB&size=690:388",
            likes: ["user1", "user2"],
            commentCount: 25,
            shareCount: 15,
          );

          return Stack(
            children: [
              VideoPlayerItem(
                videoUrl: videoData.videoUrl,
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10,bottom: 3),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  videoData.username,
                                  style: Resources.styles.kTextStyle14B(Resources.colors.blackColor),
                                ),
                                Text(
                                  videoData.caption,
                                  style: Resources.styles.kTextStyle12B(Resources.colors.blackColor),
                                ),
                                Row(
                                  children: [
                                     Icon(
                                      Icons.music_note,
                                      size: 15,
                                      color: Resources.colors.blackColor,
                                    ),
                                    Text(
                                      videoData.songName,
                                      style: Resources.styles.kTextStyle12B(Resources.colors.blackColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .15,
                          margin: EdgeInsets.only(top: size.height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child:  Icon(
                                      Icons.favorite_border,
                                      size: 30,
                                      color: Resources.colors.blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    videoData.likes.length.toString(),
                                      style: Resources.styles.kTextStyle14(Resources.colors.blackColor),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(),
                                      ),
                                    ),
                                    child:  Icon(
                                      Icons.comment,
                                      size: 30,
                                      color: Resources.colors.blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    videoData.commentCount.toString(),
                                    style: Resources.styles.kTextStyle14(Resources.colors.blackColor),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child:  Icon(
                                      Icons.reply,
                                      size: 30,
                                      color: Resources.colors.blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                   Text(
                                    "reply",
                                    style: Resources.styles.kTextStyle14(Resources.colors.blackColor),
                                  )
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum(videoData.profilePhoto),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class VideoController {
  // This should be defined with necessary properties and methods
  List<VideoData> videoList = [];
}

class VideoData {
  final String videoUrl;
  final String username;
  final String caption;
  final String songName;
  final String profilePhoto;
  final List<String> likes;
  final int commentCount;
  final int shareCount;

  VideoData({
    required this.videoUrl,
    required this.username,
    required this.caption,
    required this.songName,
    required this.profilePhoto,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
  });
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              color: Resources.colors.themeColor,
            ),
          );
  }
}
