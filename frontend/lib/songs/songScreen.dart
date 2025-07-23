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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                artist,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                      ),
                      child: const Text(
                        'Play',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                      ),
                      child: const Text(
                        'Add to Moodboard',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Text(
                "Genre: $genre",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 15),
              const Text(
                "Streaming Options",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.music_note),
                  SizedBox(width: 8),
                  Text("Spotify"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
