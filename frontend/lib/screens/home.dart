import 'package:flutter/material.dart';
import 'song_details_page.dart';
import 'package:frontend/screens/create_moodboard_screen.dart';
import 'package:frontend/screens/explore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> posts = [
    {
      'image': 'lib/assets/images/Wonderland.jpg',
      'title': 'Wonderland (Taylor’s Version)',
      'artist': 'Taylor Swift',
      'cover': 'lib/assets/images/Wonderland.jpg'
    },
    {
      'image': 'lib/assets/images/ThatsSoTrue.jpg',
      'title': "That's so true",
      'artist': 'Gracie Abrams',
      'cover': 'lib/assets/images/ThatsSoTrue.jpg'
    },
    {
      'image': 'lib/assets/images/MidnightSerenade.jpg',
      'title': 'Midnight Serenade',
      'artist': 'Luna Harmony',
      'cover': 'lib/assets/images/MidnightSerenade.jpg'
    },
    {
      'image': 'lib/assets/images/Reflections.jpg',
      'title': 'Reflections',
      'artist': 'The Neighbourhood',
      'cover': 'lib/assets/images/Reflections.jpg'
    },
    {
      'image': 'lib/assets/images/Dreamlight.jpg',
      'title': 'Dreamlight',
      'artist': 'Various Artists',
      'cover': 'lib/assets/images/Dreamlight.jpg'
    },
    {
      'image': 'lib/assets/images/AuraEchoes.jpg',
      'title': 'Aura Echoes',
      'artist': 'Echo Bloom',
      'cover': 'lib/assets/images/AuraEchoes.jpg'
    },
  ];

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExplorePage()),
        );
        break;
      case 2:
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0xFF2B2B2B),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create a new…',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ModalOption(
                        icon: Icons.post_add,
                        label: 'Media Post',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/select-media');
                        },
                      ),
                      _ModalOption(
                        icon: Icons.grid_view,
                        label: 'Moodboard',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateMoodboardPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'For you',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            children: posts.map((post) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongDetailsPage(
                        title: post['title']!,
                        artist: post['artist']!,
                        coverImage: post['cover']!,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    post['image']!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 20,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

class _ModalOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ModalOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 184, 117, 219),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(icon, size: 28, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}