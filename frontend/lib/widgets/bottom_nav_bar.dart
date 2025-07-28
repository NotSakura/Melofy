import 'package:flutter/material.dart';
import 'package:frontend/screens/home.dart';
import '../screens/explore.dart';
import '../screens/create_moodboard_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _showCreateModal(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor:
          theme.bottomSheetTheme.backgroundColor ??
          theme.scaffoldBackgroundColor,
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color ?? Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ModalOption(
                    icon: Icons.post_add,
                    label: 'Media Post',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/select-media');
                    },
                  ),
                  _ModalOption(
                    icon: Icons.grid_view,
                    label: 'Moodboard',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateMoodboardPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(
              0,
              -3,
            ), // Shadow upwards since nav bar is at bottom
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
            );
          }
          if (index == 2) {
            _showCreateModal(context);
          }
          // Add other tab navigations if needed
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
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
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color.fromARGB(255, 184, 117, 219)
                  : Colors.purple.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(
              icon,
              size: 28,
              color: isDark ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
