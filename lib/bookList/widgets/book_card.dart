// import 'package:bookverse_mobile/book_profile/screens/profile_book.dart';
// import 'package:flutter/material.dart';

// class BookItem {
//   final String title;
//   final String yearPublished;
//   final String publisher;

//   BookItem(this.title, this.yearPublished, this.publisher);
// }

// class BookCard extends StatelessWidget {
//   final BookItem item;

//   const BookCard(this.item, {super.key}); // Constructor

//   @override
//   Widget build(BuildContext context) {
//     //final request = context.watch<CookieRequest>();
//     return Material(
//       color: Colors.indigo,
//       child: InkWell(
//         // Area responsive terhadap sentuhan
//         onTap: () async {
//           // Memunculkan SnackBar ketika diklik
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(
//                 SnackBar(content: Text("Kamu memilih buku ${item.title}!")));

//           // ini ya buat ganti pagenya
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const BookPage()));
//         },
//         child: Container(
//           // Container untuk menyimpan Icon dan Text
//           padding: const EdgeInsets.all(8),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Icon(
//                 //   item.icon,
//                 //   color: Colors.white,
//                 //   size: 30.0,
//                 // ),
//                 // const Padding(padding: EdgeInsets.all(3)),
//                 Text(
//                   item.title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 const Padding(padding: EdgeInsets.all(3)),
//                 Text(
//                   item.yearPublished,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 const Padding(padding: EdgeInsets.all(3)),
//                 Text(
//                   item.publisher,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
