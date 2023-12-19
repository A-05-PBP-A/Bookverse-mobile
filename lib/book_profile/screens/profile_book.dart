import 'dart:convert';
import 'package:bookverse_mobile/book_profile/models/review.dart';
import 'package:bookverse_mobile/book_profile/screens/review_page.dart';
import 'package:bookverse_mobile/borrow_return/screens/borrow.dart';
import 'package:http/http.dart' as http;
import 'package:bookverse_mobile/book_profile/models/book.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookverse_mobile/user_profile/models/favorite_books_models.dart';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';

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
    var url = Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/api/${widget.id}/');
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
    var url = Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/get_review_json/${widget.id}/');
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

    reviews =
        reviews.length > 3 ? reviews.sublist(reviews.length - 3) : reviews;

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
  }

  Future<void> fetchFavBook(username) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url =
        Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/book_favorite_flutter/$username/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    for (var d in data) {
      if (d != null) {
        listFavBook.add(FavBook.fromJson(d));
      }
    }
  }

  //cek apakah buku sudah di favorite atau belum
  bool isBookFav(List<FavBook> listFavBook, String bookTitle) {
    return listFavBook.any((book) => book.fields.bookTitle == bookTitle);
  }

  Future<void> deleteFavBook(int bookId) async {
    final url = 'https://bookverse-a05-tk.pbp.cs.ui.ac.id/delete_bookFav/$bookId/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Removed from Favorites"),
        ),
      );
      print('Book deleted successfully');
      setState(() {});
    } else {
      print('Failed to delete book');
    }
  }

  List<FavBook> listFavBook = []; //list buku favorit

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    fetchFavBook(userProvider.username);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: FutureBuilder(
        future: Future.wait([fetchBook(), fetchReview()]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data buku.'));
          } else {
            return ListView.builder(
                itemCount: snapshot.data![0].length,
                itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 500,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0), 
                                child: Image.network(
                                  "${snapshot.data![0][index].fields.imageUrlL}",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${snapshot.data![0][index].fields.title}',
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${snapshot.data![0][index].fields.author}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: 365,
                            padding: const EdgeInsets.symmetric(horizontal: 20), 
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 400), 
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MouseRegion(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewPage(
                                              bookName: snapshot.data![0][index].fields.title,
                                              imageUrl: snapshot.data![0][index].fields.imageUrlL,
                                              bookId: widget.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              averageRating.round(),
                                              (index) => const Icon(Icons.star,
                                                  color: Colors.orange, size: 22.0),
                                            )..addAll(
                                                List.generate(
                                                  5 - averageRating.round(),
                                                  (index) => const Icon(Icons.star,
                                                      color: Colors.grey, size: 22.0),
                                                ),
                                              ),
                                          ),
                                          const SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text: averageRating.toStringAsFixed(1),
                                                  style: const TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.bold),
                                                ),
                                                const WidgetSpan(
                                                  child: SizedBox(width: 4),
                                                ),
                                                const WidgetSpan(
                                                  child: Icon(Icons.star, color: Colors.black, size: 15),
                                                ),
                                                TextSpan(
                                                  text: ' | $totalReviews Ratings',
                                                  style: const TextStyle(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                
                                IconButton(
                                  icon: isBookFav(listFavBook,
                                          snapshot.data![0][index].fields.title)
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
                                      : const Icon(Icons.favorite_border),
                                  onPressed: () async {
                                    //add ke favorites
                                    if (isBookFav(
                                            listFavBook,
                                            snapshot.data![0][index].fields
                                                .title) ==
                                        false) {
                                      try {
                                        final response = await request.postJson(
                                          "https://bookverse-a05-tk.pbp.cs.ui.ac.id/favorite-flutter/",
                                          jsonEncode(<String, int>{
                                            'bookId': widget.id,
                                          }),
                                        );

                                        if (response['status'] == 'success') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Added To Favorites"),
                                            ),
                                          );
                                          // reload the page by calling setState
                                          setState(() {});
                                        } else {
                                          print(
                                              'Failed to add to favorites. Status code: ${response.statusCode}');
                                          // Handle the error accordingly.
                                        }
                                      } catch (error) {
                                        print('Error: $error');
                                        // Handle network or other errors.
                                      }
                                    }

                                    //remove dari favorites
                                    else {
                                      await deleteFavBook(
                                          snapshot.data![0][index].pk);
                                      // reload the page by calling setState
                                      setState(() {
                                        listFavBook.removeWhere((book) =>
                                            book.fields.bookTitle ==
                                            snapshot
                                                .data![0][index].fields.title);
                                      });
                                    }
                                   },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0), 
                              child: ElevatedButton(
                                onPressed: () {
                                  // Redirect ke page pinjam buku
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookFormPage(
                                        id: snapshot.data![0][index].pk.toString(),
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  side: const BorderSide(color: Colors.black),
                                ),
                                child: const Text(
                                  'Borrow',
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0), 
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Tahun Publikasi:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${snapshot.data![0][index].fields.publicationYear}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Penerbit:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${snapshot.data![0][index].fields.publisher}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ISBN:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${snapshot.data![0][index].fields.isbn}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0), 
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: const Text(
                                    'User Review',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                MouseRegion(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewPage(
                                            bookName: snapshot.data![0][index].fields.title,
                                            imageUrl: snapshot.data![0][index].fields.imageUrlL,
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
                              ],
                            ),
                          ),
                          FutureBuilder(
                              future: fetchReview(),
                              builder: (context,
                                  AsyncSnapshot<List<Review>> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (snapshot.data == null ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 8),
                                          Text(
                                            "Tidak ada review.",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Silakan tambahkan review untuk buku ini.",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: snapshot.data![index]
                                                        .fields.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: List.generate(
                                                    snapshot.data![index].fields
                                                        .rating,
                                                    (index) => const Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(snapshot.data![index]
                                                    .fields.review),
                                              ],
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(snapshot
                                                        .data![index]
                                                        .fields
                                                        .name),
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children:
                                                              List.generate(
                                                            snapshot
                                                                .data![index]
                                                                .fields
                                                                .rating,
                                                            (index) =>
                                                                const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.orange,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(snapshot
                                                            .data![index]
                                                            .fields
                                                            .review),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Tutup'),
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
                              })
                        ],
                      ),
                    ));
          }
        },
      ),
    );
  }
}
