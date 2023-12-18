import 'dart:convert';
import 'package:bookverse_mobile/main.dart';
import 'package:bookverse_mobile/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16,top: 25, right: 16),
        child :GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
            child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0,10)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            userProvider.image.isNotEmpty
                                ? userProvider.image
                                : 'assets/images/defaultProfile.png',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: Icon(Icons.edit, color: Colors.white,),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: userProvider.username,
                  hintStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Bio",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: userProvider.bio,
                  hintStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async{
                    String newUsername = usernameController.text;
                    String bio = bioController.text;

                    //kalau tidak ada input username
                    if (bio != userProvider.bio && newUsername.isEmpty){
                        final response = await request.postJson(
                          "https://bookverse-a05-tk.pbp.cs.ui.ac.id/edit-profile-flutter/${userProvider.username}/",
                          jsonEncode(<String, String>{
                            'username_baru': userProvider.username,
                            'bio': bio,
                          }));

                        if (response['status'] == 'success') {
                          //Update data user di flutter
                          userProvider.setLoggedInUser(
                            DjangoUser(username: userProvider.username),
                            ProfileDetails(user: DjangoUser(username: userProvider.username), bio: bio),
                          );

                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => const MyNavBar()),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile Updated"),
                          ));
                        }
                    }
                    else{
                        final response = await request.postJson(
                          "https://bookverse-a05-tk.pbp.cs.ui.ac.id/edit-profile-flutter/${userProvider.username}/",
                          jsonEncode(<String, String>{
                            'username_baru': newUsername,
                            'bio': bio,
                          }));

                        if (response['status'] == 'success') {
                          //Update data user flutter
                          userProvider.setLoggedInUser(
                            DjangoUser(username: newUsername),
                            ProfileDetails(user: DjangoUser(username: newUsername), bio: bio),
                          );

                          Navigator.pop(context); 

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyNavBar()),
                          );
                          
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile Updated"),
                          ));
                        }
                    }
                  },
                  child: Text("Save", style: TextStyle(fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
                ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}