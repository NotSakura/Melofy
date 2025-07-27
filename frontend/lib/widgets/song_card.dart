
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SongCard extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final String previewUrl;

  const SongCard({
    super.key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.previewUrl,
  });

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  void _togglePlayback() async {
    if (isPlaying) {
      await _player.stop();
    } else {
      await _player.play(UrlSource(widget.previewUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Image.network(widget.imageUrl),
          const SizedBox(height: 8),
          Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(widget.artist, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 36),
            onPressed: _togglePlayback,
          ),
        ],
      ),
    );
  }
}