import 'package:flutter/material.dart';
import 'package:frontend/screens/song_details_page.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../models/track_info.dart';
import '../../theme_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoodboardPage extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final List<String> imagePaths;
  final void Function(String imagePath) onTrackTap;
  final List<TrackInfo> tracksInfo;

  const MoodboardPage({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePaths,
    required this.onTrackTap,
    required this.tracksInfo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final double itemWidth = MediaQuery.of(context).size.width / 2 - 20;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // share functionality here
            },
          ),
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
      body: CustomScrollView(
        slivers: [
          // Description and tags as a SliverList
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.deepPurple.shade300,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tracks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ]),
            ),
          ),

          // The grid of tracks as a SliverGrid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final track = tracksInfo[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  // Inside SliverGrid's delegate
                  onTap: () async {
                    // Removed: onTrackTap(track.imagePath);

                    String? previewUrl;
                    String? trackViewUrl;

                    try {
                      final query = Uri.encodeComponent(
                        "${track.name} ${track.artist}",
                      );
                      final url = Uri.parse(
                        "https://itunes.apple.com/search?term=$query&entity=musicTrack&limit=1",
                      );
                      final response = await http.get(url);

                      if (response.statusCode == 200) {
                        final data = json.decode(response.body);
                        if (data['results'].isNotEmpty) {
                          final result = data['results'][0];
                          previewUrl = result['previewUrl'];
                          trackViewUrl = result['trackViewUrl'];
                        }
                      }
                    } catch (e) {
                      print("Error fetching track metadata: $e");
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SongDetailsPage(
                          title: track.name,
                          artist: track.artist,
                          image: track.imagePath,
                          cover: track.cover ?? track.imagePath,
                          previewUrl: previewUrl,
                          trackViewUrl: trackViewUrl ?? track.appleMusicUrl,
                        ),
                      ),
                    );
                  },

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          track.imagePath,
                          fit: BoxFit.cover,
                          width: itemWidth,
                          height: itemWidth,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: itemWidth,
                        child: Text(
                          track.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: Text(
                          track.artist,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: tracksInfo.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
            ),
          ),

          // Optional extra padding at bottom to avoid cutoff
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String imagePath;

  const FullImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.asset(imagePath)),
    );
  }
}
