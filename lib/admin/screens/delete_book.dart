import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:http/http.dart' as http;

class DeleteBookScreen extends StatefulWidget {
  const DeleteBookScreen({Key? key}) : super(key: key);

  @override
  _DeleteBookScreenState createState() => _DeleteBookScreenState();
}

class _DeleteBookScreenState extends State<DeleteBookScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    // Fetch book data when the screen is initialized
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final Uri url = Uri.parse('http://bookverse-a05-tk.pbp.cs.ui.ac.id/get-books/');
    final Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Book> fetchedBooks = [];

        for (var d in data) {
          fetchedBooks.add(Book.fromJson(d));
        }

        setState(() {
          _books = fetchedBooks;
        });
      } else {
        // Handle error when the server returns a non-200 status code
        print('Failed to fetch books. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or unexpected errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              if (_books.isNotEmpty)
                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(), // Image column
                    1: FlexColumnWidth(), // Title column
                    2: FixedColumnWidth(120.0), // Delete button column
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.grey), // Add border
                  children: [
                    for (var book in _books)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              book.fields.imageUrlS,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(book.fields.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your delete logic here
                                // You can use book.pk to identify the book
                                // For now, I'll print a message
                                print('Delete ${book.fields.title}');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              child: Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              else
                const Text('No books available'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: DeleteBookScreen(),
    ),
  );
}