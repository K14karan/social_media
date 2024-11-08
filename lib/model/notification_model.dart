class NotificationItem {
  final String avatarUrl;
  final String username;
  final String message;
  final String timeAgo;
  final bool hasAction;
  final String? actionLabel;

  NotificationItem({
    required this.avatarUrl,
    required this.username,
    required this.message,
    required this.timeAgo,
    this.hasAction = false,
    this.actionLabel,
  });
}
