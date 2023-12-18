import 'package:bookverse_mobile/auth/screens/login.dart';
import 'package:bookverse_mobile/auth/screens/register.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Text
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Description Text
            Text(
              'Siapkah kalian menjelajah dunia literasi tak terbatas bersama Bookverse?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32.0),
            // Logo Image
            Expanded(
              child: Center(
                child: Image.network(
                  'https://media.discordapp.net/attachments/1073225472974016614/1167847329282404382/8eea6ccf-0c34-495c-865f-ecee259e3c4d-removebg.png?ex=65903714&is=657dc214&hm=20caeb1404a69b1992cd1a0a5a506c4e54c4edaeae1459d04870d07e19cf9360&=&format=webp&quality=lossless',
                  height: 300.0,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            // Button to Login and Register
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                   Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: Colors.black, width: 0.5),
                  ), backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), 
                    side: BorderSide(color: Colors.black, width: 0.5),
                  ), backgroundColor: Colors.red, 
                  padding:  EdgeInsets.symmetric(vertical: 25.0),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    ), 
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
