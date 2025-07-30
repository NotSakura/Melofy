import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../screens/moodboards/moodboard_template.dart';

class CreateMoodboardPage extends StatefulWidget {
  const CreateMoodboardPage({super.key});

  @override
  State<CreateMoodboardPage> createState() => _CreateMoodboardPageState();
}

class _CreateMoodboardPageState extends State<CreateMoodboardPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> selectedTags = ['Chill', 'Indie'];

  // List of saved songs with details
  final List<Map<String, String>> savedSongs = [
    {
      'imagePath': 'assets/images/create_moodboard_page/1989TV_Cover.webp',
      'title': 'Wonderland',
      'artist': 'Taylor Swift',
    },
    {
      'imagePath': 'assets/images/create_moodboard_page/ThatsSoTrue.jpeg',
      'title': 'That’s so true',
      'artist': 'Gracie Abrams',
    },
    {
      'imagePath': 'assets/images/create_moodboard_page/BlindingLights.png',
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
    },
  ];

  // Track selected songs by their image paths
  List<String> selectedImages = [];

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodboardPage(
          title: _titleController.text,
          description: _descriptionController.text,
          tags: selectedTags,
          imagePaths: selectedImages,
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
    final theme = Theme.of(context); // Get current theme
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Moodboard"),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title TextField
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Moodboard Title',
                  hintStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).cardColor
                      : Colors.white,
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
              // Description TextField
              TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.black),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
                  ),
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).cardColor
                      : Colors.white,
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
              // Buttons Row
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
              // Saved Songs header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Saved Songs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Text(
                'Tap on song to select',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              // Scrollable grid of songs
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                  children: savedSongs.map((song) {
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Color.fromARGB(255, 184, 117, 219),
                    size: 36,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
