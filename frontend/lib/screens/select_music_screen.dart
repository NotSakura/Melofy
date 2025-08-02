import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'full_screen_media.dart';

class SelectMusicScreen extends StatefulWidget {
  final Uint8List selectedImage;
  final VoidCallback? onBack;

  const SelectMusicScreen({super.key, required this.selectedImage, this.onBack});

  @override
  _SelectMusicScreenState createState() => _SelectMusicScreenState();
}

class _SelectMusicScreenState extends State<SelectMusicScreen> {
  List<dynamic> trendingTracks = [];
  List<dynamic> recommendedTracks = [];
  List<dynamic> displayedTracks = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingTrack;
  String _activeTab = "Trending";
  String? _selectedTrackName;
  String? _selectedArtist;
  String? _selectedPreviewUrl;
  String? _selectedTrackId;

  @override
  void initState() {
    super.initState();
    _fetchTrendingTracks();
    _fetchRecommendedTracks();
  }

  Future<void> _fetchTrendingTracks() async {
    await _searchMusic("Taylor Swift", isTrending: true);
  }

  Future<void> _fetchRecommendedTracks() async {
    await _searchMusic("Ed Sheeran", isTrending: false);
  }

  Future<void> _searchMusic(String query, {bool? isTrending}) async {
    if (query.isEmpty) return;
    setState(() => isLoading = true);

    try {
      final url = Uri.parse("https://itunes.apple.com/search?term=$query&entity=musicTrack&limit=10");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (isTrending == true) {
            trendingTracks = data['results'];
            displayedTracks = trendingTracks;
          } else if (isTrending == false) {
            recommendedTracks = data['results'];
          } else {
            displayedTracks = data['results'];
          }
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

  Future<void> _playPreview(String url, String trackId, String trackName, String artist) async {
    try {
      if (_currentlyPlayingTrack == trackId) {
        await _audioPlayer.stop();
        setState(() {
          _currentlyPlayingTrack = null;
          _selectedTrackId = null;
          _selectedTrackName = null;
          _selectedArtist = null;
          _selectedPreviewUrl = null;
        });
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(url));
        setState(() {
          _currentlyPlayingTrack = trackId;
          _selectedTrackId = trackId;
          _selectedTrackName = trackName;
          _selectedArtist = artist;
          _selectedPreviewUrl = url;
        });
      }
    } catch (e) {
      print("Audio play error: $e");
    }
  }

  void _switchTab(String tab) {
    setState(() {
      _activeTab = tab;
      displayedTracks = tab == "Trending" ? trendingTracks : recommendedTracks;
    });
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBack != null) widget.onBack!();
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Image Preview
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

          /// ✅ Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onSubmitted: (query) => _searchMusic(query),
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

          /// ✅ Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _switchTab("Trending"),
                  child: Text(
                    "Trending",
                    style: TextStyle(
                      fontWeight: _activeTab == "Trending"
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 14,
                      color: _activeTab == "Trending"
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _switchTab("Recommended"),
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                      fontWeight: _activeTab == "Recommended"
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 14,
                      color: _activeTab == "Recommended"
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// ✅ Song List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: displayedTracks.length,
                    itemBuilder: (context, index) {
                      final track = displayedTracks[index];
                      final previewUrl = track['previewUrl'];
                      final trackId = track['trackId'].toString();

                      return InkWell(
                        onTap: () {
                          if (previewUrl != null) {
                            _playPreview(
                              previewUrl,
                              trackId,
                              track['trackName'],
                              track['artistName'],
                            );
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

          /// ✅ "Choose" Button (Triggers Fullscreen Preview)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: (_selectedPreviewUrl == null)
                ? null
                : () async {
                    await _audioPlayer.stop(); // ✅ Stop preview playback before fullscreen
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenMedia(
                          imageBytes: widget.selectedImage,
                          previewUrl: _selectedPreviewUrl,
                          songTitle: _selectedTrackName,
                          artistName: _selectedArtist,
                          autoPlay: true,
                        ),
                      ),
                    );

                    /// ✅ After returning, clear current playback so icon shows "play"
                    setState(() {
                      _currentlyPlayingTrack = null; // Ensure it shows play icon
                    });
                  },
                          style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedPreviewUrl == null)
                    ? Colors.grey
                    : Colors.purple[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Choose",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
