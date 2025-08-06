import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../widgets/bottom_nav_bar.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int selectedTab = 0;

  void _onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                'assets/images/user_page/profile_pic.png',
              ), // Replace with your asset
            ),
            const SizedBox(height: 16),
            const Text(
              '@sophia_loves_music',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            const Text('Music Fan | LA'),
            const SizedBox(height: 3),
            const Text('45 followers  •  231 following'),
            const SizedBox(height: 20),

            // Purple Chip-style buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: const [
                  Chip(
                    label: Text('Edit Profile'),
                    backgroundColor: Color(0xFF7E57C2),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text('Add Social Link'),
                    backgroundColor: Color(0xFF7E57C2),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // Moodboards / Posts Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: _TabLabel(
                            label: 'Moodboards',
                            isSelected: selectedTab == 0,
                            onTap: () => _onTabSelected(0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: _TabLabel(
                            label: 'Posts',
                            isSelected: selectedTab == 1,
                            onTap: () => _onTabSelected(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Stack(
                    children: [
                      // Full background line
                      Container(
                        width: double.infinity,
                        height: 3,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      // Purple overlay for the selected half
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 3,
                              color: selectedTab == 0
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 3,
                              color: selectedTab == 1
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // Placeholder for content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  selectedTab == 0 ? 'Moodboards content' : 'Posts content',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabLabel({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
          color: isSelected
              ? Colors.deepPurple
              : theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
