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

void userprofile(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/user_profile');
}

class Newsfeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              Feather.search,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => {},
          ),
        ],
      ),
      // bottomNavigationBar: Navigationbar(),
      body: SingleChildScrollView(
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
                          Container(
                            height: MediaQuery.of(context).size.height * 1 / 14,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () => userprofile(context),
                                  child: Text('Otin bin otin'),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 1 / 4,
                            width: double.infinity,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          "),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              right: 10,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Like my new selfie!'),
                                Spacer(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  // padding: EdgeInsets.only(left: 250),
                                  icon: Icon(
                                    MaterialIcons.favorite_border,
                                    size: 20,
                                  ),
                                  onPressed: () => {},
                                ),
                                Text('1K'),
                                IconButton(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  constraints: BoxConstraints(),
                                  // padding: EdgeInsets.only(left: 250),
                                  icon: Icon(
                                    Icons.comment,
                                    size: 20,
                                  ),
                                  onPressed: () => {},
                                ),
                                Text('5'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                          Container(
                            height: MediaQuery.of(context).size.height * 1 / 14,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Otin bin otin'),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.black,
                            height: MediaQuery.of(context).size.height * 1 / 4,
                            width: double.infinity,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          "),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              right: 10,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Like my new selfie!'),
                                Spacer(),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  // padding: EdgeInsets.only(left: 250),
                                  icon: Icon(
                                    MaterialIcons.favorite_border,
                                    size: 20,
                                  ),
                                  onPressed: () => {},
                                ),
                                Text('1K'),
                                IconButton(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  constraints: BoxConstraints(),
                                  // padding: EdgeInsets.only(left: 250),
                                  icon: Icon(
                                    Icons.comment,
                                    size: 20,
                                  ),
                                  onPressed: () => {},
                                ),
                                Text('5'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
