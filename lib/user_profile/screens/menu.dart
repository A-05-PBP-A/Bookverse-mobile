import 'package:flutter/material.dart';
import 'package:bookverse_mobile/user_profile/screens/readed_books.dart';
import 'package:bookverse_mobile/user_profile/screens/favorite_books.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
  final List<Functionality> functions = [
    Functionality("Readed Books", Image.asset(
      'assets/images/bookLogo.png',
      width: 30,
      height: 30,
    )),
    Functionality("Favorites Books", Icons.book),
    Functionality("Settings", Icons.settings),
  ];

  final List<Functionality> bottomFunctions = [
    Functionality("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookverse',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Bookverse',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.grey[800],
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/defaultProfile.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white, // Change label text color to white
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Add space between the first container and the function

              //spread (...) operator to include the lists in the Column widget
              ...functions.map((function) => FunctionCard(function)).toList(),

              const Divider(),

              // Bottom functionalities
              ...bottomFunctions.map((function) => FunctionCard(function)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}


class FunctionCard extends StatelessWidget {
  final Functionality function;

  const FunctionCard(this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[800], // Background color of button/card
      child: InkWell(
        onTap: () {
          if (function.name == "Readed Books") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadedBooks()),
            );
          } else if (function.name == "Favorites Books") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoriteBooks()),
            );
          } else if (function.name == "Settings") {
            // Navigate to Settings page
          } else if (function.name == "Logout") {
            // Navigate to Logout page
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (function.icon is Image)
                function.icon
              else
                Icon(
                  function.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                function.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Functionality {
  final String name;
  final dynamic icon; //Pakai dynamic agar bisa image atau icon bawaan

  Functionality(this.name, this.icon);
}


