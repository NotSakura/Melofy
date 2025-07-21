import 'package:flutter/material.dart';

class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {
  bool isPhoto = true;

  final List<String> dummyImages = [
    'https://i.imgur.com/fdVZVYZ.png',
    'https://i.imgur.com/UuUOQoB.png',
    'https://i.imgur.com/J0jK6cK.png',
    'https://i.imgur.com/TvEQZmT.png',
    'https://i.imgur.com/tlY9fgQ.png',
    'https://i.imgur.com/yBJWvmO.png',
  ];

  final List<Map<String, String>> dummyVideos = [
    {'thumbnail': 'https://i.imgur.com/fdVZVYZ.png', 'duration': '21 sec'},
    {'thumbnail': 'https://i.imgur.com/UuUOQoB.png', 'duration': '1:02 min'},
    {'thumbnail': 'https://i.imgur.com/J0jK6cK.png', 'duration': '57 sec'},
    {'thumbnail': 'https://i.imgur.com/TvEQZmT.png', 'duration': '34 sec'},
    {'thumbnail': 'https://i.imgur.com/tlY9fgQ.png', 'duration': '1:02 min'},
    {'thumbnail': 'https://i.imgur.com/yBJWvmO.png', 'duration': '1:32 min'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        backgroundColor: Colors.black,
        title: const Text('Select Media'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _tabBar(),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: isPhoto ? dummyImages.length : dummyVideos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return isPhoto
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(dummyImages[index], fit: BoxFit.cover),
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              dummyVideos[index]['thumbnail']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                dummyVideos[index]['duration']!,
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Confirm Selection'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2E2B28),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _tabButton('Photos', isPhoto),
            _tabButton('Videos', !isPhoto),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!selected) setState(() => isPhoto = label == 'Photos');
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1C1C1C) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}