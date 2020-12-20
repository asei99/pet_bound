// // import 'package:Pet_Bound/main_drawer.dart';
// // import 'package:Pet_Bound/socialmedia/pets_detail.dart';
// import 'package:Pet_Bound/socialmedia/post.dart';
// import 'package:Pet_Bound/socialmedia/profile.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_icons/flutter_icons.dart';
// import './newsfeed.dart';
// import '../Event/event.dart';
// import 'pets.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// class Socialmedia extends StatefulWidget {
//   @override
//   _SocialmediaState createState() => _SocialmediaState();
// }

// class _SocialmediaState extends State<Socialmedia> {
//   PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//   // int i = 0;
//   // var pages = [
//   //     Newsfeed(),
//   //     Pets(),
//   //     Post(),
//   //     Event(),
//   //     Profile(),
//   // ];
//   // List<Widget> _navScreens() {
//   //   return [
//   //     Newsfeed(),
//   //     Pets(),
//   //     Post(),
//   //     Event(),
//   //     Profile(),
//   //     // Detailpet(),
//   //   ];
//   // }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColor: CupertinoColors.activeBlue,
//         inactiveColor: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.favorite),
//         title: ("OFFERS"),
//         activeColor: CupertinoColors.activeGreen,
//         inactiveColor: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person_pin),
//         title: ("Help"),
//         activeColor: CupertinoColors.systemRed,
//         inactiveColor: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.local_activity),
//         title: ("ProfileScreen"),
//         activeColor: CupertinoColors.systemIndigo,
//         inactiveColor: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.verified_user),
//         title: ("Cart"),
//         activeColor: CupertinoColors.systemIndigo,
//         inactiveColor: CupertinoColors.systemGrey,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: PersistentTabView(
//         controller: _controller,
//         // screens: _NavScreens(),
//         items: _navBarsItems(),
//         confineInSafeArea: true,
//         backgroundColor: Colors.white,
//         handleAndroidBackButtonPress: true,
//         resizeToAvoidBottomInset: true,
//         hideNavigationBarWhenKeyboardShows: true,
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         navBarStyle: NavBarStyle.style9,
//       ),
//     );
//   }
// }
