import 'package:flutter/material.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
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
                      height: 48,
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
              const SizedBox(height: 20),
              const Text(
                'Irvan.Rizqy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'admin_bv@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: _buildInfoBoxWithButton(context, 'Buku'),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildInfoBox('Review', '-'),
                        const SizedBox(width: 20),
                        _buildInfoBox('Users', ''),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildInfoBox(String label, String content) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
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
                border: TableBorder.all(color: const Color.fromARGB(255, 237, 174, 247)), // Change border color to light purple
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('Column 1', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('Column 2', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: const Text('Column 3', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
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
                  TableRow(
                    children: [
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
                  TableRow(
                    children: [
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
                  TableRow(
                    children: [
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
      border: Border.all(color: Colors.grey),
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
              // Navigate to the form input page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormInputPage()),
              );
            },
            child: const Text('Add Book'),
          ),

      ],
    ),
  );
}

class FormInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input Page'),
      ),
      body: const Center(
        child: Text('This is the Form Input Page'),
      ),
    );
  }
}