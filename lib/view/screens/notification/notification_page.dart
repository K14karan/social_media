import 'package:flutter/material.dart';
import 'package:social_media/model/notification_model.dart';
import 'package:social_media/resources/resources.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      avatarUrl: 'https://via.placeholder.com/50',
      username: 'john_doe',
      message: 'liked your post',
      timeAgo: '2h',
      hasAction: false,
    ),
    NotificationItem(
      avatarUrl: 'https://via.placeholder.com/50',
      username: 'anna_smith',
      message: 'started following you',
      timeAgo: '5h',
      hasAction: true,
      actionLabel: 'Follow',
    ),
    NotificationItem(
      avatarUrl: 'https://via.placeholder.com/50',
      username: 'mike_93',
      message: 'commented on your photo: "Awesome!"',
      timeAgo: '1d',
      hasAction: false,
    ),
    NotificationItem(
      avatarUrl: 'https://via.placeholder.com/50',
      username: 'lucy_lu',
      message: 'mentioned you in a comment',
      timeAgo: '3d',
      hasAction: false,
    ),
    NotificationItem(
      avatarUrl: 'https://via.placeholder.com/50',
      username: 'travel_buddy',
      message: 'started following you',
      timeAgo: '1w',
      hasAction: true,
      actionLabel: 'Follow Back',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return NotificationTile(notification: item);
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(notification.avatarUrl),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: notification.username,
              style:
                  Resources.styles.kTextStyle14B(Resources.colors.blackColor),
            ),
            TextSpan(
              text: ' ${notification.message}',
             style:  Resources.styles.kTextStyle14B(Resources.colors.greyColor),
            ),
          ],
        ),
      ),
      subtitle: Text(notification.timeAgo,style: Resources.styles.kTextStyle12B(Resources.colors.blackColor),),

    );
  }
}
