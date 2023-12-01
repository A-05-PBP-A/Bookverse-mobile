import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile Page'),
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
                    decoration: BoxDecoration(
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
                      decoration: BoxDecoration(
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
                      decoration: BoxDecoration(
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
              SizedBox(height: 20),
              Text(
                'Irvan.Rizqy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'admin_bv@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: _buildInfoBoxWithButton(context, 'Buku'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildInfoBox('Review', '-'),
                        SizedBox(width: 20),
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          content == '-'
            ? Table(
                border: TableBorder.all(color: Color.fromARGB(255, 237, 174, 247)), // Change border color to light purple
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('Column 1', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('Column 2', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('Column 3', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.purple.withOpacity(0.1), // Light purple background
                        child: Text('-', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ],
              )
            : Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
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
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        ElevatedButton(
            onPressed: () {
              // Navigate to the form input page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormInputPage()),
              );
            },
            child: Text('Add Book'),
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
        title: Text('Form Input Page'),
      ),
      body: Center(
        child: Text('This is the Form Input Page'),
      ),
    );
  }
}