import 'package:flutter/material.dart';
import 'package:bookverse_mobile/user_profile/screens/readed_books.dart';
import 'package:bookverse_mobile/user_profile/screens/favorite_books.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookverse_mobile/auth/screens/login.dart';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final List<Functionality> functions = [
    Functionality("Readed Books", Image.asset(
      'assets/images/bookLogo.png',
      width: 30,
      height: 30,
    )),
    Functionality("Favorites Books", Icons.book),
    Functionality("Edit Profile", Icons.edit),
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
      body: Builder(
        builder: (context) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          return SingleChildScrollView(
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
                                userProvider.image.isNotEmpty
                                ? userProvider.image
                                : 'assets/images/defaultProfile.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userProvider.username}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Display the user's bio
                                  Text(
                                    "${userProvider.bio}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20), // Add space between the first container and the function

                      // Spread (...) operator to include the lists in the Column widget
                      ...functions.map((function) => FunctionCard(function)).toList(),

                      const Divider(),

                      // Bottom functionalities
                      ...bottomFunctions.map((function) => FunctionCard(function)).toList(),
                    ],
                  ),
                ),
              );
        },
      ),
    );
  }
}


class FunctionCard extends StatelessWidget {
  final Functionality function;

  const FunctionCard(this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Colors.grey[800], // Background color of button/card
      child: InkWell(
        onTap: () async{
          if (function.name == "Readed Books") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReadedBooks()),
            );
          } else if (function.name == "Favorites Books") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteBooks()),
            );
          } else if (function.name == "Settings") {
            // Navigate to Settings page
          } else if (function.name == "Logout") {
            final response = await request.logout(
            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                "http://127.0.0.1:8000/logout_flutter/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
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