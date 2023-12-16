import 'dart:convert';
import 'package:bookverse_mobile/book_profile/models/review.dart';
import 'package:bookverse_mobile/book_profile/screens/review_page.dart';
import 'package:bookverse_mobile/borrow_return/screens/borrow.dart';
import 'package:http/http.dart' as http;
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:flutter/material.dart';


int totalRating = 0;
int totalReviews = 0;
double averageRating = 0.0;

class BookPage extends StatefulWidget {
  final int id;

  const BookPage({Key? key, required this.id}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
    Future<List<Book>> fetchBook() async {
      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
      var url = Uri.parse(
          'http://127.0.0.1:8000/api/${widget.id}/');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );
      
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<Book> books = [];
        for (var d in data) {
            if (d != null) {
                books.add(Book.fromJson(d));
            }
        }
        return books;
      }

      Future<List<Review>> fetchReview() async {
        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
        var url = Uri.parse(
            'http://127.0.0.1:8000/get_review_json/${widget.id}/');
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

        updateReviewData(reviews);

        reviews = reviews.length > 3 ? reviews.sublist(reviews.length - 3) : reviews;

        return reviews;
      }

      void updateReviewData(List<Review> reviews) {
        int tempTotalRating = 0;
        int tempTotalReviews = 0;

        // Menghitung total rating dan total reviews
        for (var review in reviews) {
          tempTotalRating += review.fields.rating;
          tempTotalReviews++;
        }

        // Mengupdate variabel global
        totalRating = tempTotalRating;
        totalReviews = tempTotalReviews;

        // Menghitung rata-rata
        if (totalReviews > 0) {
          averageRating = totalRating / totalReviews;
        } else {
          averageRating = 0.0;
        }

        // Memanggil setState untuk memperbarui UI
        setState(() {});
      }

  bool _isHovering = false;
  bool _isHoveringSee = false;
  bool _isFavorite = false;

@override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Buku'),
        ),
        body: FutureBuilder(
          future: fetchBook(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data buku.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                    height: 500, 
                    child: Center(
                      child: Image.network(
                        "${snapshot.data![index].fields.imageUrlL}",
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Text(
              '${snapshot.data![index].fields.title}', 
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '${snapshot.data![index].fields.author}', 
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            SizedBox(
            width: 600,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  onEnter: (event) => setState(() => _isHovering = true),
                  onExit: (event) => setState(() => _isHovering = false),
                  child: Opacity(
                    opacity: _isHovering ? 0.3 : 1.0,
                    child: InkWell(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewPage(
                              bookName: snapshot.data![index].fields.title,
                              imageUrl: snapshot.data![index].fields.imageUrlL, 
                              bookId: widget.id,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: List.generate(
                              averageRating.round(), // Ubah dengan average ini masih temp
                              (index) => const Icon(Icons.star, color: Colors.orange, size: 22.0),
                            )
                            ..addAll(
                              List.generate(
                                5 - averageRating.round(), // Ubah dengan average ini masih temp
                                (index) => const Icon(Icons.star, color: Colors.grey, size: 22.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: averageRating.toStringAsFixed(1), // Ubah dengan average ini masih temp
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 4),
                              ),
                              const WidgetSpan(
                                child: Icon(Icons.star, color: Colors.black, size: 15),
                              ),
                              TextSpan(
                                text: ' | $totalReviews Ratings', // Ubah ke jumlah rating ini masih temp 
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: _isFavorite ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });

                    if (_isFavorite) {
                      print('Ditambahkan ke favorit');
                      // Tambahkan logika ketika difavoritkan
                    } else {
                      print('Dihapus dari favorit');
                      // Tambahkan logika ketika dihapus dari favorit
                    }
                  },
                )
              ],
            ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  // Redirect ke page pinjam buku
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BookFormPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text(
                  'Pinjam',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 15),
              const Text(
              'Tahun Publikasi:', 
                  style: TextStyle(fontSize: 18),
                ),
                
                Text(
                  '${snapshot.data![index].fields.publicationYear}', 
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Penerbit:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${snapshot.data![index].fields.publisher}', 
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ISBN:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '${snapshot.data![index].fields.isbn}', 
                  style: const TextStyle(fontSize: 18),
                ),
            const SizedBox(height: 15),
            const SizedBox(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
            width: 600,
            child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'User Review', 
                  style: TextStyle(fontSize: 20),
                ),
                MouseRegion(
                  onEnter: (event) => setState(() => _isHoveringSee = true),
                  onExit: (event) => setState(() => _isHoveringSee = false),
                  child: Opacity(
                    opacity: _isHoveringSee ? 0.3 : 1.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewPage(
                              bookName: snapshot.data![index].fields.title,
                              imageUrl: snapshot.data![index].fields.imageUrlL, 
                              bookId: widget.id,
                            ),
                          ),
                        );
                      },
                      child: const Column(
                        children: [
                          Text(
                            'See All >',
                            style: TextStyle(fontSize: 20),
                           ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
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
                                SizedBox(height: 8),
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
                      }
                    )
                  ], 
                ), 
              )
            ); 
          }
        }, 
      ),
    ); 
  }
}