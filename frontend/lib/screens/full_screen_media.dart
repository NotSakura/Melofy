import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FullScreenMedia extends StatefulWidget {
  final Uint8List? imageBytes; // ✅ Support Uint8List for memory image
  final String? imagePath; // ✅ Optional asset/network image path
  final String? previewUrl;
  final String? songTitle;
  final String? artistName;
  final bool autoPlay; // ✅ NEW

  const FullScreenMedia({
    super.key,
    this.imageBytes,
    this.imagePath,
    this.previewUrl,
    this.songTitle,
    this.artistName,
    this.autoPlay = false, // ✅ Default: don't auto-play
  });

  @override
  State<FullScreenMedia> createState() => _FullScreenMediaState();
}

class _FullScreenMediaState extends State<FullScreenMedia> {
  final AudioPlayer _player = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(seconds: 30);
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();

    // Listen for playback progress
    _player.positionStream.listen((pos) {
      setState(() => _currentPosition = pos);
    });
  }

  Future<void> _initPlayer() async {
    if (widget.previewUrl != null && widget.previewUrl!.isNotEmpty) {
      try {
        await _player.setLoopMode(LoopMode.one);
        await _player.setUrl(widget.previewUrl!);
        _totalDuration = _player.duration ?? const Duration(seconds: 30);

        if (widget.autoPlay) {
          await _player.play();
        }
      } catch (e) {
        debugPrint('Error initializing audio: $e');
      }
    }
  }

  Future<void> _togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
      setState(() => _isPaused = true);
    } else {
      await _player.play();
      setState(() => _isPaused = false);
    }
  }

  Future<void> _exitFullscreen(BuildContext context) async {
    await _player.stop();
    await _player.dispose();
    Navigator.pop(context);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ✅ Fullscreen Image
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _togglePlayPause,
              onDoubleTap: () => _exitFullscreen(context),
              child: widget.imageBytes != null
                  ? Image.memory(widget.imageBytes!, fit: BoxFit.cover)
                  : (widget.imagePath != null &&
                        widget.imagePath!.startsWith('http'))
                  ? Image.network(widget.imagePath!, fit: BoxFit.cover)
                  : Image.asset(widget.imagePath ?? '', fit: BoxFit.cover),
            ),
          ),

          // ✅ Back Button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => _exitFullscreen(context),
            ),
          ),

          // ✅ Song Info + Scrubber
          if (widget.previewUrl != null)
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.songTitle != null && widget.artistName != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "${widget.songTitle} • ${widget.artistName}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                        ),
                      ),
                    ),
                  Slider(
                    value: _currentPosition.inSeconds.toDouble().clamp(
                      0,
                      _totalDuration.inSeconds.toDouble(),
                    ),
                    min: 0,
                    max: _totalDuration.inSeconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.white54,
                    onChanged: (value) async {
                      final newPos = Duration(seconds: value.toInt());
                      await _player.seek(newPos);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_currentPosition),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        _formatDuration(_totalDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // ✅ Play/Pause Overlay
          if (_isPaused)
            const Center(
              child: Icon(Icons.play_arrow, size: 100, color: Colors.white70),
            ),
        ],
      ),
    );
  }
}
