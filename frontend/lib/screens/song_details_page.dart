import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme_provider.dart';
import 'full_screen_media.dart';

class SongDetailsPage extends StatefulWidget {
  final String title;
  final String artist;
  final String image;
  final String cover;
  final String? previewUrl;
  final String? trackViewUrl;

  const SongDetailsPage({
    super.key,
    required this.title,
    required this.artist,
    required this.image,
    required this.cover,
    this.previewUrl,
    this.trackViewUrl,
  });

  @override
  State<SongDetailsPage> createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {

  Future<void> _openAppleMusic() async {
    if (widget.trackViewUrl != null) {
      final uri = Uri.parse(widget.trackViewUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Song Details',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cover Image (Tap to view fullscreen)
          GestureDetector(
            onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FullScreenMedia(
        imagePath: widget.image, // Pass image
        previewUrl: widget.previewUrl, // Pass preview URL
        songTitle: widget.title,    // Pass song title
        artistName: widget.artist,  // Pass artist name
      ),
    ),
  );
},
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: widget.image.startsWith('http')
                  ? Image.network(widget.image, height: 300, width: double.infinity, fit: BoxFit.cover)
                  : Image.asset(widget.image, height: 300, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 24),

          // Song Info + Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.artist,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    )),
                const SizedBox(height: 20),

                // View in Apple Music Button
                if (widget.trackViewUrl != null)
                  ElevatedButton.icon(
                    onPressed: _openAppleMusic,
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('View in Apple Music'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                if (widget.trackViewUrl != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Music previews provided by Apple Music',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    // Add track to moodboard logic
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