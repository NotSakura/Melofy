import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/select_media_screen.dart';

void main() => runApp(const MelofyApp());

class MelofyApp extends StatelessWidget {
  const MelofyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/select-media': (context) => const SelectMediaScreen(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

        