import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'song_details_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Map<String, String>> posts = [
    {
      'image': 'assets/images/homepage/Wonderland.jpg',
      'title': 'Wonderland (Taylor’s Version)',
      'artist': 'Taylor Swift',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c1/31/18/c131181b-ca3e-d945-16b2-48ea6bcd64d4/23UM1IM11868.rgb.jpg/600x600bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/album/wonderland-taylors-version/1708308989?i=1708309195&uo=4',
    },
    {
      'image': 'assets/images/homepage/ThatsSoTrue.jpg',
      'title': "That's so true",
      'artist': 'Gracie Abrams',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/26/78/81/26788143-5e5f-0813-2480-ecf4280ef221/24UM1IM07082.rgb.jpg/600x600bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/song/thats-so-true/1773474483',
    },
    {
      'image': 'assets/images/homepage/MidnightSerenade.jpg',
      'title': 'About You',
      'artist': 'The 1975',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/ec/35/84/ec35841a-f7d1-71dd-fcb8-38e8f6c62d83/196922101519_Cover.jpg/600x600bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/song/about-you/1632479847',
    },
    {
      'image': 'assets/images/homepage/Reflections.jpg',
      'title': 'Reflections',
      'artist': 'The Neighbourhood',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/fc/d0/89/fcd0899c-2236-a726-9ce2-ebb110e2204d/886447414545.jpg/600x600bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/song/reflections/1440532773',
    },
    {
      'image': 'assets/images/homepage/Dreamlight.jpg',
      'title': 'Cinnamon Girl',
      'artist': 'Lana Del Rey',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c6/5f/b9/c65fb9eb-da2f-89a9-b640-2fff1fc3a660/19UMGIM61350.rgb.jpg/600x600bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/song/cinnamon-girl/1474669074',
    },
    {
      'image': 'assets/images/homepage/AuraEchoes.jpg',
      'title': 'Mess It Up',
      'artist': 'Gracie Abrams',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/ba/40/b5/ba40b591-7c74-1115-e010-0c9a051c5164/21UMGIM35406.rgb.jpg/632x632bb.webp',
      'appleMusicUrl': 'https://music.apple.com/us/album/mess-it-up-single/1565850759',
    },
  ];

  Future<Map<String, String>?> fetchTrackMetadata(String title, String artist) async {
    final query = Uri.encodeComponent("$title $artist");
    final url = Uri.parse("https://itunes.apple.com/search?term=$query&entity=musicTrack&limit=1");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final track = data['results'][0];
          return {
            'previewUrl': track['previewUrl'] ?? '',
            'trackViewUrl': track['trackViewUrl'] ?? '',
          };
        }
      }
    } catch (e) {
      print("Error fetching track metadata: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'For you',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.wb_sunny : Icons.nights_stay,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 14,
            runSpacing: 24,
            children: posts.map((post) {
              return GestureDetector(
                onTap: () async {
                  final metadata = await fetchTrackMetadata(post['title']!, post['artist']!);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongDetailsPage(
                        title: post['title']!,
                        artist: post['artist']!,
                        image: post['image']!,
                        cover: post['cover']!,
                        previewUrl: metadata?['previewUrl'], // ✅ dynamically fetched
                        trackViewUrl: metadata?['trackViewUrl'] ?? post['appleMusicUrl'],
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
                        style: theme.textTheme.bodyLarge?.copyWith(
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
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
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
