import 'package:flutter/material.dart';

class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {
  bool _isPhotoTab = true;

  // ✅ Hardcoded demo photos and videos
  final List<String> _demoPhotos = [
    'https://i.imgur.com/fdVZVYZ.png',
    'https://i.imgur.com/UuUOQoB.png',
    'https://i.imgur.com/J0jK6cK.png',
    'https://i.imgur.com/TvEQZmT.png',
    'https://i.imgur.com/tlY9fgQ.png',
    'https://i.imgur.com/fdVZVYZ.png',
    'https://i.imgur.com/UuUOQoB.png',
    'https://i.imgur.com/J0jK6cK.png',
  ];

  final List<String> _demoVideos = [
    'https://i.imgur.com/tlY9fgQ.png',
    'https://i.imgur.com/fdVZVYZ.png',
    'https://i.imgur.com/UuUOQoB.png',
    'https://i.imgur.com/J0jK6cK.png',
    'https://i.imgur.com/TvEQZmT.png',
    'https://i.imgur.com/tlY9fgQ.png',
    'https://i.imgur.com/fdVZVYZ.png',
    'https://i.imgur.com/UuUOQoB.png',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Media'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // ✅ Tabs for Photos / Videos
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tabButton("Photos", _isPhotoTab, () {
                setState(() => _isPhotoTab = true);
              }),
              const SizedBox(width: 10),
              _tabButton("Videos", !_isPhotoTab, () {
                setState(() => _isPhotoTab = false);
              }),
            ],
          ),

          const SizedBox(height: 10),

          // ✅ Media Grid (3x3)
          Expanded(child: _buildSimulatorGrid()),

          // ✅ Confirm Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                print("Simulator confirm: Selected ${_isPhotoTab ? 'photos' : 'videos'}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 182, 138, 209),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text(
                "Confirm Selection",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Grid showing demo photos or demo videos (3x3)
  Widget _buildSimulatorGrid() {
    final demoList = _isPhotoTab ? _demoPhotos : _demoVideos;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // ✅ 3 columns
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: demoList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => print("Tapped on ${_isPhotoTab ? 'photo' : 'video'} $index"),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(demoList[index], fit: BoxFit.cover),
              ),
              if (!_isPhotoTab) // ✅ Play icon overlay for videos
                const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(Icons.play_circle_fill, color: Colors.white, size: 24),
                ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ Tab button UI
  Widget _tabButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.purple[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
