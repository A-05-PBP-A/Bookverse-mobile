import 'package:flutter/material.dart';
import 'package:bookverse_mobile/user_profile/models/favorite_books_models.dart';

class FavoriteBooks extends StatefulWidget {
  const FavoriteBooks({super.key});

  @override
  State<FavoriteBooks> createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends State<FavoriteBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
      ),
      body: Center(
        child: FavoritesBooksModels.getFavoriteBooks().isEmpty
            ? const Text('No favorite books')
            : ListView.builder(
                itemCount: FavoritesBooksModels.getFavoriteBooks().length,
                itemBuilder: (context, index) {
                  return BooksHistoryCard(
                    bookTitle: FavoritesBooksModels.getBookTitleByIndex(index),
                    bookCover: FavoritesBooksModels.getCoverByIndex(index),
                    onRemove: () {
                      removeFromFavoritesAndRefresh(index);
                    },
                  );
                },
              ),
      ),
    );
  }

  // Method to remove from favorites and trigger a refresh. Tidak pakai state karena menghapus data bukan state
  void removeFromFavoritesAndRefresh(int index) {
    FavoritesBooksModels.removeFromFavorites(index);
    setState(() {}); // Trigger a rebuild of the widget tree. To automatic refresh
  }
}

class BooksHistoryCard extends StatelessWidget {
  final String bookTitle;
  final String bookCover;
  final VoidCallback? onRemove;

  const BooksHistoryCard({super.key, 
    required this.bookTitle,
    required this.bookCover,
    this.onRemove,
  });

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
                  bookCover,
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
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



