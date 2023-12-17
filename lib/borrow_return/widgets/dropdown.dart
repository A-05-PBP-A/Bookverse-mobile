import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bookverse_mobile/borrow_return/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DropdownTitle extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  const DropdownTitle({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  State<DropdownTitle> createState() => _DropdownTitleState();
}

class _DropdownTitleState extends State<DropdownTitle> {
  //String baseUrl = "http://127.0.0.1:8000";
  String baseUrl = "http://10.0.2.2:8000";
  Future<List<Book>> fetchBooks(request) async {
    // var books = await request.get('http://127.0.0.1:8000/books');
    var books = await request.get('$baseUrl/books');
    List<Book> allBooks = [];
    for (var book in books) {
      if (book != null) {
        allBooks.add(Book.fromJson(book));
      }
    }
    return allBooks;
  }

  // String _selected =
  //     "http://images.amazon.com/images/P/0195153448.01.LZZZZZZZ.jpg";
  String imageUrl = '';
  // String _book = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder<List<Book>>(
      future: fetchBooks(request),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.hasData) {
          return DropdownMenu<String>(
            initialSelection: snapshot.data!.first.pk.toString(),
            onSelected: (String? value) async {
              final response = await request.postJson(
                  '$baseUrl/get-book-cover/',
                  // 'http://127.0.0.1:8000/get-book-cover/',
                  jsonEncode(<String, String>{'id': value.toString()}));
              setState(() {
                imageUrl = response['url'];
                //_book = value!;
              });
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
