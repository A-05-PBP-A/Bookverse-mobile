import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrow_return/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DropdownTitle extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final String id;
  const DropdownTitle({Key? key, required this.onValueChanged, this.id = "1"})
      : super(key: key);

  @override
  State<DropdownTitle> createState() => _DropdownTitleState();
}

class _DropdownTitleState extends State<DropdownTitle> {
  //String baseUrl = "http://127.0.0.1:8000";
  String baseUrl = "https://bookverse-a05-tk.pbp.cs.ui.ac.id";
  Future<List<Book>> fetchBooks(request) async {
    // var books = await request.get('http://127.0.0.1:8000/books');
    var books = await request.get('https://bookverse-a05-tk.pbp.cs.ui.ac.id/books');
    List<Book> allBooks = [];
    for (var book in books) {
      if (book != null) {
        allBooks.add(Book.fromJson(book));
      }
    }
    return allBooks;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder<List<Book>>(
      future: fetchBooks(request),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.hasData) {
          return DropdownMenu<String>(
            initialSelection: widget.id,
            onSelected: (String? value) async {
              widget.onValueChanged(value!);
            },
            dropdownMenuEntries:
                snapshot.data!.map<DropdownMenuEntry<String>>((Book book) {
              return DropdownMenuEntry<String>(
                  value: book.pk.toString(), label: book.toString());
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
