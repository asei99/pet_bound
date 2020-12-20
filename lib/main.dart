import 'package:Pet_Bound/Event/event.dart';
import 'package:Pet_Bound/Event/event_detail.dart';
import 'package:Pet_Bound/Event/place_detail.dart';

import 'package:Pet_Bound/auth_screen.dart';
import 'package:Pet_Bound/socialmedia/create_pets.dart';
import 'package:Pet_Bound/socialmedia/create_post.dart';
import 'package:Pet_Bound/socialmedia/edit_pets.dart';
import 'package:Pet_Bound/socialmedia/newsfeed.dart';
import 'package:Pet_Bound/socialmedia/pets.dart';
import 'package:Pet_Bound/socialmedia/pets_detail.dart';
import 'package:Pet_Bound/socialmedia/post.dart';
import 'package:Pet_Bound/socialmedia/profile.dart';
import 'package:Pet_Bound/socialmedia/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './socialmedia/HalamanUtama.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget getLandingPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Profile();
        }
        {
          return AuthScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthScreen(),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (ctx, userSnapshot) {
      //     if (userSnapshot.hasData) {
      //       return Newsfeed();
      //     } else {
      //       return AuthScreen();
      //     }
      //   },
      // ),

      routes: {
        '/login': (ctx) => AuthScreen(),
        '/socialmedia/Home': (ctx) => Newsfeed(),
        '/socialmedia': (ctx) => Socialmedia(),
        '/socialmedia/post': (ctx) => Post(),
        '/socialmedia/pets': (ctx) => Pets(),
        '/event/place': (ctx) => Event(),
        '/socialmedia/post/create_post': (ctx) => Createpost(),
        '/socialmedia/pets/create_pets': (ctx) => Createpets(),
        '/socialmedia/pets/edit_pets': (ctx) => Editpets(),
        '/socialmedia/pets/detail_pets': (ctx) => Detailpet(),
        '/socialmedia/profile': (ctx) => Profile(),
        '/socialmedia/user_profile': (ctx) => Userprofile(),
        'event/contest_detail': (ctx) => Eventdetail(),
        'event/place_detail': (ctx) => Placedetail(),
      },
    );
  }
}
