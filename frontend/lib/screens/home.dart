import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'song_details_page.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> posts = [
    {
      'image': 'assets/images/homepage/Wonderland.jpg',
      'title': 'Wonderland (Taylor’s Version)',
      'artist': 'Taylor Swift',
      'cover': 'assets/images/homepage/Wonderland.jpg',
    },
    {
      'image': 'assets/images/homepage/ThatsSoTrue.jpg',
      'title': "That's so true",
      'artist': 'Gracie Abrams',
      'cover': 'assets/images/homepage/ThatsSoTrue.jpg',
    },
    {
      'image': 'assets/images/homepage/MidnightSerenade.jpg',
      'title': 'Midnight Serenade',
      'artist': 'Luna Harmony',
      'cover': 'assets/images/homepage/MidnightSerenade.jpg',
    },
    {
      'image': 'assets/images/homepage/Reflections.jpg',
      'title': 'Reflections',
      'artist': 'The Neighbourhood',
      'cover': 'assets/images/homepage/Reflections.jpg',
    },
    {
      'image': 'assets/images/homepage/Dreamlight.jpg',
      'title': 'Dreamlight',
      'artist': 'Various Artists',
      'cover': 'assets/images/homepage/Dreamlight.jpg',
    },
    {
      'image': 'assets/images/homepage/AuraEchoes.jpg',
      'title': 'Aura Echoes',
      'artist': 'Echo Bloom',
      'cover': 'assets/images/homepage/AuraEchoes.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'For you',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 14,
            runSpacing: 24,
            children: posts.map((post) {
              return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongDetailsPage(
                      title: post['title']!,
                      artist: post['artist']!,
                      coverImage: post['cover']!,
                      trackUrl: "https://filesamples.com/samples/audio/mp3/sample1.mp3", // demo SoundCloud stream
                    ),
                  ),
                );
              },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        post['image']!,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        height: MediaQuery.of(context).size.width / 2 - 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: Text(
                        post['title']!,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: Text(
                        post['artist']!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

}