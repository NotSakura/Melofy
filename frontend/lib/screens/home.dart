// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/moodboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> posts = const [
    {
      'image': 'https://i.imgur.com/fdVZVYZ.png',
      'title': 'Wonderland',
      'artist': 'Taylor Swift'
    },
    {
      'image': 'https://i.imgur.com/UuUOQoB.png',
      'title': "That's so true",
      'artist': 'Gracie Abrams'
    },
    {
      'image': 'https://i.imgur.com/J0jK6cK.png',
      'title': 'Midnight Serenade',
      'artist': 'Luna Harmony'
    },
    {
      'image': 'https://i.imgur.com/TvEQZmT.png',
      'title': 'Reflections',
      'artist': 'The Neighbourhood'
    },
    {
      'image': 'https://i.imgur.com/tlY9fgQ.png',
      'title': 'Dreamlight',
      'artist': 'Various Artists'
    },
    {
      'image': 'https://i.imgur.com/yBJWvmO.png',
      'title': 'Aura Echoes',
      'artist': 'Echo Bloom'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return MoodboardCard(
            imageUrl: post['image']!,
            title: post['title']!,
            artist: post['artist']!,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
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