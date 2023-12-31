import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/widgets/dropdown.dart';
import 'package:bookverse_mobile/borrow_return/screens/return_integrate.dart';
import 'package:bookverse_mobile/borrow_return/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookFormPage extends StatefulWidget {
  final String id;
  const BookFormPage({Key? key, this.id = "1"}) : super(key: key);

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  late String currentId = widget.id;

  @override
  void initState() {
    super.initState();
    currentId = widget.id; // Initialize currentBookId in initState
  }

  // String baseUrl = "http://127.0.0.1:8000";
  String baseUrl = "https://bookverse-a05-tk.pbp.cs.ui.ac.id";
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Book>> fetchBooks(request) async {
    var books =
        await request.get('https://bookverse-a05-tk.pbp.cs.ui.ac.id/books');
    List<Book> allBooks = [];
    for (var book in books) {
      if (book != null) {
        allBooks.add(Book.fromJson(book));
      }
    }
    return allBooks;
  }

  Future<String> fetchUrl(String id) async {
    final response = await http.post(
        Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/get-book-cover/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'id': id}));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      var data = jsonDecode(response.body);
      return data['url'];
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load image URL');
    }
  }

  String imageUrl =
      'http://images.amazon.com/images/P/0195153448.01.LZZZZZZZ.jpg';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Book Loan Form',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 96, 41, 98),
          foregroundColor: Colors.white,
        ),
        //drawer: const LeftDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0, bottom: 15.0),
                      child: FutureBuilder<String>(
                        future: fetchUrl(currentId),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Image.network(replaceUrl(snapshot.data!),
                                height: 250, width: 200);
                          }
                        },
                      ))),
              const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 0.0, bottom: 15.0),
                      child: Text('Select the book title of your choice:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 0.0, bottom: 15.0),
                      child: DropdownTitle(
                        id: widget.id,
                        onValueChanged: (value) async {
                          setState(() {
                            currentId = value;
                          });
                        },
                      ))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 1, 0, 68)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Terms & Conditions'),
                                content: const SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'You must return this book no later than 7 days from now',
                                          style: TextStyle(color: Colors.red)),
                                      Text(
                                          'Are you sure you want to borrow this book?')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final response =
                                              await request.postJson(
                                                  // "http://127.0.0.1:8000/borrow-flutter/",
                                                  "https://bookverse-a05-tk.pbp.cs.ui.ac.id/borrow-flutter/",
                                                  jsonEncode(<String, String>{
                                                    'book': currentId
                                                  }));

                                          if (response['status'] == 'success') {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "You successfully borrowed the book!"),
                                              ),
                                            );
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BorrowingPage()));
                                          } else {
                                            String note = response["message"];
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(note),
                                              ),
                                            );
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          }
                                        }
                                      }),
                                ],
                              );
                            });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text('Borrow this book',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
