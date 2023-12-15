import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookverse_mobile/book_profile/models/book.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/get-books/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Book> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0), // Add your desired EdgeInsets
        child: FutureBuilder(
          future: fetchProduct(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data buku.",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of cards in a row
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () async {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                "Kamu memilih buku ${snapshot.data![index].fields.title}!"),
                          ),
                        );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookPage(id: snapshot.data![index].pk),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        margin: EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "${snapshot.data![index].fields.imageUrlM}",
                                height: 110, // Set the height as per your design
                                width: 100, // Set the width as per your design
                                fit: BoxFit.cover, // Adjust the BoxFit as needed
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${snapshot.data![index].fields.title}\n",
                                      style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\n", // Empty line
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${snapshot.data![index].fields.author}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${snapshot.data![index].fields.publicationYear}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

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
//       body: FutureBuilder(
//         future: fetchProduct(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             if (!snapshot.hasData) {
//               return const Column(
//                 children: [
//                   Text(
//                     "Tidak ada data produk.",
//                     style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               );
//             } else {
//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // Set the number of cards in a row
//                   crossAxisSpacing: 16.0,
//                   mainAxisSpacing: 12.0,
//                 ),
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (_, index) => InkWell(
//                   onTap: () async {
//                     ScaffoldMessenger.of(context)
//                       ..hideCurrentSnackBar()
//                       ..showSnackBar(
//                         SnackBar(
//                           content: Text(
//                               "Kamu memilih buku ${snapshot.data![index].fields.title}!"),
//                         ),
//                       );
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             BookPage(id: snapshot.data![index].pk),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.all(0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${snapshot.data![index].fields.title}",
//                             style: const TextStyle(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text("${snapshot.data![index].fields.author}"),
//                           const SizedBox(height: 10),
//                           Text("${snapshot.data![index].fields.publicationYear}")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//         },
//       ),
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
//       body: FutureBuilder(
//         future: fetchProduct(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             if (!snapshot.hasData) {
//               return const Column(
//                 children: [
//                   Text(
//                     "Tidak ada data produk.",
//                     style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (_, index) => InkWell(
//                   onTap: () async {
//                     // Handle card click event here
//                     // You can navigate to a new screen or perform any action
//                     // print('Card Clicked!');
//                     ScaffoldMessenger.of(context)
//                       ..hideCurrentSnackBar()
//                       ..showSnackBar(
//                         SnackBar(
//                           content:
//                               Text("Kamu memilih buku ${snapshot.data![index].fields.title}!"),
//                         ),
//                       );
//
//                     // ini ya buat ganti pagenya
//                     Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => BookPage(id: snapshot.data![index].pk)));
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 12,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${snapshot.data![index].fields.title}",
//                             style: const TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text("${snapshot.data![index].fields.author}"),
//                           const SizedBox(height: 10),
//                           Text("${snapshot.data![index].fields.publicationYear}")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//         },
//       ),
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
//       body: FutureBuilder(
//         future: fetchProduct(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             if (!snapshot.hasData) {
//               return const Column(
//                 children: [
//                   Text(
//                     "Tidak ada data produk.",
//                     style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               );
//             } else {
//               return Container(
//                 height: 200, // Set the height of each card
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (_, index) => InkWell(
//                     onTap: () async {
//                       ScaffoldMessenger.of(context)
//                         ..hideCurrentSnackBar()
//                         ..showSnackBar(
//                           SnackBar(
//                             content: Text(
//                                 "Kamu memilih buku ${snapshot.data![index].fields.title}!"),
//                           ),
//                         );
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 BookPage(id: snapshot.data![index].pk)),
//                       );
//                     },
//                     child: Container(
//                       width: 150, // Set the width of each card
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${snapshot.data![index].fields.title}",
//                                 style: const TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text("${snapshot.data![index].fields.author}"),
//                               const SizedBox(height: 10),
//                               Text(
//                                   "${snapshot.data![index].fields.publicationYear}")
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }
