import 'package:flutter/material.dart';

class SongScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;
  final String genre;

  const SongScreen({
    Key? key,
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Song Details')),
      body: Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(artist, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text('Play')),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Moodboard'),
          ),
          const SizedBox(height: 20),
          const Text("Streaming Options"),
          Row(
            children: const [
              Icon(Icons.music_note),
              Text("Spotify"),
              // Add other platforms
            ],
          ),
          Text("Genre: $genre"),
        ],
      ),
    );
  }
}
