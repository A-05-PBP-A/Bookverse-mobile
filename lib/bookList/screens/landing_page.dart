// import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:bookverse_mobile/book_profile/models/book.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// String _search = "";
//
// class _MyHomePageState extends State<MyHomePage> {
//   Future<List<Book>> fetchProduct() async {
//     var url = Uri.parse('http://127.0.0.1:8000/get-books/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );
//
//     var data = jsonDecode(utf8.decode(response.bodyBytes));
//
//     List<Book> list_product = [];
//     for (var d in data) {
//       if (d != null) {
//         list_product.add(Book.fromJson(d));
//       }
//     }
//     return list_product;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Library'),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(14.0), // Add your desired EdgeInsets
//           child: Column(
//             children: [
//               TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search Books",
//                       labelText: "Search Books",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     onChanged: (String? value) {
//                       setState(() {
//                         _search = value!;
//                       });
//                     },
//               ),
//               FutureBuilder(
//                 future: fetchProduct(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.data == null) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else {
//                     if (!snapshot.hasData) {
//                       return const Column(
//                         children: [
//                           Text(
//                             "Tidak ada data buku.",
//                             style: TextStyle(
//                                 color: Color(0xff59A5D8), fontSize: 20),
//                           ),
//                           SizedBox(height: 8),
//                         ],
//                       );
//                     } else {
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // Set the number of cards in a row
//                           crossAxisSpacing: 16.0,
//                           mainAxisSpacing: 12.0,
//                         ),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (_, index) => InkWell(
//                           onTap: () async {
//                             ScaffoldMessenger.of(context)
//                               ..hideCurrentSnackBar()
//                               ..showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                       "Kamu memilih buku ${snapshot.data![index].fields.title}!"),
//                                 ),
//                               );
//
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     BookPage(id: snapshot.data![index].pk),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Card(
//                               margin: EdgeInsets.all(0),
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(14.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                     //if ()
//                                       Image.network(
//                                         "${snapshot.data![index].fields.imageUrlM}",
//                                         height:
//                                             100, // Set the height as per your design
//                                         width:
//                                             100, // Set the width as per your design
//                                         fit: BoxFit
//                                             .cover, // Adjust the BoxFit as needed
//                                       ),
//                                       const SizedBox(height: 4),
//                                       RichText(
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text:
//                                                   "${snapshot.data![index].fields.title}\n",
//                                               style: const TextStyle(
//                                                 fontSize: 14.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             TextSpan(
//                                               text: "\n", // Empty line
//                                             ),
//                                           ],
//                                         ),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         "${snapshot.data![index].fields.author}",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         "${snapshot.data![index].fields.publicationYear}",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ));
//                     }
//                   }
//                 },
//               ),
//             ],
//           )),
//     );
//   }
// }

// import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:bookverse_mobile/book_profile/models/book.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// String _search = "";
//
// class _MyHomePageState extends State<MyHomePage> {
//   Future<List<Book>> fetchProduct() async {
//     var url = Uri.parse('http://127.0.0.1:8000/get-books/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );
//
//     var data = jsonDecode(utf8.decode(response.bodyBytes));
//
//     List<Book> list_product = [];
//     for (var d in data) {
//       if (d != null) {
//         list_product.add(Book.fromJson(d));
//       }
//     }
//     return list_product;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Library'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(14.0),
//         child: SingleChildScrollView (
//         child: Column(
//           children: <Widget>[
//             const SizedBox(height: 4),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Search Books",
//                 labelText: "Search Books",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//               ),
//               onChanged: (String? value) {
//                 setState(() {
//                   _search = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 6),
//             FutureBuilder(
//               future: fetchProduct(),
//               builder: (context, AsyncSnapshot<List<Book>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Column(
//                     children: [
//                       Text(
//                         "Tidak ada data buku.",
//                         style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                       ),
//                       SizedBox(height: 8),
//                     ],
//                   );
//                 } else {
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 12.0,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index) => InkWell(
//                       onTap: () async {
//                         ScaffoldMessenger.of(context)
//                           ..hideCurrentSnackBar()
//                           ..showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Kamu memilih buku ${snapshot.data![index].fields.title}!"),
//                             ),
//                           );
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 BookPage(id: snapshot.data![index].pk),
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Card(
//                           margin: EdgeInsets.all(0),
//                           child: SizedBox(
//                             width: double.infinity,
//                             height: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Image.network(
//                                     "${snapshot.data![index].fields.imageUrlM}",
//                                     height: 100,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: "${snapshot.data![index].fields.title}\n",
//                                           style: const TextStyle(
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: "\n",
//                                         ),
//                                       ],
//                                     ),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "${snapshot.data![index].fields.author}",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "${snapshot.data![index].fields.publicationYear}",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String _search = "";

class _MyHomePageState extends State<MyHomePage> {
  List<Book> _filteredBooks = [];

  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/get-books/');
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || _filteredBooks.isEmpty) {
                    return Column(
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            margin: EdgeInsets.all(0),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "${_filteredBooks[index].fields.imageUrlM}",
                                      height: 100,
                                      width: 100,
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
                                          TextSpan(
                                            text: "\n",
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${_filteredBooks[index].fields.author}",
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


