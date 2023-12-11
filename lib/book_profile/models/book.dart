// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String isbn;
    String title;
    String author;
    int publicationYear;
    String publisher;
    String imageUrlS;
    String imageUrlM;
    String imageUrlL;

    Fields({
        required this.isbn,
        required this.title,
        required this.author,
        required this.publicationYear,
        required this.publisher,
        required this.imageUrlS,
        required this.imageUrlM,
        required this.imageUrlL,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        author: json["author"],
        publicationYear: json["publication_year"],
        publisher: json["publisher"],
        imageUrlS: json["image_url_s"],
        imageUrlM: json["image_url_m"],
        imageUrlL: json["image_url_l"],
    );

    Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "author": author,
        "publication_year": publicationYear,
        "publisher": publisher,
        "image_url_s": imageUrlS,
        "image_url_m": imageUrlM,
        "image_url_l": imageUrlL,
    };
}
