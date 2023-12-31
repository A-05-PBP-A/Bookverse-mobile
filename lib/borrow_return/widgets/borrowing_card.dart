import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/models/borrowing.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';
import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';

class BorrowingCard extends StatelessWidget {
  final Borrowing borrowed;
  final Function onReturn;
  const BorrowingCard(
      {super.key, required this.borrowed, required this.onReturn});
  //final String baseUrl = "http://127.0.0.1:8000";
  final String baseUrl = "https://bookverse-a05-tk.pbp.cs.ui.ac.id";
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final DateTime returnDate = borrowed.fields.returnDate;
    final DateFormat df = DateFormat('yyyy-MM-dd');
    final String formattedDateTime = df.format(returnDate);
    final userProvider =
        Provider.of<UserProvider>(context, listen: false); //data user login

    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookPage(id: borrowed.fields.book),
            ),
          );
        },
        child: Card(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment
                  //     .stretch, // Memastikan bahwa child Column memenuhi lebar card
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    ClipRRect(
                        child: AspectRatio(
                            aspectRatio: 210 / 320,
                            child: Image.network(
                                replaceUrl(borrowed.fields.imageUrlL),
                                fit: BoxFit.fitHeight))),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          borrowed.fields.bookTitle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 1.0, bottom: 3.0),
                        child: Text(
                          style: const TextStyle(fontSize: 14),
                          "Due date: $formattedDateTime",
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 5.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Return Book'),
                                  content: const SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Are you sure you want to return this book?')
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          int borrowingId = borrowed.pk;
                                          final response = await request.postJson(
                                              'https://bookverse-a05-tk.pbp.cs.ui.ac.id/return-flutter/${userProvider.username}/',
                                              jsonEncode(<String, String>{
                                                'id': borrowingId.toString(),
                                              }));
                                          if (response['status'] == 'success') {
                                            onReturn();
                                          }
                                        }),
                                  ],
                                );
                              }),
                          child: const Padding(
                            padding: EdgeInsets.all(0.5),
                            child: Text('Return',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ),
                        ))
                  ],
                ))));
  }
}

String replaceUrl(String originalUrl) {
  return originalUrl.replaceFirst(
      'http://images.amazon.com/', 'https://m.media-amazon.com/');
}
