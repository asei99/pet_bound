// import 'package:Pet_Bound/socialmedia/pets.dart';

// import 'package:Pet_Bound/socialmedia/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

void post(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/post');
}

void utama(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia');
}

void pets(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets');
}

void login(BuildContext ctx) {
  Navigator.of(ctx).pushNamed('/login');
}

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1 / 1.5,
      child: Drawer(
        elevation: 2,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     // begin: Alignment.centerLeft,
              //     // end: Alignment.centerRight,
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       const Color.fromRGBO(0, 64, 225, 1),
              //       const Color.fromRGBO(0, 225, 225, 1),
              //     ],
              //   ),
              // ),
              color: Color.fromRGBO(78, 180, 246, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Otin bin Otin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(height: size.height * 1 / 1.7),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            MaterialCommunityIcons.logout,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () => FirebaseAuth.instance.signOut(),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15.0)),
                        Container(
                          // padding: EdgeInsets.only(top: 15),
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
