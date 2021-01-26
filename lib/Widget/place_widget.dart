import 'package:Pet_Bound/Model/m_event.dart';
import 'package:Pet_Bound/socialmedia/event_place.dart';

import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Eventplacewidget extends StatefulWidget {
  final String contestId;
  final String title;
  final dynamic likes;
  final String storename;
  final String description1;
  final String description2;
  final String url;
  final dynamic category;
  final String storeurl;

  Eventplacewidget({
    this.category,
    this.contestId,
    this.likes,
    this.title,
    this.storename,
    this.description1,
    this.description2,
    this.url,
    this.storeurl,
  });

  factory Eventplacewidget.fromDocument(DocumentSnapshot doc) {
    return Eventplacewidget(
      contestId: doc.id,
      likes: doc.data()["likes"],
      title: doc.data()["title"],
      storename: doc.data()["storename"],
      description1: doc.data()["description1"],
      description2: doc.data()["description2"],
      url: doc.data()["image"],
      category: doc.data()["category"],
      storeurl: doc.data()["storeurl"],
    );
  }
  @override
  _EventplacewidgetState createState() => _EventplacewidgetState(
        contestId: this.contestId,
        likes: this.likes,
        title: this.title,
        storename: this.storename,
        description1: this.description1,
        description2: this.description2,
        url: this.url,
        category: this.category,
        storeurl: this.storeurl,
      );
}

class _EventplacewidgetState extends State<Eventplacewidget> {
  Map category;
  final String contestId;
  final String title;
  Map likes;
  final String storename;
  final String description1;
  final String description2;
  final String url;
  final String storeurl;
  bool isLiked;
  bool showHeart = false;
  final String currentOnlineUserId = currentUser?.id;

  _EventplacewidgetState({
    this.storeurl,
    this.category,
    this.contestId,
    this.likes,
    this.title,
    this.storename,
    this.description1,
    this.description2,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // isLiked = (likes[currentOnlineUserId] == true);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1 / 2.6,
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        createPostHeader(),
                        createPostPicture(),
                        createPostFooter(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  createPostHeader() {
    return FutureBuilder(
      future: eventRefrence
          .doc("place")
          .collection("placeitem")
          .doc(contestId)
          .get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return CircularProgressIndicator();
        }
        Events events = Events.fromDocument(dataSnapshot.data);

        return Container(
          height: MediaQuery.of(context).size.height * 1 / 14,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(storeurl),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () =>
                    //     displayUserProfile(context, userProfileId: user.id),
                    // child: Text(user.userName),
                    {},
                child: Text(events.storeName),
              )
            ],
          ),
        );
      },
    );
  }

  createPostPicture() {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height * 1 / 4,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => displayFullPost(context),
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  displayFullPost(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventPlaceScreenPage(
                  contestId: contestId,
                )));
  }

  createPostFooter() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 12,
        right: 10,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
