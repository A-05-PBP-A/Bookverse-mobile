import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final String isbn;
  final String title;
  final String author;
  final int publicationYear;
  final String publisher;
  final String imageUrlS;
  final String imageUrlM;
  final String imageUrlL;

  Book({
    required this.isbn,
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.publisher,
    required this.imageUrlS,
    required this.imageUrlM,
    required this.imageUrlL,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      isbn: json['isbn'],
      title: json['title'],
      author: json['author'],
      publicationYear: json['publication_year'],
      publisher: json['publisher'],
      imageUrlS: json['image_url_s'],
      imageUrlM: json['image_url_m'],
      imageUrlL: json['image_url_l'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isbn': isbn,
      'title': title,
      'author': author,
      'publication_year': publicationYear,
      'publisher': publisher,
      'image_url_s': imageUrlS,
      'image_url_m': imageUrlM,
      'image_url_l': imageUrlL,
    };
  }
}

Future<void> addBook(Book book) async {
  final Uri url = Uri.parse('http://127.0.0.1:8000/add_book/');
  final Map<String, String> headers = {"Content-Type": "application/json"};

  final response = await http.post(
    url,
    headers: headers,
    body: json.encode(book.toJson()),
  );

  if (response.statusCode == 200) {
    // Book added successfully
    print('Book added successfully');
  } else {
    // Handle error
    print('Failed to add book. Status code: ${response.statusCode}');
  }
}

class FormInputPage extends StatelessWidget {
  const FormInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Input Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputField('ISBN'),
                _buildInputField('Title'),
                _buildInputField('Author'),
                _buildInputField('Year of publication'),
                _buildInputField('Publisher'),
                _buildInputField('Image URL-S'),
                _buildInputField('Image URL-M'),
                _buildInputField('Image URL-L'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle submit logic (masih harus di integrasi)
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go back'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}