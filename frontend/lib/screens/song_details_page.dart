import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../theme_provider.dart';
import 'full_screen_media.dart';

class SongDetailsPage extends StatefulWidget {
  final String title;
  final String artist;
  final String image; // Main header (local or custom UI image)
  final String cover; // Apple album cover (artworkUrl600)
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
  String? genre;
  bool isLoadingGenre = true;

  @override
  void initState() {
    super.initState();
    _fetchGenreFromiTunes();
  }

  /// ✅ Fetch genre from iTunes API
  Future<void> _fetchGenreFromiTunes() async {
    if (widget.title.isEmpty || widget.artist.isEmpty) return;

    final query = Uri.encodeComponent("${widget.title} ${widget.artist}");
    final url = Uri.parse(
      "https://itunes.apple.com/search?term=$query&entity=musicTrack&limit=1",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          setState(() {
            genre = data['results'][0]['primaryGenreName'] ?? "Unknown";
            isLoadingGenre = false;
          });
        }
      } else {
        setState(() => isLoadingGenre = false);
      }
    } catch (e) {
      print("Error fetching genre: $e");
      setState(() => isLoadingGenre = false);
    }
  }

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
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// ✅ Header Image with Play Icon Overlay
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenMedia(
                    imagePath: widget.image,
                    previewUrl: widget.previewUrl,
                    songTitle: widget.title,
                    artistName: widget.artist,
                    autoPlay: widget.previewUrl != null,
                  ),
                ),
              );
            },

            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background image with rounded bottom corners
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: widget.image.startsWith('http')
                      ? Image.network(
                          widget.image,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.image,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

                // Semi-transparent overlay with play icon
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /// ✅ Song Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Song Title
                Text(
                  widget.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                /// Artist (Adapts to Theme)
                Text(
                  widget.artist,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                /// Genre (Adapts to Theme)
                const SizedBox(height: 6),
                isLoadingGenre
                    ? Text(
                        "Loading genre...",
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.grey,
                        ),
                      )
                    : Text(
                        "Genre: ${genre ?? "Unknown"}",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),

                const SizedBox(height: 20),

                /// ✅ Add to Moodboard Button
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 18,
                    ),
                  ),
                  child: const Text(
                    "Add to Moodboard",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 24),

                /// ✅ Apple Music Button + Thumbnail
                if (widget.trackViewUrl != null)
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: widget.cover.startsWith('http')
                            ? Image.network(
                                widget.cover,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.cover,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _openAppleMusic,
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('View in Apple Music'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                if (widget.trackViewUrl != null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Music previews and artwork provided by Apple Music',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
