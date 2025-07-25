import 'package:flutter/material.dart';
import 'moodboards/trending_moodboard1.dart';

const String basePath = 'assets/images/explorePage/';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moodboard"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search artists, songs or themes',
                prefixIcon: const Icon(Icons.search),
                fillColor: Colors.white,
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Horizontal scrollable row of image buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrendingMoodboard1(),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(moodboardImagePaths[index]),
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
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Recommended Collections',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Expanded grid with 2 columns and vertical scroll
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // two columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1, // square items
                ),
                itemCount: 8, // 4 rows * 2 columns
                itemBuilder: (context, index) {
                  final imageIndex =
                      index %
                      collectionsImagePaths.length; // repeat images if needed
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrendingMoodboard1(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(collectionsImagePaths[imageIndex]),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
