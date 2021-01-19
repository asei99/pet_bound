import 'package:Pet_Bound/Model/m_user.dart';
import 'package:Pet_Bound/Widget/post_widget.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:Pet_Bound/socialmedia/notification_page.dart';
import 'package:Pet_Bound/socialmedia/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

void userprofile(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/user_profile');
}

void searchscreen(BuildContext ctx) {
  Navigator.push(
    ctx,
    MaterialPageRoute(
      builder: (context) => Searchscreen(),
    ),
  );
}

class Newsfeed extends StatefulWidget {
  final Users currentUser;

  Newsfeed({this.currentUser});
  @override
  _NewsfeedState createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  List<Post> posts;
  List<String> followingsList = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    retrieveTimeLine();
    retrieveFollowings();
    print("timeline init success");
  }

  retrieveTimeLine() async {
    QuerySnapshot querySnapshot = await timelineRefrence
        .doc(widget.currentUser.id)
        .collection("timelinePosts")
        .orderBy("timestamp", descending: true)
        .get();

    List<Post> allPosts = querySnapshot.docs
        .map((document) => Post.fromDocument(document))
        .toList();

    setState(() {
      this.posts = allPosts;
    });
  }

  retrieveFollowings() async {
    QuerySnapshot querySnapshot = await followingReference
        .doc(currentUser.id)
        .collection("userFollowing")
        .get();

    setState(() {
      followingsList =
          querySnapshot.docs.map((document) => document.id).toList();
    });
  }

  createUserTimeLine() {
    if (posts == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    } else {
      return ListView(
        children: posts,
      );
    }
  }

  displayNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          'Timeline',
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Entypo.camera,
        //     color: Color.fromRGBO(237, 171, 172, 5),
        //   ),
        //   onPressed: () => {},
        // ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(
              Feather.heart,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => displayNotification(),
          ),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              Feather.search,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => searchscreen(context),
          ),
        ],
      ),
      // bottomNavigationBar: Navigationbar(),
      body:
          // Text(posts.toString())
          RefreshIndicator(
        child: createUserTimeLine(),
        onRefresh: () => retrieveTimeLine(),
      ),
    );
  }
}
