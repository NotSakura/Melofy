import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'moodboards/moodboard_template.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';
import '../models/track_info.dart'; // Shared TrackInfo model

Map<String, List<TrackInfo>> convertToTrackInfoMap(
  Map<String, List<String>> rawMap,
  Map<String, TrackInfo> allTrackDetails,
) {
  final Map<String, List<TrackInfo>> converted = {};
  rawMap.forEach((key, listOfImagePaths) {
    converted[key] = listOfImagePaths
        .map((imagePath) => allTrackDetails[imagePath])
        .whereType<TrackInfo>() // skips any nulls safely
        .toList();
  });
  return converted;
}

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

  final Map<String, TrackInfo> allTrackDetails = {
    'assets/images/explore_page/tracks/song1.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song1.jpg',
      name: 'Hey Ya!',
      artist: 'OutKast',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/a3/35/54/a33554b6-4122-cdfd-29e8-d17897280263/dj.yiwizfgg.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/hey-ya/1032178894?i=1032178989',
    ),
    'assets/images/explore_page/tracks/song2.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song2.jpg',
      name: 'Rolling in the Deep',
      artist: 'Adele',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/d8/e3/f9/d8e3f9ea-d6fe-9a1b-9f13-109983d3062e/191404113868.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/rolling-in-the-deep/1544491232?i=1544491233',
    ),
    'assets/images/explore_page/tracks/song3.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song3.jpg',
      name: 'Umbrella',
      artist: 'Rihanna',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/2b/c0/81/2bc081c8-25f0-ba43-d451-587a54613778/16UMGIM59202.rgb.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/umbrella-feat-jay-z/1441154435?i=1441154437',
    ),
    'assets/images/explore_page/tracks/song4.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song4.jpg',
      name: 'Clocks',
      artist: 'Coldplay',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video112/v4/40/66/14/406614b7-4680-ad21-41d3-dca2e58bf359/Jobb1a3f2f6-88a7-46ae-8533-055f698aa7f0-135335131-PreviewImage_preview_image_nonvideo_sdr-Time1660754380172.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/clocks/1122775993?i=1122776156',
    ),
    'assets/images/explore_page/tracks/song5.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song5.jpg',
      name: 'Hips Don’t Lie',
      artist: 'Shakira',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video211/v4/7c/a3/29/7ca329b9-5861-7671-994c-25aa22f42654/Job4da8d974-7cd7-4dd3-8375-9ed49c5ae785-193557288-PreviewImage_Preview_Image_Intermediate_nonvideo_sdr_379171340_2181902493-Time1748454044506.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/hips-dont-lie-feat-wyclef-jean/1817217057?i=1817217063',
    ),
    'assets/images/explore_page/tracks/song6.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song6.jpg',
      name: 'Happy',
      artist: 'Pharrell Williams',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/f4/43/16/f4431607-15c4-883c-3fbe-dd6abbbe03e7/886444516877.jpg/592x592bf.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/happy-from-despicable-me-2/863835302?i=863835363',
    ),
    'assets/images/explore_page/tracks/song7.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song7.jpg',
      name: 'Bad Romance',
      artist: 'Lady Gaga',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/1b/98/88/1b9888da-6a1f-bff0-ec03-518f445019f6/19UMGIM73435.rgb.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/bad-romance/1476727669?i=1476727670',
    ),
    'assets/images/explore_page/tracks/song8.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song8.jpg',
      name: 'Get Lucky',
      artist: 'Daft Punk',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/e8/43/5f/e8435ffa-b6b9-b171-40ab-4ff3959ab661/886443919266.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/get-lucky/617154241?i=617154366',
    ),
    'assets/images/explore_page/tracks/song9.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song9.jpg',
      name: 'Shape of You',
      artist: 'Ed Sheeran',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video126/v4/88/70/e9/8870e976-1d4e-0ed6-d5a1-02cc6183558c/Job3b60a129-8c0d-4179-b6ec-903b71bf1b18-129193526-PreviewImage_preview_image_nonvideo_sdr-Time1645812297481.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/shape-of-you/1193701079?i=1193701392',
    ),
    'assets/images/explore_page/tracks/song10.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song10.jpg',
      name: 'Firework',
      artist: 'Katy Perry',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video126/v4/f5/44/ce/f544ceea-962c-5d7e-18c2-335cf1fa3e2f/Job01cd1e4d-a5ad-406d-9f56-e6c71bf23786-151190437-PreviewImage_preview_image_nonvideo_sdr-Time1686241868837.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/firework/716192216?i=716192625',
    ),
    'assets/images/explore_page/tracks/song11.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song11.jpg',
      name: 'Lose Yourself',
      artist: 'Eminem',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video122/v4/2c/1f/89/2c1f8925-f31a-7cdc-c903-4148cf58bb56/Jobd7444671-991d-4af0-ab9a-33c409ffc3a5-138354641-PreviewImage_preview_image_nonvideo_sdr-Time1667248714277.png/592x592bf.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/lose-yourself/1440903339?i=1440903439',
    ),
    'assets/images/explore_page/tracks/song12.png': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song12.png',
      name: 'Uptown Funk',
      artist: 'Mark Ronson ft. Bruno Mars',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video221/v4/55/59/ac/5559ac86-dd27-5583-2d71-d0b1f0437257/Jobbb48e967-a754-4b80-9f95-f07690529893-192300999-PreviewImage_Preview_Image_Intermediate_nonvideo_sdr_376600889_2156884749-Time1747060006000.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/uptown-funk-feat-bruno-mars/943946661?i=943946671',
    ),
    'assets/images/explore_page/tracks/song13.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song13.jpg',
      name: 'Rolling in the Deep',
      artist: 'Adele',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/d8/e3/f9/d8e3f9ea-d6fe-9a1b-9f13-109983d3062e/191404113868.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/rolling-in-the-deep/1544491232?i=1544491233',
    ),
    'assets/images/explore_page/tracks/song14.png': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song14.png',
      name: 'Can’t Stop the Feeling!',
      artist: 'Justin Timberlake',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/68/19/43/68194388-efa7-3afe-8a15-a4c3eebef1f6/886445915211.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/cant-stop-the-feeling/1154238159?i=1154239184',
    ),
    'assets/images/explore_page/tracks/song15.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song15.jpg',
      name: 'Royals',
      artist: 'Lorde',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/e1/d3/23/e1d323d6-a7e4-6d5e-e6f6-5105c76db133/13UAAIM68691.rgb.jpg/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/royals/1440818584?i=1440818664',
    ),
    'assets/images/explore_page/tracks/song16.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song16.jpg',
      name: 'Seven Nation Army',
      artist: 'The White Stripes',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video115/v4/cb/f3/c3/cbf3c3fd-449c-65df-7420-b6a98dc0922b/Jobedefc1a2-377d-4977-a674-e287ac379593-116421761-PreviewImage_preview_image_nonvideo_sdr-Time1625154212215.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/seven-nation-army/1533513536?i=1533513537',
    ),
    'assets/images/explore_page/tracks/song17.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song17.jpg',
      name: 'Someone Like You',
      artist: 'Adele',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/d8/e3/f9/d8e3f9ea-d6fe-9a1b-9f13-109983d3062e/191404113868.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/someone-like-you/1544491232?i=1544491998',
    ),
    'assets/images/explore_page/tracks/song18.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song18.jpg',
      name: 'Toxic',
      artist: 'Britney Spears',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video221/v4/79/00/0f/79000f79-2bb4-bea7-faf7-b57710178576/Job0a404bee-ba17-410f-80f3-5b8bdf31a675-191561883-PreviewImage_Preview_Image_Intermediate_nonvideo_sdr_375099000_2142813707-Time1746125394652.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/toxic/251947909?i=251948354',
    ),
    'assets/images/explore_page/tracks/song19.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song19.jpg',
      name: 'Boulevard of Broken Dreams',
      artist: 'Green Day',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video122/v4/d0/4c/53/d04c532e-ca0a-0ace-0847-62003931424b/Job75e8880b-4409-4b22-872b-4a2ab7bd1669-138891124-PreviewImage_preview_image_nonvideo_sdr-Time1668123397619.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/boulevard-of-broken-dreams/1161539183?i=1161539476',
    ),
    'assets/images/explore_page/tracks/song20.jpg': TrackInfo(
      imagePath: 'assets/images/explore_page/tracks/song20.jpg',
      name: 'Chandelier',
      artist: 'Sia',
      cover:
          'https://is1-ssl.mzstatic.com/image/thumb/Video211/v4/f9/00/58/f9005871-6e48-9d40-7e41-1b256faab4a9/Job0a2bdfb8-c31a-4d0b-b331-fcc5229a75cb-171214554-PreviewImage_Preview_Image_Intermediate_nonvideo_sdr_333397019_1823968674-Time1720030574648.png/592x592bb.webp',
      appleMusicUrl:
          'https://music.apple.com/us/album/chandelier/882945378?i=882945383',
    ),
  };

  late final Map<String, List<TrackInfo>> moodboardTracks;

  @override
  void initState() {
    super.initState();
    final random = Random();
    moodboardTracks = {
      for (var path in [...moodboardImagePaths, ...collectionsImagePaths])
        path: (allTrackImagePaths.toList()..shuffle(random))
            .take(5)
            .map((imgPath) => allTrackDetails[imgPath]!)
            .toList(),
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

            // Add the search bar here
            TextField(
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
                            imagePaths: moodboardTracks[imagePath]!
                                .map((track) => track.imagePath)
                                .toList(),
                            onTrackTap: (path) {},
                            tracksInfo: moodboardTracks[imagePath]!,
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
                            imagePaths: moodboardTracks[imagePath]!
                                .map((track) => track.imagePath)
                                .toList(),
                            onTrackTap: (path) {},
                            tracksInfo: moodboardTracks[imagePath]!,
                          ),
                        ),
                      );
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double size = constraints.maxWidth;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: size,
                              height: size, // square
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
                        );
                      },
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
