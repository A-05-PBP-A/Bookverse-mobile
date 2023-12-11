// import 'package:flutter/material.dart';
// import 'package:bookverse_mobile/bookList/widgets/book_card.dart';
//
// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   final List<BookItem> items = [
//     BookItem("Buku 1", "2023", "Publisher 1"),
//     BookItem("Buku 2", "2022", "Publisher 2"),
//     BookItem("Buku 3", "2021", "Publisher 3"),
//     BookItem("Buku 4", "2020", "Publisher 4"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Bookverse Mobile',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                   child: Text(
//                     'Home',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 GridView.count(
//                   primary: true,
//                   padding: const EdgeInsets.all(20),
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   crossAxisCount: 3,
//                   shrinkWrap: true,
//                   children: items.map((BookItem item) {
//                     return BookCard(item);
//                   }).toList(),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }

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
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/get-books/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
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
        //drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.author}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.publicationYear}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}