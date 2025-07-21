import 'package:flutter/material.dart';

class TrendingMoodboard1 extends StatelessWidget {
  const TrendingMoodboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending Moodboard 1')),
      body: const Center(
        child: Text(
          'Welcome to Trending Moodboard 1!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
