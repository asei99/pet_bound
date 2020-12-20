import 'package:Pet_Bound/socialmedia/pets_detail.dart';
import 'package:Pet_Bound/socialmedia/post.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './newsfeed.dart';
import '../Event/event.dart';
import 'pets.dart';

class Socialmedia extends StatefulWidget {
  @override
  _SocialmediaState createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  // PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);
  int i = 0;
  var pages = [
    Newsfeed(),
    Pets(),
    Detailpet(),
    Post(),
    Event(),
  ];
//Screens for each nav items.
  // List<Widget> _NavScreens() {
  //   return [
  //     Newsfeed(),
  //     Pets(),
  //     Post(),
  //     Event(),
  //     Profile(),
  //     // Detailpet(),
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home),
  //       title: ("Home"),
  //       activeColor: CupertinoColors.activeBlue,
  //       inactiveColor: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.favorite),
  //       title: ("OFFERS"),
  //       activeColor: CupertinoColors.activeGreen,
  //       inactiveColor: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.person_pin),
  //       title: ("Help"),
  //       activeColor: CupertinoColors.systemRed,
  //       inactiveColor: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.local_activity),
  //       title: ("ProfileScreen"),
  //       activeColor: CupertinoColors.systemIndigo,
  //       inactiveColor: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.verified_user),
  //       title: ("Cart"),
  //       activeColor: CupertinoColors.systemIndigo,
  //       inactiveColor: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pages[i],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.photo_library),
            title: new Text('Blog'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.book),
            title: new Text('Library'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Notifications'),
          ),
        ],
        currentIndex: i,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
      ),
    );
  }
}
