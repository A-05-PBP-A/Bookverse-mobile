import 'package:flutter/material.dart';
import 'package:bookverse_mobile/user_profile/models/books_history_models.dart';
import 'package:bookverse_mobile/user_profile/models/favorite_books_models.dart';

class ReadedBooks extends StatefulWidget {
  /*Tidak jadi pakai constructor ini karena sudah menggunakan models
  final String? bookTitle;
  final String? cover;

  ReadedBooks({
    this.bookTitle,
    this.cover,
  });
  */
  const ReadedBooks({super.key});

  @override
  _ReadedBooksState createState() => _ReadedBooksState();
}

class _ReadedBooksState extends State<ReadedBooks> {
  /*Karena sudah menggunakan models fungsi ini tidak dibutuhkan lagi
  @override
  void initState() {
    super.initState();
    // Add the values to the lists when the constructor is called
    if (widget.bookTitle != null) {
      BooksHistoryModel.getReturnedBooks().add(widget.bookTitle!);
    }
    if (widget.cover != null) {
      BooksHistoryModel.getReturnedBookCovers().add(widget.cover!);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Readed Books'),
      ),
      body: Center(
        child: BooksHistoryModel.getReturnedBooks().isEmpty
            ? Text('No books you have borrowed yet')
            : ListView.builder(
                itemCount: BooksHistoryModel.getReturnedBooks().length,
                itemBuilder: (context, index) {
                  return BooksHistoryCard(
                    bookTitle: BooksHistoryModel.getBookTitleByIndex(index),
                    bookCover: BooksHistoryModel.getCoverByIndex(index),
                  );
                },
              ),
      ),
    );
  }
}

class BooksHistoryCard extends StatefulWidget {
  final String bookTitle;
  final String bookCover;
  final VoidCallback? onRemove;

  BooksHistoryCard({
    required this.bookTitle,
    required this.bookCover,
    this.onRemove,
  });

  @override
  _BooksHistoryCardState createState() => _BooksHistoryCardState();
}

class _BooksHistoryCardState extends State<BooksHistoryCard> {
  late bool isFavorite;

  //untuk automatic refresh state favorite button jadi merah saat jadi favorite
  @override
  void initState() {
    super.initState();
    // Initialize the isFavorite variable based on the current state
    isFavorite = FavoritesBooksModels.isBookInFavorites(widget.bookTitle);
  }

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
                Image.network(
                  widget.bookCover,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                  child: Text(
                    widget.bookTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        widget.onRemove?.call();
                      } else {
                        // Add to favorites
                        FavoritesBooksModels.addToFavorites(
                            widget.bookTitle, widget.bookCover);
                      }
                      // Toggle the isFavorite state
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




