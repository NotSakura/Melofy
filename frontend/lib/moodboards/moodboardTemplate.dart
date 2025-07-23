import 'package:flutter/material.dart';

class MoodboardPage extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final List<String> imagePaths;
  final void Function(String imagePath) onTrackTap;

  const MoodboardPage({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePaths,
    required this.onTrackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Add share functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      backgroundColor: Colors.black54,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              "Tracks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: imagePaths
                    .map(
                      (path) => GestureDetector(
                        onTap: () => onTrackTap(path),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(path, fit: BoxFit.cover),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
