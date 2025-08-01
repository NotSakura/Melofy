import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import 'song_details_page.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> posts = [
    {
      'image': 'assets/images/homepage/Wonderland.jpg',
      'title': 'Wonderland (Taylor’s Version)',
      'artist': 'Taylor Swift',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/c1/31/18/c131181b-ca3e-d945-16b2-48ea6bcd64d4/23UM1IM11868.rgb.jpg/600x600bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/7a/17/7a/7a177a82-bfcf-3aa6-fef5-3209f0a44e66/mzaf_11239821253164246026.plus.aac.p.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/album/wonderland-taylors-version/1708308989?i=1708309195&uo=4',
    },
    {
      'image': 'assets/images/homepage/ThatsSoTrue.jpg',
      'title': "That's so true",
      'artist': 'Gracie Abrams',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/26/78/81/26788143-5e5f-0813-2480-ecf4280ef221/24UM1IM07082.rgb.jpg/600x600bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/56/c3/f3/56c3f3c0-5408-f6dd-0069-d902c20e438f/mzaf_5615583560189191751.plus.aac.ep.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/song/thats-so-true/1773474483',
    },
    {
      'image': 'assets/images/homepage/MidnightSerenade.jpg',
      'title': 'About You',
      'artist': 'The 1975',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/ec/35/84/ec35841a-f7d1-71dd-fcb8-38e8f6c62d83/196922101519_Cover.jpg/600x600bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/48/1e/97/481e974c-9493-ed4f-b84b-0f5796f22aef/mzaf_14511434660864925569.plus.aac.ep.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/song/about-you/1632479847',
    },
    {
      'image': 'assets/images/homepage/Reflections.jpg',
      'title': 'Reflections',
      'artist': 'The Neighbourhood',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/fc/d0/89/fcd0899c-2236-a726-9ce2-ebb110e2204d/886447414545.jpg/600x600bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/d4/51/cd/d451cd0c-c804-5b52-d125-ad74ca84dac9/mzaf_15426298693603867753.plus.aac.ep.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/song/reflections/1440532773',
    },
    {
      'image': 'assets/images/homepage/Dreamlight.jpg',
      'title': 'Cinnamon Girl',
      'artist': 'Lana Del Rey',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/c6/5f/b9/c65fb9eb-da2f-89a9-b640-2fff1fc3a660/19UMGIM61350.rgb.jpg/600x600bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/86/ab/c9/86abc949-717d-b99e-ccc1-2d06a10e01d6/mzaf_4867373271051538736.plus.aac.ep.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/song/cinnamon-girl/1474669074',
    },
    {
      'image': 'assets/images/homepage/AuraEchoes.jpg',
      'title': 'Mess It Up',
      'artist': 'Gracie Abrams',
      'cover': 'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/ba/40/b5/ba40b591-7c74-1115-e010-0c9a051c5164/21UMGIM35406.rgb.jpg/632x632bb.webp',
      'preview': 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/98/a5/de/98a5deef-c892-0ad4-8e50-d7418340b362/mzaf_12817004681891408622.plus.aac.ep.m4a',
      'appleMusicUrl': 'https://music.apple.com/us/album/mess-it-up-single/1565850759',
    },
  ];

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongDetailsPage(
                        title: post['title']!,
                        artist: post['artist']!,
                        image: post['image']!,
                        cover: post['cover']!,
                        previewUrl: post['preview'],           // Pass preview URL
                        trackViewUrl: post['appleMusicUrl'],  // Pass Apple Music URL
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
