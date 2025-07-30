import 'package:flutter/material.dart';
import 'package:frontend/widgets/moodboard_card.dart';
import 'package:frontend/screens/explore.dart';
import 'package:frontend/screens/create_moodboard_screen.dart';
import 'song_details_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Map<String, String>> posts = [
    {
      'image': 'assets/images/homepage/Wonderland.jpg',
      'title': 'Wonderland (Taylor’s Version)',
      'artist': 'Taylor Swift',
      'cover': 'assets/images/homepage/Wonderland.jpg',
    },
    {
      'image': 'assets/images/homepage/ThatsSoTrue.jpg',
      'title': "That's so true",
      'artist': 'Gracie Abrams',
      'cover': 'assets/images/homepage/ThatsSoTrue.jpg',
    },
    {
      'image': 'assets/images/homepage/MidnightSerenade.jpg',
      'title': 'Midnight Serenade',
      'artist': 'Luna Harmony',
      'cover': 'assets/images/homepage/MidnightSerenade.jpg',
    },
    {
      'image': 'assets/images/homepage/Reflections.jpg',
      'title': 'Reflections',
      'artist': 'The Neighbourhood',
      'cover': 'assets/images/homepage/Reflections.jpg',
    },
    {
      'image': 'assets/images/homepage/Dreamlight.jpg',
      'title': 'Dreamlight',
      'artist': 'Various Artists',
      'cover': 'assets/images/homepage/Dreamlight.jpg',
    },
    {
      'image': 'assets/images/homepage/AuraEchoes.jpg',
      'title': 'Aura Echoes',
      'artist': 'Echo Bloom',
      'cover': 'assets/images/homepage/AuraEchoes.jpg',
    },
  ];

  /// Handle bottom nav bar taps
  void _onNavTap(int index) {
    if (index == 2) {
      _showCreateModal(context);
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Dynamic screen switching
  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return const ExplorePage();
      default:
        return _buildHomePage();
    }
  }

  /// Build home feed grid
  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 14,
          runSpacing: 24,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      post['image']!,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: MediaQuery.of(context).size.width / 2 - 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: Text(
                      post['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: Text(
                      post['artist']!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Show modal for creating posts or moodboards
  void _showCreateModal(BuildContext context) {
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
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        onTap: _onNavTap,
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
