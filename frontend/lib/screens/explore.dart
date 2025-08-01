// explore.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'moodboards/moodboard_template.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchText = '';

  final List<String> moodboardImagePaths = [
    'assets/images/explore_page/moodboard1.jpg',
    'assets/images/explore_page/moodboard2.jpg',
    'assets/images/explore_page/moodboard3.png',
    'assets/images/explore_page/moodboard4.jpg',
    'assets/images/explore_page/moodboard5.jpg',
  ];

  final Map<String, String> moodboardTitles = {
    'assets/images/explore_page/moodboard1.jpg': 'Sunset Vibes',
    'assets/images/explore_page/moodboard2.jpg': 'Late Night Drive',
    'assets/images/explore_page/moodboard3.png': 'Indie Spark',
    'assets/images/explore_page/moodboard4.jpg': 'Lo-fi Lounge',
    'assets/images/explore_page/moodboard5.jpg': 'Dreamscape',
  };

  final Map<String, String> moodboardDescriptions = {
    'assets/images/explore_page/moodboard1.jpg': 'Warm tones and mellow tunes.',
    'assets/images/explore_page/moodboard2.jpg':
        'Moody beats for quiet drives.',
    'assets/images/explore_page/moodboard3.png': 'Fresh finds and indie gems.',
    'assets/images/explore_page/moodboard4.jpg': 'Relax and unwind.',
    'assets/images/explore_page/moodboard5.jpg': 'Echoes of the surreal.',
  };

  final List<String> collectionsImagePaths = [
    'assets/images/explore_page/collection1.jpg',
    'assets/images/explore_page/collection2.jpg',
    'assets/images/explore_page/collection3.jpg',
    'assets/images/explore_page/collection4.jpg',
    'assets/images/explore_page/collection5.jpg',
    'assets/images/explore_page/collection6.jpg',
    'assets/images/explore_page/collection7.jpg',
    'assets/images/explore_page/collection8.jpg',
  ];

  final Map<String, String> collectionTitles = {
    'assets/images/explore_page/collection1.jpg': 'Calming',
    'assets/images/explore_page/collection2.jpg': 'Rock and Roll',
    'assets/images/explore_page/collection3.jpg': 'Broadway',
    'assets/images/explore_page/collection4.jpg': 'Country',
    'assets/images/explore_page/collection5.jpg': 'Jazz',
    'assets/images/explore_page/collection6.jpg': 'Children\'s Music',
    'assets/images/explore_page/collection7.jpg': 'Disco',
    'assets/images/explore_page/collection8.jpg': 'Acoustic Escape',
  };

  final Map<String, String> collectionDescriptions = {
    'assets/images/explore_page/collection1.jpg':
        'Soft, soothing sounds to relax your mind.',
    'assets/images/explore_page/collection2.jpg':
        'High-energy classics and new rock anthems.',
    'assets/images/explore_page/collection3.jpg':
        'Show-stopping tunes from the theater world.',
    'assets/images/explore_page/collection4.jpg':
        'Heartfelt stories and melodies from the countryside.',
    'assets/images/explore_page/collection5.jpg':
        'Smooth and soulful jazz rhythms.',
    'assets/images/explore_page/collection6.jpg':
        'Fun and playful songs for kids of all ages.',
    'assets/images/explore_page/collection7.jpg':
        'Groovy beats to get you dancing all night.',
    'assets/images/explore_page/collection8.jpg':
        'Raw and unplugged acoustic performances.',
  };

  final List<String> allTrackImagePaths = [
    'assets/images/explore_page/tracks/song1.jpg',
    'assets/images/explore_page/tracks/song2.jpg',
    'assets/images/explore_page/tracks/song3.jpg',
    'assets/images/explore_page/tracks/song4.jpg',
    'assets/images/explore_page/tracks/song5.jpg',
    'assets/images/explore_page/tracks/song6.jpg',
    'assets/images/explore_page/tracks/song7.jpg',
    'assets/images/explore_page/tracks/song8.jpg',
    'assets/images/explore_page/tracks/song9.jpg',
    'assets/images/explore_page/tracks/song10.jpg',
    'assets/images/explore_page/tracks/song11.jpg',
    'assets/images/explore_page/tracks/song12.png',
    'assets/images/explore_page/tracks/song13.jpg',
    'assets/images/explore_page/tracks/song14.png',
    'assets/images/explore_page/tracks/song15.jpg',
    'assets/images/explore_page/tracks/song16.jpg',
    'assets/images/explore_page/tracks/song17.jpg',
    'assets/images/explore_page/tracks/song18.jpg',
    'assets/images/explore_page/tracks/song19.jpg',
    'assets/images/explore_page/tracks/song20.jpg',
  ];

  late final Map<String, List<String>> moodboardTracks;

  @override
  void initState() {
    super.initState();
    final random = Random();
    moodboardTracks = {
      for (var path in [...moodboardImagePaths, ...collectionsImagePaths])
        path: (allTrackImagePaths.toList()..shuffle(random)).take(5).toList(),
    };
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
          "Explore",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: 'Search artists, songs or themes',
                hintStyle: TextStyle(color: theme.hintColor),
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                fillColor: isDark ? theme.cardColor : Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              searchText.isEmpty
                  ? 'Trending Moodboards'
                  : 'Searching for: "$searchText"',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: moodboardImagePaths.map((imagePath) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoodboardPage(
                            title: moodboardTitles[imagePath] ?? 'Moodboard',
                            description: moodboardDescriptions[imagePath] ?? '',
                            tags: ['trending', 'mood', 'summer'],
                            imagePaths: moodboardTracks[imagePath]!,
                            onTrackTap: (path) {},
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          moodboardTitles[imagePath] ?? '',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Recommended Collections',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: collectionsImagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = collectionsImagePaths[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoodboardPage(
                            title: collectionTitles[imagePath] ?? 'Collection',
                            description:
                                collectionDescriptions[imagePath] ??
                                'A curated mix of moods and sounds.',
                            tags: ['curated', 'collection', 'vibes'],
                            imagePaths: moodboardTracks[imagePath]!,
                            onTrackTap: (path) {},
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // <- this centers children horizontally
                      children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          collectionTitles[imagePath] ?? '',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
