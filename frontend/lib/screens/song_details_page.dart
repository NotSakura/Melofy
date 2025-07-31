import 'package:flutter/material.dart';
import 'full_screen_media.dart';

class SongDetailsPage extends StatelessWidget {
  final String title;
  final String artist;
  final String coverImage;
  final String trackUrl;

  const SongDetailsPage({
    super.key,
    required this.title,
    required this.artist,
    required this.coverImage,
    required this.trackUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Song Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🎨 Cover Image (Clickable)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenMedia(
                    title: title,
                    artist: artist,
                    coverImage: coverImage,
                    trackUrl: trackUrl, // Pass audio stream URL
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                coverImage,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 🎶 Song Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(artist,
                    style: const TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 20),


                 // Add to Moodboard Button
                ElevatedButton(
                  onPressed: () {
                    // Add to moodboard logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 182, 138, 209),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  ),
                  child: const Text(
                    "Add to Moodboard",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
