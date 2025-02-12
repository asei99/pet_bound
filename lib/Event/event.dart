import 'package:Pet_Bound/Widget/event_widget.dart';
import 'package:Pet_Bound/Widget/place_widget.dart';

import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void contestdetail(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('event/contest_detail');
}

void placedetail(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('event/place_detail');
}

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  int selectedIndex = 0;
  static List<String> tabList = ['Event', 'Place'];
  bool loading = false;
  List<Eventwidget> contestList = [];
  List<Eventplacewidget> placeList = [];

  // List<Post> placeList = [];

  @override
  void initState() {
    super.initState();
    getAllContestPosts();
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget contest() {
    // return Text(contestList.toString());

    return Column(
      children: contestList,
    );
  }

  Widget place() {
    // return Text(contestList.toString());
    return Column(
      children: placeList,
    );
  }

  Widget tabView(String txt, int index) {
    return GestureDetector(
      onTap: () => changeIndex(index),
      child: Container(
        decoration: BoxDecoration(
          border: selectedIndex == index
              ? Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(237, 171, 172, 40),
                  ),
                )
              : Border.all(color: Color.fromRGBO(237, 171, 172, 0)),
        ),
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // color: Colors.blue,
            fontFamily: 'acme',
          ),
        ),
      ),
    );
  }

  getAllContestPosts() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot =
        await eventRefrence.doc("contest").collection("contestitem").get();
    QuerySnapshot querySnapshot1 =
        await eventRefrence.doc("place").collection("placeitem").get();
    if (mounted) {
      setState(() {
        loading = false;
        contestList =
            querySnapshot.docs.map((e) => Eventwidget.fromDocument(e)).toList();
        placeList = querySnapshot1.docs
            .map((e) => Eventplacewidget.fromDocument(e))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (loading == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: size.height * 1 / 14,
        title: GestureDetector(
          onDoubleTap: () => getAllContestPosts(),
          child: Container(
            child: Text(
              'Events',
              style: TextStyle(
                  fontFamily: 'acme', fontSize: 25, color: Colors.black),
            ),
          ),
        ),
      ),
      body: loading == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: CircularProgressIndicator()),
              ],
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(237, 171, 172, 0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          tabView(tabList[0], 0),
                          // SizedBox(width: 80,)
                          tabView(tabList[1], 1),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: selectedIndex == 0 ? contest() : place(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
