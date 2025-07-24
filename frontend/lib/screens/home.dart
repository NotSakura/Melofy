import 'package:flutter/material.dart';
import 'song_details_page.dart';

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
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final post = posts[index];
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
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {},
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

