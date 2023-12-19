import 'package:bookverse_mobile/borrow_return/widgets/borrowing_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String _search = "";

class _MyHomePageState extends State<MyHomePage> {
  List<Book> _filteredBooks = [];

  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/get-books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Book.fromJson(d));
      }
    }

    // Filtering based on search query
    _filteredBooks = listProduct.where((book) {
      return book.fields.title.toLowerCase().contains(_search.toLowerCase()) ||
          book.fields.author.toLowerCase().contains(_search.toLowerCase()) ||
          book.fields.publicationYear.toString().contains(_search);
    }).toList();

    return _filteredBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 4),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search Books",
                  labelText: "Search Books",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _search = value!;
                  });
                },
              ),
              const SizedBox(height: 6),
              FutureBuilder(
                future: fetchProduct(),
                builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || _filteredBooks.isEmpty) {
                    return const Column(
                      children: [
                        Text(
                          "Tidak ada data buku.",
                          style: TextStyle(
                              color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: _filteredBooks.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Kamu memilih buku ${_filteredBooks[index].fields.title}!"),
                              ),
                            );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookPage(id: _filteredBooks[index].pk),
                            ),
                          );
                        },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                              border: Border.all(
                                color: Colors.grey, // Add border color if needed
                                width: 1.0, // Add border width if needed
                              ),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      replaceUrl(_filteredBooks[index].fields.imageUrlM),
                                      height: 210,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 6),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "${_filteredBooks[index].fields.title}\n",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: "\n",
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _filteredBooks[index].fields.author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${_filteredBooks[index].fields.publicationYear}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
          );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


