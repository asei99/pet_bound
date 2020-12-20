import 'package:Pet_Bound/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

void newsfeed(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/Home');
}

void pets(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets');
}

void event(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/event/place');
}

void profile(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/profile');
}

List imgList = [
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
];

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.all(3),
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () => newsfeed(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(
                  MaterialIcons.pets,
                  size: 25,
                ),
                onPressed: () => pets(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(
                  MaterialIcons.event,
                  size: 25,
                ),
                onPressed: () => event(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(MaterialIcons.person),
                onPressed: () => profile(context),
              )
            ],
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(237, 171, 172, 5),
        ),
        title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.data['username'] = null) {
              return Text('null');
            } else {
              return Text(snapshot.data['username']);
            }
          },
        ),
        // Text(
        //   'Otin bin otin',
        //   // textAlign: TextAlign.left,
        //   style:
        //       TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        // ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              MaterialCommunityIcons.logout,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              });
            },
          ),
        ],
      ),
      // bottomNavigationBar: Navigationbar(),
      // endDrawer: MainDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1 / 3.5,
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Image.network(
                      "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          ",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'asdgfjkhsadkfhskahfksdlhfksadhkflhsakfhskjdahfkjdsahkfldhsajkldfhjkshfkldsahfksadhfkdshkflashfhdasjklhlk'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                )),
                              ),
                              child: Center(
                                child: Text(
                                  ' 120\nPosts',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                )),
                              ),
                              child: Center(
                                child: Text(
                                  '       120\nFollowers',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              child: Center(
                                child: Text(
                                  '      120\nFollowing',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.height * 1 / 14,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          ),
                        ),

                        // color: Colors.grey,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'My Post',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8),
                          itemCount: imgList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 4,
                            child: Container(
                              // height: size.height,
                              color: Colors.grey,
                              child: Image.network(imgList[index]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
