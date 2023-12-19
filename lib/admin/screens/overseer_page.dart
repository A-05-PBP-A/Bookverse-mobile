import 'package:bookverse_mobile/admin/screens/delete_book.dart';
import 'package:flutter/material.dart';
import 'package:bookverse_mobile/admin/screens/book_inputform.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 30,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    bottom: 0,
                    left: 12,
                    child: Container(
                      width: 96,
                      height: 55,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'BookVerse Admin Page',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    color: Colors.purple.shade50,
                    child: _buildInfoBoxWithButton(context, 'Buku'),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.purple.shade50,
                    child: _buildInfoBox('Review', '-'),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.purple.shade50,
                    child: _buildInfoBox('Users', ''),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildInfoBox(String label, String content) {
    return Container(
      width: 450,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
      color: Colors.grey,
      width: 2.0,
    ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          content == '-'
            ? Table(
                border: TableBorder.all(color: const Color.fromARGB(255, 237, 174, 247)),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('User', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('Book', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('Rating', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('Review', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('Delete', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1),
                        child: const Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
          Text(content),
        ],
      ),
    );
  }
}

Widget _buildInfoBoxWithButton(BuildContext context, String label) {
  return Container(
    width: 300,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(
      color: Colors.grey,
      width: 2.0,
    ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormInputPage()),
            );
          },
          child: const Text('Add Book'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeleteBookScreen()),
            );
          },
          child: const Text('Delete Book'),
        ),
      ],
    ),
  );
}