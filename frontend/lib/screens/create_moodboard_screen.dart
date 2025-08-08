import 'package:flutter/material.dart';
import 'package:frontend/models/moodboard.dart';
import 'package:frontend/models/track_info.dart'; // Use shared TrackInfo here
import 'package:frontend/theme_provider.dart';
import 'package:provider/provider.dart';
import '../data/global_moodboards.dart';
import './moodboards/moodboard_template.dart';

class CreateMoodboardPage extends StatefulWidget {
  const CreateMoodboardPage({super.key});

  @override
  State<CreateMoodboardPage> createState() => _CreateMoodboardPageState();
}

class _CreateMoodboardPageState extends State<CreateMoodboardPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> selectedTags = ['Chill', 'Indie'];

  // savedMedia holds full info
  final List<Map<String, String>> savedMedia = [
    {
      'imagePath': 'assets/images/create_moodboard_page/image2.jpg',
      'title': 'Wonderland',
      'artist': 'Taylor Swift',
    },
    {
      'imagePath': 'assets/images/create_moodboard_page/image1.jpg',
      'title': 'That’s so true',
      'artist': 'Gracie Abrams',
    },
    {
      'imagePath': 'assets/images/create_moodboard_page/image3.jpg',
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
    },
  ];

  // suggestedMedia with different image paths to ensure they're different and visible
  final List<Map<String, String>> suggestedMedia = [
    {
      'imagePath': 'assets/images/explore_page/tracks/song1.jpg',
      'title': 'Hey Ya!',
      'artist': 'OutKast',
    },
    {
      'imagePath': 'assets/images/explore_page/tracks/song2.jpg',
      'title': 'Rolling in the Deep',
      'artist': 'Adele',
    },
    {
      'imagePath': 'assets/images/explore_page/tracks/song3.jpg',
      'title': 'Umbrella',
      'artist': 'Rihanna',
    },
    {
      'imagePath': 'assets/images/explore_page/tracks/song4.jpg',
      'title': 'Clocks',
      'artist': 'Coldplay',
    },
    {
      'imagePath': 'assets/images/explore_page/tracks/song5.jpg',
      'title': 'Hips Don’t Lie',
      'artist': 'Shakira',
    },
    {
      'imagePath': 'assets/images/explore_page/tracks/song6.jpg',
      'title': 'Happy',
      'artist': 'Pharrell Williams',
    },
  ];

  // selectedImages only store imagePath strings
  final List<String> selectedImages = [];

  void _toggleSelectImage(String imagePath) {
    setState(() {
      if (selectedImages.contains(imagePath)) {
        selectedImages.remove(imagePath);
      } else {
        selectedImages.add(imagePath);
      }
    });
  }

  void _saveMoodboard() {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one song')),
      );
      return;
    }

    final allMedia = [...savedMedia, ...suggestedMedia];

    final tracksInfo = allMedia
        .where((song) => selectedImages.contains(song['imagePath']))
        .map(
          (song) => TrackInfo(
            imagePath: song['imagePath']!,
            name: song['title'] ?? '',
            artist: song['artist'] ?? '',
            cover: null,
            appleMusicUrl: null,
          ),
        )
        .toList();

    final newMoodboard = Moodboard(
      title: _titleController.text,
      description: _descriptionController.text,
      tags: selectedTags,
      imagePaths: selectedImages,
      tracksInfo: tracksInfo,
    );

    savedMoodboards.add(newMoodboard);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodboardPage(
          title: newMoodboard.title,
          description: newMoodboard.description,
          tags: newMoodboard.tags,
          imagePaths: newMoodboard.imagePaths,
          tracksInfo: newMoodboard.tracksInfo,
          onTrackTap: (path) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Tapped: $path')));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // GridView params and aspect ratio calc
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 16 * 2; // from SingleChildScrollView padding
    final crossAxisSpacing = 12.0;
    final crossAxisCount = 2;

    // Card width calculation
    final cardWidth =
        (screenWidth -
            horizontalPadding -
            crossAxisSpacing * (crossAxisCount - 1)) /
        crossAxisCount;

    // Card height estimate: image(140) + approx text/padding height(48)
    final cardHeight = 140 + 48;

    final aspectRatio = cardWidth / cardHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Moodboard",
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'Moodboard Title',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  fillColor: isDark ? theme.cardColor : Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  fillColor: isDark ? theme.cardColor : Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD966),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tag selector coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Add tags'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5C3FF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _saveMoodboard,
                    child: const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Saved Media Section
              const Text(
                'Saved Media',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tap on song to select',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
                children: savedMedia.map((song) {
                  final imagePath = song['imagePath']!;
                  return ImageCard(
                    imagePath: imagePath,
                    title: song['title']!,
                    artist: song['artist']!,
                    isSelected: selectedImages.contains(imagePath),
                    onTap: () => _toggleSelectImage(imagePath),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // Suggested Media Section
              const Text(
                'Suggested Media',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tap on song to select',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
                children: suggestedMedia.map((song) {
                  final imagePath = song['imagePath']!;
                  return ImageCard(
                    imagePath: imagePath,
                    title: song['title']!,
                    artist: song['artist']!,
                    isSelected: selectedImages.contains(imagePath),
                    onTap: () => _toggleSelectImage(imagePath),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String artist;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageCard({
    required this.imagePath,
    required this.title,
    required this.artist,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 145,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),

          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF8644AF),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.check, size: 30, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
