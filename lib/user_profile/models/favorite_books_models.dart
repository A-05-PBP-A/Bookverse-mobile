// To parse this JSON data, do
//
//     final favBook = favBookFromJson(jsonString);

import 'dart:convert';

List<FavBook> favBookFromJson(String str) => List<FavBook>.from(json.decode(str).map((x) => FavBook.fromJson(x)));

String favBookToJson(List<FavBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavBook {
    String model;
    int pk;
    Fields fields;

    FavBook({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory FavBook.fromJson(Map<String, dynamic> json) => FavBook(
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
    int user;
    int book;
    dynamic favoriteBooks;
    String bookTitle;
    String imageUrlL;
    int referenceId;

    Fields({
        required this.user,
        required this.book,
        required this.favoriteBooks,
        required this.bookTitle,
        required this.imageUrlL,
        required this.referenceId,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        favoriteBooks: json["favoriteBooks"],
        bookTitle: json["book_title"],
        imageUrlL: json["image_url_l"],
        referenceId: json["reference_id"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "favoriteBooks": favoriteBooks,
        "book_title": bookTitle,
        "image_url_l": imageUrlL,
        "reference_id": referenceId,
    };
}
