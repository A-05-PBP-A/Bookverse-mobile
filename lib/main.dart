import 'package:flutter/material.dart';<<<<<<< userProfile
import 'package:bookverse_mobile/user_profile/screens/menu.dart';=======
import 'package:bookverse_mobile/bookList/screens/landing_page.dart';>>>>>>> dev

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookverse',
        scaffoldBackgroundColor: Color.fromARGB(255, 222, 222, 255),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 1, 100)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
