import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/screens/borrow.dart';
import 'package:bookverse_mobile/user_profile/screens/menu.dart';
import 'package:bookverse_mobile/bookList/screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

        scaffoldBackgroundColor: Color.fromARGB(255, 222, 222, 255),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 1, 100)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
