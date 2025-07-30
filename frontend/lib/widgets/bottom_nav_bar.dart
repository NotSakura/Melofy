import 'package:flutter/material.dart';
import 'package:frontend/screens/home.dart';
import 'package:frontend/screens/explore.dart';
import 'package:frontend/screens/create_moodboard_screen.dart';
import 'package:frontend/screens/select_media_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 2) {
      _showCreateModal(context);
      return;
    }

    Widget destination;
    switch (index) {
      case 0:
        destination = const HomeScreen();
        break;
      case 1:
        destination = const ExplorePage();
        break;
      case 3:
        destination = const Scaffold(body: Center(child: Text('Notifications')));
        break;
      case 4:
        destination = const Scaffold(body: Center(child: Text('Profile')));
        break;
      default:
        destination = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionDuration: Duration.zero,
      ),
    );
  }

  /// ✅ Fixed Modal Navigation (No Freeze)
  void _showCreateModal(BuildContext context) async {
    final theme = Theme.of(context);

    // Wait for modal selection
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // ensures modal dismisses cleanly
      useSafeArea: true,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create a new…',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ModalOption(
                    icon: Icons.post_add,
                    label: 'Media Post',
                    onTap: () => Navigator.of(context).pop('media'),
                  ),
                  _ModalOption(
                    icon: Icons.grid_view,
                    label: 'Moodboard',
                    onTap: () => Navigator.of(context).pop('moodboard'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    // ✅ Navigate AFTER modal fully closes
    if (!context.mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (result == 'media') {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SelectMediaScreen()),
        );
      } else if (result == 'moodboard') {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CreateMoodboardPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: theme.scaffoldBackgroundColor,
      selectedItemColor: isDark ? Colors.white : Colors.black,
      unselectedItemColor: isDark ? Colors.white54 : Colors.black45,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}

class _ModalOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ModalOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(icon, size: 28, color: theme.iconTheme.color),
          ),
          const SizedBox(height: 8),
          Text(label, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
