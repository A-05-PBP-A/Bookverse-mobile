import 'package:bookverse_mobile/book_profile/models/review.dart';
import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
import 'package:bookverse_mobile/borrow_return/widgets/borrowing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  final String bookName;
  final String imageUrl;
  final int bookId;

  const ReviewPage({Key? key, required this.bookName, required this.imageUrl, required this.bookId})
      : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
    final _formKey = GlobalKey<FormState>();
    int _rating = 0;
    String _review = "";
    bool _isRated = false;

Future<List<Review>> fetchReview() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://bookverse-a05-tk.pbp.cs.ui.ac.id/get_review_json/${widget.bookId}/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Review
    List<Review> reviews = [];
    for (var d in data) {
      if (d != null) {
          Review review = Review.fromJson(d);
          reviews.add(review);
      }
    }

    return reviews;
}

@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
  return Scaffold(
    appBar: AppBar(
      title: const Text('Review'),
      backgroundColor: Color.fromARGB(255, 95, 61, 168),
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.network(
            replaceUrl(widget.imageUrl),
            width: 200,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.bookName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        
        // Add the form here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RatingBar.builder(
                            initialRating: _rating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 40.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: index < _rating ? Colors.orange : Colors.grey,
                              );
                            },
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating.toInt();
                                _isRated = true;
                              });
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            _isRated ? 'Thanks for your rating!' : 'Tap to rate',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Review",
                        labelText: "Review",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _review = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Review tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                          ),
                          onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                  // Kirim ke Django dan tunggu respons
                                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                  final response = await request.postJson(
                                  "https://bookverse-a05-tk.pbp.cs.ui.ac.id/create-flutter/",
                                  jsonEncode(<String, String>{
                                      'book_id': widget.bookId.toString(),
                                      'rating': _rating.toString(),
                                      'review': _review,
                                      // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                  }));
                                  if (response['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                      content: Text("Review berhasil dibuat!"),
                                      ));

                                  Navigator.pop(context); 

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookPage(id: widget.bookId)),
                                    );
                                  } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Review Already Submitted'),
                                          content: Text(response['message']),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                  }
                              }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        const SizedBox(height: 16),
        FutureBuilder(
        future: fetchReview(),
        builder: (context, AsyncSnapshot<List<Review>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 255, 0, 0),
                      size: 50,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Tidak ada review.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Silakan tambahkan review untuk buku ini.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data![index].fields.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              snapshot.data![index].fields.rating,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(snapshot.data![index].fields.review),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(snapshot.data![index].fields.name),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: List.generate(
                                      snapshot.data![index].fields.rating,
                                      (index) => const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(snapshot.data![index].fields.review),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tutup'),
                                 ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
      ],
    ),
  )
  );
}
}