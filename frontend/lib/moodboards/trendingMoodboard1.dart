import 'package:flutter/material.dart';
import 'moodboardTemplate.dart';
import '../songs/songScreen.dart';

class TrendingMoodboard1 extends StatelessWidget {
  const TrendingMoodboard1({super.key});

  @override
  Widget build(BuildContext context) {
    // Map each track image to its song data
    final List<Map<String, String>> songs = [
      {
        'title': "That's So True",
        'artist': "Gracie Abrams",
        'genre': "Pop",
        'imagePath': 'assets/images/track1.jpg',
      },
      {
        'title': "Dreamscape Drive",
        'artist': "Lana Sky",
        'genre': "Indie",
        'imagePath': 'assets/images/track2.jpg',
      },
      // Add more songs as needed
    ];

    return MoodboardPage(
      title: 'Summer Daze',
      description: 'Showcasing the blazing yet memorable days of summer',
      tags: ['inspirational', 'whimsical'],
      imagePaths: songs.map((song) => song['imagePath']!).toList(),
      onTrackTap: (imagePath) {
        final song = songs.firstWhere((s) => s['imagePath'] == imagePath);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongScreen(
              title: song['title']!,
              artist: song['artist']!,
              genre: song['genre']!,
              imagePath: song['imagePath']!,
            ),
          ),
        );
      },
    );
  }
}
