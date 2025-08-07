import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // ✅ Add this
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'screens/home.dart';
import 'screens/select_media_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ This uses native config files
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
            routes: {
              '/select-media': (context) => const SelectMediaScreen(),
            },
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
