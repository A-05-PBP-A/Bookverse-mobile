// To parse this JSON data, do
//
//     final booksHistoryModel = booksHistoryModelFromJson(jsonString);

import 'dart:convert';

List<BooksHistoryModel> booksHistoryModelFromJson(String str) => List<BooksHistoryModel>.from(json.decode(str).map((x) => BooksHistoryModel.fromJson(x)));

String booksHistoryModelToJson(List<BooksHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksHistoryModel {
    String model;
    int pk;
    Fields fields;

    BooksHistoryModel({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BooksHistoryModel.fromJson(Map<String, dynamic> json) => BooksHistoryModel(
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
    dynamic booksHistory;
    String bookTitle;
    String imageUrlL;
    int referenceId;
    bool isReturned;

    Fields({
        required this.user,
        required this.book,
        required this.booksHistory,
        required this.bookTitle,
        required this.imageUrlL,
        required this.referenceId,
        required this.isReturned,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        booksHistory: json["booksHistory"],
        bookTitle: json["book_title"],
        imageUrlL: json["image_url_l"],
        referenceId: json["reference_id"],
        isReturned: json["is_returned"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "booksHistory": booksHistory,
        "book_title": bookTitle,
        "image_url_l": imageUrlL,
        "reference_id": referenceId,
        "is_returned": isReturned,
    };
}
