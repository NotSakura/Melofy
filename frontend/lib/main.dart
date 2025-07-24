import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // import your ThemeProvider
import 'screens/home.dart';
import 'screens/select_media_screen.dart';

void main() {
  runApp(const MelofyApp());
}

class MelofyApp extends StatelessWidget {
  const MelofyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
            routes: {'/select-media': (context) => const SelectMediaScreen()},
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
