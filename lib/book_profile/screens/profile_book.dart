import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
    const BookPage({Key? key}) : super(key: key);

    @override
    _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  bool _isHovering = false;
  bool _isHoveringSee = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Judul Buku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
            Container(
                height: 500, 
                child: Center(
                  child: Image.network(
                    'https://dummyimage.com/400x600/000/fff&text=Sampul+Buku', // Ganti dengan URL gambar sampul buku 
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Judul Buku', // Ganti dengan judul buku 
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              'Penulis Buku', // Ganti dengan nama penulis buku 
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  onEnter: (event) => setState(() => _isHovering = true),
                  onExit: (event) => setState(() => _isHovering = false),
                  child: Opacity(
                    opacity: _isHovering ? 0.3 : 1.0,
                    child: InkWell(
                      onTap: () {
                        // Redirect ke page review
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                              SizedBox(width: 5),
                              Icon(Icons.star, color: Colors.grey, size: 22.0),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            '0 Ratings', // Dummy total reviews
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Fungsi favorit
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  // Redirect ke page pinjam buku
                },
                child: Text(
                  'Pinjam',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            SizedBox(height: 15),
              Text(
              'Tahun Publikasi:', 
                  style: TextStyle(fontSize: 18),
                ),
                
                Text(
                  '2023', // Ganti dengan tahun publikasi buku 
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Penerbit:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Penerbit Buku', // Ganti dengan nama penerbit buku 
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'ISBN:', 
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '123-456-789', // Ganti dengan ISBN buku 
                  style: TextStyle(fontSize: 18),
                ),
            SizedBox(height: 15),
            Container(
              width: 400,
              child: Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
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
                        // Redirect ke page review
                      },
                      child: Column(
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
          ],
          ),
        ),
      ),
    );
  }
}
