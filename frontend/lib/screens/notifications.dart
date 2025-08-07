import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../widgets/bottom_nav_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final List<_NotificationItem> notifications = const [
    _NotificationItem(
      avatarPath: 'assets/images/notifications_page/notification1.png',
      content: 'Kurby started following you',
      timeAgo: '2h',
    ),
    _NotificationItem(
      avatarPath: 'assets/images/notifications_page/notification3.jpg',
      content: 'Rocky liked your moodboard',
      timeAgo: '4h',
    ),
    _NotificationItem(
      avatarPath: 'assets/images/notifications_page/notification2.jpg',
      content: 'Sakura tagged you in "Coldplay 2025"',
      timeAgo: '6h',
    ),
    _NotificationItem(
      avatarPath: 'assets/images/notifications_page/notification4.jpg',
      content: 'Cura mentioned you in a post',
      timeAgo: '1d',
    ),
    _NotificationItem(
      avatarPath: 'assets/images/notifications_page/notification5.jpg',
      content: 'Amy started following you',
      timeAgo: '2d',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.wb_sunny : Icons.nights_stay,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(
          color: theme.dividerColor,
          height: 1,
          thickness: 0.5,
          indent: 72,
        ),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(notif.avatarPath),
            ),
            title: Text(notif.content, style: theme.textTheme.bodyLarge),
            trailing: Text(
              notif.timeAgo,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            onTap: () {
              // You can add navigation to relevant content here
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _NotificationItem {
  final String avatarPath;
  final String content;
  final String timeAgo;

  const _NotificationItem({
    required this.avatarPath,
    required this.content,
    required this.timeAgo,
  });
}
