import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(const MelofyApp());

class MelofyApp extends StatelessWidget {
  const MelofyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

        