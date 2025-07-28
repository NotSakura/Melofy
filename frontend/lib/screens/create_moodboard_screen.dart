import 'package:flutter/material.dart';
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
  List<String> selectedImages = [
    'assets/images/create_moodboard_page/1989TV_Cover.webp',
    'assets/images/create_moodboard_page/ThatsSoTrue.jpeg',
    'assets/images/create_moodboard_page/BlindingLights.png',
  ];

  void _saveMoodboard() {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Moodboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.wb_sunny),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // All static content above "Saved Songs"
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Moodboard Title',
                  hintStyle: const TextStyle(color: Colors.black54),
                  fillColor: Colors.white,
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
                style: const TextStyle(color: Colors.black),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: const TextStyle(color: Colors.black54),
                  fillColor: Colors.white,
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
              const SizedBox(height: 40),
              // Saved Songs header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Saved Songs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('See more >', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 12),

              // This is the only scrollable section, fill the rest of the screen height
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                  children: const [
                    ImageCard(
                      imagePath:
                          'assets/images/create_moodboard_page/1989TV_Cover.webp',
                      title: 'Wonderland',
                      artist: 'Taylor Swift',
                    ),
                    ImageCard(
                      imagePath:
                          'assets/images/create_moodboard_page/ThatsSoTrue.jpeg',
                      title: 'That’s so true',
                      artist: 'Gracie Abrams',
                    ),
                    ImageCard(
                      imagePath:
                          'assets/images/create_moodboard_page/BlindingLights.png',
                      title: 'Blinding Lights',
                      artist: 'The Weeknd',
                    ),
                  ],
                ),
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

  const ImageCard({
    required this.imagePath,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: AspectRatio(
            aspectRatio: 1, // Square image
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          artist,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
      ],
    );
  }
}
