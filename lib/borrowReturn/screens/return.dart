import 'package:flutter/material.dart';
import 'package:bookverse_mobile/borrowReturn/screens/borrow.dart';
import 'package:bookverse_mobile/borrowReturn/widgets/searchbar.dart';

class BorrowingPage extends StatefulWidget {
  const BorrowingPage({Key? key}) : super(key: key);

  @override
  _BorrowingPageState createState() => _BorrowingPageState();
}

class _BorrowingPageState extends State<BorrowingPage> {
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
          height: 25.0,
          width: 18.0,
        ),
        MySearchBar(),
        SizedBox(
          height: 25.0,
          width: 18.0,
        ),
        Expanded(
            child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of cards per row
            crossAxisSpacing: 20.0, // Spacing between cards horizontally
            mainAxisSpacing: 8.0,
          ), // Spacing between cards vertically
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  //TODO:ganti OtherPage dengan halaman detail buku
                  // Handle navigation here
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OtherPage(),
                  //   ),
                  // );
                },
                child: Card(
                    child: Column(
                  // crossAxisAlignment: CrossAxisAlignment
                  //     .stretch, // Memastikan bahwa child Column memenuhi lebar card
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                        child: Image.network(covers[index], fit: BoxFit.cover)),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          items[index],
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Return Book'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Are you sure you want to return this book?')
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              }),
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: const Text('Return',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ),
                        ))
                  ],
                )));
          },
        ))
      ],
    );
  }
}
