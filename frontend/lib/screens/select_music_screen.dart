import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class SelectMusicScreen extends StatefulWidget {
  final Uint8List selectedImage;

  const SelectMusicScreen({super.key, required this.selectedImage});

  @override
  _SelectMusicScreenState createState() => _SelectMusicScreenState();
}

class _SelectMusicScreenState extends State<SelectMusicScreen> {
  List<dynamic> tracks = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingTrack;

  Future<void> searchMusic(String query) async {
    if (query.isEmpty) return;
    setState(() => isLoading = true);

    try {
      final url = Uri.parse("https://itunes.apple.com/search?term=$query&entity=musicTrack&limit=10");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          tracks = data['results'];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching music: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _playPreview(String url, String trackId) async {
    try {
      if (_currentlyPlayingTrack == trackId) {
        await _audioPlayer.stop();
        setState(() => _currentlyPlayingTrack = null);
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(url));
        setState(() => _currentlyPlayingTrack = trackId);
      }
    } catch (e) {
      print("Audio play error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // ✅ Load default tracks but DON'T auto-play
    searchMusic("Taylor Swift");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: const Text('New Post', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Image Preview
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(widget.selectedImage,
                  height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Choose a music track",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),

          // ✅ Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onSubmitted: searchMusic,
              decoration: InputDecoration(
                hintText: 'Search for music',
                filled: true,
                fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ✅ Song List (Tap Anywhere to Play)
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];
                      final previewUrl = track['previewUrl'];
                      final trackId = track['trackId'].toString();

                      return InkWell(
                        onTap: () {
                          if (previewUrl != null) {
                            _playPreview(previewUrl, trackId);
                          }
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(track['artworkUrl100'],
                                height: 50, width: 50, fit: BoxFit.cover),
                          ),
                          title: Text(track['trackName'] ?? '',
                              style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                          subtitle: Text(track['artistName'] ?? '',
                              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                          trailing: Icon(
                            _currentlyPlayingTrack == trackId
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: Colors.purple,
                            size: 32,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
