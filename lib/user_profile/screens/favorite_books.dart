import 'dart:convert';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bookverse_mobile/user_profile/models/favorite_books_models.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FavoriteBooks extends StatefulWidget {
  const FavoriteBooks({Key? key}) : super(key: key);

  @override
  State<FavoriteBooks> createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends State<FavoriteBooks> {
  Future<List<FavBook>> fetchBook(username) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/book_favorite_flutter/$username/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );
    
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<FavBook> books = [];
      for (var d in data) {
          if (d != null) {
              books.add(FavBook.fromJson(d));
          }
      }
      return books;
  }

  Future<void> deleteFavBook(int bookId) async {
    final url = 'http://127.0.0.1:8000/delete_bookFav/$bookId/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Book deleted successfully');
      setState(() {});
    } else {
      print('Failed to delete book');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Future<List<FavBook>> listFavBook = fetchBook(userProvider.username);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
      ),
      body: Center(
        child: FutureBuilder<List<FavBook>>(
          future: listFavBook,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show an error message if the future encountered an error
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data!.isEmpty) {
              // Show message when the list is empty
              return const Text('No favorite books');
            } else {
              // Build the ListView when the data is available
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return BooksHistoryCard(
                    bookTitle: snapshot.data![index].fields.bookTitle,
                    bookCover: snapshot.data![index].fields.imageUrlL,
                    onRemove: () {
                      deleteFavBook(snapshot.data![index].fields.referenceId);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class BooksHistoryCard extends StatelessWidget {
  final String bookTitle;
  final String bookCover;
  final VoidCallback? onRemove;

  const BooksHistoryCard({
    Key? key,
    required this.bookTitle,
    required this.bookCover,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[800],
      child: InkWell(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 300.0, // Set a fixed height for the image
                  width: 200.0, // Set a fixed width for the image
                  child: Image.network(
                    bookCover,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                  child: Text(
                    bookTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onRemove,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
