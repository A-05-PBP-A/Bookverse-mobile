// To parse this JSON data, do
//
//     final borrowing = borrowingFromJson(jsonString);

import 'dart:convert';

List<Borrowing> borrowingFromJson(String str) =>
    List<Borrowing>.from(json.decode(str).map((x) => Borrowing.fromJson(x)));

String borrowingToJson(List<Borrowing> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Borrowing {
  String model;
  int pk;
  Fields fields;

  Borrowing({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Borrowing.fromJson(Map<String, dynamic> json) => Borrowing(
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
  DateTime borrowDate;
  DateTime returnDate;
  bool isReturned;
  String bookTitle;
  String imageUrlL;
  dynamic realReturnDate;
  int referenceId;

  Fields({
    required this.user,
    required this.book,
    required this.borrowDate,
    required this.returnDate,
    required this.isReturned,
    required this.bookTitle,
    required this.imageUrlL,
    required this.realReturnDate,
    required this.referenceId,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        borrowDate: DateTime.parse(json["borrow_date"]),
        returnDate: DateTime.parse(json["return_date"]),
        isReturned: json["is_returned"],
        bookTitle: json["book_title"],
        imageUrlL: json["image_url_l"],
        realReturnDate: json["real_return_date"],
        referenceId: json["reference_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "borrow_date": borrowDate.toIso8601String(),
        "return_date": returnDate.toIso8601String(),
        "is_returned": isReturned,
        "book_title": bookTitle,
        "image_url_l": imageUrlL,
        "real_return_date": realReturnDate,
        "reference_id": referenceId,
      };
}
