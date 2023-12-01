import 'package:flutter/material.dart';
import 'package:bookverse_mobile/screens/borrow.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:cakestock/models/item.dart';
// import 'package:cakestock/screens/detail_item.dart';
// import 'package:cakestock/widgets/left_drawer.dart';
// import 'package:cakestock/screens/user_item.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class BorrowingPage extends StatefulWidget {
  const BorrowingPage({Key? key}) : super(key: key);

  @override
  _BorrowingPageState createState() => _BorrowingPageState();
}

class _BorrowingPageState extends State<BorrowingPage> {
  // Future<List<Item>> fetchProduct() async {
  //   var url = Uri.parse('https://bookverse-a05-tk.pbp.cs.ui.ac.id/books/');
  //   var response = await http.get(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //   );

  //   // melakukan decode response menjadi bentuk json
  //   var data = jsonDecode(utf8.decode(response.bodyBytes));

  //   // melakukan konversi data json menjadi object Product
  //   List<Item> list_product = [];
  //   for (var d in data) {
  //     if (d != null) {
  //       list_product.add(Item.fromJson(d));
  //     }
  //   }
  //   return list_product;
  // }

  @override
  Widget build(BuildContext context) {
    //final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
            title: const Text('My Borrowing(s)'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookFormPage()),
                      );
                    },
                  )),
            ]),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.0), // Atur jarak kiri dan kanan halaman
          child: MyCardList(),
        ));
  }
}

class MyCardList extends StatelessWidget {
  final List<String> items = [
    'Classical Mythology',
    'Clara Callan',
    'The Middle Stories',
    'The Mummies of Urumchi'
  ];
  final List<String> covers = [
    'http://images.amazon.com/images/P/0195153448.01.MZZZZZZZ.jpg',
    'http://images.amazon.com/images/P/0002005018.01.MZZZZZZZ.jpg',
    'http://images.amazon.com/images/P/0887841740.01.MZZZZZZZ.jpg',
    'http://images.amazon.com/images/P/0393045218.01.MZZZZZZZ.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18.0,
          width: 18.0,
        ),
        Expanded(
            child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of cards per row
            crossAxisSpacing: 8.0, // Spacing between cards horizontally
            mainAxisSpacing: 8.0,
          ), // Spacing between cards vertically
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      Flexible(
                          child:
                              Image.network(covers[index], fit: BoxFit.cover)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(items[index]),
                      ),
                    ])));
          },
        ))
      ],
    );
  }
}
