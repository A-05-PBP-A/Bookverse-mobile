import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/screens/borrow.dart';
import 'package:bookverse_mobile/borrow_return/widgets/searchbar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
import 'package:bookverse_mobile/borrow_return/models/borrowing.dart';
import 'package:bookverse_mobile/borrow_return/widgets/borrowing_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class BorrowingPage extends StatefulWidget {
  const BorrowingPage({Key? key}) : super(key: key);

  @override
  BorrowingPageState createState() => BorrowingPageState();
}

class BorrowingPageState extends State<BorrowingPage> {
  //String baseUrl = "http://127.0.0.1:8000";
  String baseUrl = "http://10.0.2.2:8000";
  void handleReturn(Borrowing borrowing) {
    // Perform the return operation here
    // After the operation is successful, update the state
    setState(() {
      // Update the state here
    });
  }

  Future<List<Borrowing>> fetchBorrowing(request) async {
    //'https://10.0.0.2/borrowing-data/'
    var data = await request.get('http://127.0.0.1:8000/borrowing-data/');
    // var data = await request.get('http://127.0.0.1:8000/borrowing-data/');
    // melakukan konversi data json menjadi object Borrowing
    List<Borrowing> listBorrowing = [];
    for (var d in data) {
      if (d != null) {
        listBorrowing.add(Borrowing.fromJson(d));
      }
    }
    return listBorrowing;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
            title: const Text('My Borrowing(s)'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookFormPage()),
                      );
                    },
                  )),
            ]),
        body: FutureBuilder(
            future: fetchBorrowing(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "You haven't borrowed any book yet",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 18.0,
                        width: 18.0,
                      ),
                      const MySearchBar(),
                      const SizedBox(
                        height: 25.0,
                        width: 18.0,
                      ),
                      Expanded(
                          child: GridView.builder(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 181 / 410,
                          crossAxisCount: 2, // Number of cards per row
                          crossAxisSpacing:
                              8.0, // Spacing between cards horizontally
                          mainAxisSpacing: 8.0,
                        ), // Spacing between cards vertically
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return BorrowingCard(
                            borrowed: snapshot.data![index],
                            onReturn: () {
                              handleReturn(snapshot.data![index]);
                            },
                          );
                        },
                      ))
                    ],
                  );
                }
              }
            }));
  }
}

String replaceUrl(String originalUrl) {
  return originalUrl.replaceFirst(
      'http://images.amazon.com/', 'https://m.media-amazon.com/');
}
