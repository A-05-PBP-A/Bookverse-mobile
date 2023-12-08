import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
    const BookPage({Key? key}) : super(key: key);

    @override
    _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
    Future<List<Book>> fetchBook() async {
      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
      var url = Uri.parse(
          'http://127.0.0.1:8000/api/7/');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );
      
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<Book> books = [];
        for (var d in data) {
            if (d != null) {
                books.add(Book.fromJson(d));
            }
        }
        return books;
  }
  bool _isHovering = false;
  bool _isHoveringSee = false;

@override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Buku'),
        ),
        body: FutureBuilder(
          future: fetchBook(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data buku.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                    height: 500, 
                    child: Center(
                      child: Image.network(
                        "${snapshot.data![index].fields.imageUrlL}", 
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Text(
              '${snapshot.data![index].fields.title}', 
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '${snapshot.data![index].fields.author},', 
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  onEnter: (event) => setState(() => _isHovering = true),
                  onExit: (event) => setState(() => _isHovering = false),
                  child: Opacity(
                    opacity: _isHovering ? 0.3 : 1.0,
                    child: InkWell(
                      onTap: () {
                        // Redirect ke page review
                      },
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            '0 Ratings', // Dummy total reviews
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Fungsi favorit
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  // Redirect ke page pinjam buku
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text(
                  'Pinjam',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 15),
              const Text(
              'Tahun Publikasi:', 
                  style: TextStyle(fontSize: 18),
                ),
                
                Text(
                  '${snapshot.data![index].fields.publicationYear}', 
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Penerbit:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${snapshot.data![index].fields.publisher}', 
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ISBN:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${snapshot.data![index].fields.isbn}', 
                  style: const TextStyle(fontSize: 18),
                ),
            const SizedBox(height: 15),
            const SizedBox(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'User Review', 
                  style: TextStyle(fontSize: 20),
                ),
                MouseRegion(
                  onEnter: (event) => setState(() => _isHoveringSee = true),
                  onExit: (event) => setState(() => _isHoveringSee = false),
                  child: Opacity(
                    opacity: _isHoveringSee ? 0.3 : 1.0,
                    child: InkWell(
                      onTap: () {
                        // Redirect ke page review
                      },
                      child: const Column(
                        children: [
                          Text(
                            'See All >',
                            style: TextStyle(fontSize: 20),
                           ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ], 
                ), 
              )
           ); 
          }
        }, 
      ), 
    ); 
  }
}