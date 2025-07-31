import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FullScreenMedia extends StatefulWidget {
  final String title;
  final String artist;
  final String coverImage;
  final String trackUrl;

  const FullScreenMedia({
    super.key,
    required this.title,
    required this.artist,
    required this.coverImage,
    required this.trackUrl,
  });

  @override
  _FullScreenMediaState createState() => _FullScreenMediaState();
}

class _FullScreenMediaState extends State<FullScreenMedia> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _player.setUrl(widget.trackUrl);
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fullscreen Image
          Positioned.fill(
            child: Image.asset(
              widget.coverImage,
              fit: BoxFit.cover,
            ),
          ),

          // 🔙 Back Button (Top-Left)
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Overlay Info + Controls
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.artist,
                    style: const TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _player.pause(),
                      child: const Text("⏸ Pause"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _player.play(),
                      child: const Text("▶ Play"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}