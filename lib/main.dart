import 'package:bookverse_mobile/welcome.dart';
import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/screens/borrow.dart';
import 'package:bookverse_mobile/user_profile/screens/menu.dart';
import 'package:bookverse_mobile/bookList/screens/landing_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        Provider<CookieRequest>(create: (_) => CookieRequest()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

     Widget buildHome(BuildContext context) {
        final userProvider = Provider.of<UserProvider>(context);
        if (userProvider.isLoggedIn) {
            return const MyHomePage();
        } else {
            return const WelcomePage();
        }
    }

    @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'Bookverse',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                    useMaterial3: true,
                ),
                 home: buildHome(context),
                ),
            );
    }
}

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(),
    const BookFormPage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Borrow Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
