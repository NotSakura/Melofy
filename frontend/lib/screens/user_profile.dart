import 'package:flutter/material.dart';
import 'package:frontend/screens/moodboards/moodboard_template.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../data/global_moodboards.dart';
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

  Widget _buildMoodboardsGrid() {
    final theme = Theme.of(context);
    final double itemWidth = (MediaQuery.of(context).size.width / 2) - 20;

    if (savedMoodboards.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: Text('No moodboards saved yet')),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // Cell taller than wide so title fits
      ),

      itemCount: savedMoodboards.length,
      itemBuilder: (context, index) {
        final moodboard = savedMoodboards[index];
        final imagePath = moodboard.imagePaths.isNotEmpty
            ? moodboard.imagePaths[0]
            : 'assets/images/placeholder.png';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MoodboardPage(
                  title: moodboard.title,
                  description: moodboard.description,
                  tags: moodboard.tags,
                  imagePaths: moodboard.imagePaths,
                  tracksInfo: moodboard.tracksInfo,
                  onTrackTap: (path) {},
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1, // Makes image perfectly square
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 8),
              Text(
                moodboard.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
      body: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(
              'assets/images/user_page/profile_pic.jpg',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '@emma_ho',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          const Text('Music Fan | Toronto'),
          const SizedBox(height: 3),
          const Text('45 followers  •  132 following'),
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
                    Container(
                      width: double.infinity,
                      height: 3,
                      color: Colors.white.withOpacity(0.3),
                    ),
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

          const SizedBox(height: 16),

          // Moodboards / Posts Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: selectedTab == 0
                  ? _buildMoodboardsGrid()
                  : const Center(child: Text('No posts saved yet')),
            ),
          ),
        ],
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
