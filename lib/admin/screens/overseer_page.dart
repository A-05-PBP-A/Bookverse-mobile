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
              SizedBox(height: 30),
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
                      height: 55,
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
                'Irvan.Rizqy', //Username
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'BookVerse Admin Page',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    color: Colors.purple.shade50,
                    child: _buildInfoBoxWithButton(context, 'Buku'),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: [
                      Container(
                        color: Colors.purple.shade50,
                        child: _buildInfoBox('Review', '-'),
                      ),
                      Container(
                        color: Colors.purple.shade50,
                        child: _buildInfoBox('Users', ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
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
      width: 450,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
      color: Colors.grey,
      width: 2.0, // Set the border width to make it thicker
    ),
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
      border: Border.all(
      color: Colors.grey,
      width: 2.0, // Set the border width to make it thicker
    ),
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