import 'package:Pet_Bound/Model/m_user.dart';
import 'package:Pet_Bound/Widget/pet_tile_widget.dart';
import 'package:Pet_Bound/Widget/pet_widget.dart';
import 'package:Pet_Bound/Widget/post_tile_widget.dart';
import 'package:Pet_Bound/Widget/post_widget.dart';

import 'package:Pet_Bound/socialmedia/edit_profile.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  final String userProfileId;

  Profile({this.userProfileId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName;
  bool loading = false;
  int countPost = 0;
  List<Petwidget> petsList = [];
  List<Post> postsList = [];
  static List<String> tabList = ['Post', 'Pet'];
  int selectedIndex = 0;
  int countTotalFollowers = 0;
  int countTotalFollowings = 0;
  bool following = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => getAllProfilePosts(context));
    // SchedulerBinding.instance
    // .addPostFrameCallback((timeStamp) => {getAllProfilePosts(context)});
    getAllProfilePets();
    getAllProfilePosts();
    getAllFollowers();
    getAllFollowings();
    checkIfAlreadyFollowing();
  }

  getAllFollowings() async {
    QuerySnapshot querySnapshot = await followingReference
        .doc(widget.userProfileId)
        .collection("userFollowing")
        .get();

    setState(() {
      countTotalFollowings = querySnapshot.docs.length;
    });
  }

  checkIfAlreadyFollowing() async {
    DocumentSnapshot documentSnapshot = await followersReference
        .doc(widget.userProfileId)
        .collection("userFollowers")
        .doc(currentUser.id)
        .get();

    setState(() {
      following = documentSnapshot.exists;
    });
  }

  getAllFollowers() async {
    QuerySnapshot querySnapshot = await followersReference
        .doc(widget.userProfileId)
        .collection("userFollowers")
        .get();

    setState(() {
      countTotalFollowers = querySnapshot.docs.length;
    });
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  editUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editprofile()),
    );
  }

  Container createButtonTitleAndFunction(
      {String title, Function performFunction}) {
    return Container(
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          margin: EdgeInsets.only(top: 180),
          // alignment: Alignment.bottomRight,
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }

  createButton() {
    bool ownProfile = currentUser.id == widget.userProfileId;
    if (ownProfile) {
      return createButtonTitleAndFunction(
        title: "Edit Profile",
        performFunction: editUserProfile,
      );
    } else if (following) {
      return createButtonTitleAndFunction(
        title: "Unfollow",
        performFunction: controlUnfollowUser,
      );
    } else if (!following) {
      return createButtonTitleAndFunction(
        title: "Follow",
        performFunction: controlFollowUser,
      );
    }
  }

  controlUnfollowUser() {
    setState(() {
      following = false;
    });

    followersReference
        .doc(widget.userProfileId)
        .collection("userFollowers")
        .doc(currentUser.id)
        .get()
        .then((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });
    followingReference
        .doc(currentUser.id)
        .collection("userFollowing")
        .doc(widget.userProfileId)
        .get()
        .then((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });

    activityFeedReference
        .doc(widget.userProfileId)
        .collection("feedItems")
        .doc(currentUser.id)
        .get()
        .then((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });
    setState(() {
      getAllFollowers();
    });
  }

  controlFollowUser() {
    setState(() {
      following = true;
    });

    followersReference
        .doc(widget.userProfileId)
        .collection("userFollowers")
        .doc(currentUser.id)
        .set({});

    followingReference
        .doc(currentUser.id)
        .collection("userFollowing")
        .doc(widget.userProfileId)
        .set({});

    activityFeedReference
        .doc(widget.userProfileId)
        .collection("feedItems")
        .doc(currentUser.id)
        .set({
      "type": "follow",
      "ownerId": widget.userProfileId,
      "username": currentUser.userName,
      "timestamp": DateTime.now(),
      "userProfileImg": currentUser.image,
      "userId": currentUser.id,
    });
    setState(() {
      getAllFollowers();
    });
  }

  List petList = [
    'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
    'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
    'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
    'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
    'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  ];

  Widget pet() {
    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    } else if (postsList.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('no data found'),
          ],
        ),
      );
    }
    List<GridTile> gridTileList = [];
    petsList.forEach((eachPost) {
      gridTileList.add(GridTile(
          child: PetTile(
        pet: eachPost,
        userName: userName,
      )));
    });
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTileList);
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
                      color: Color.fromRGBO(237, 171, 172, 5),
                    ),
                  )
                : Border(
                    bottom: BorderSide(width: 2, color: Colors.grey),
                  )),
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 25,

            // color: Colors.blue,
            fontFamily: 'lato',
          ),
        ),
      ),
    );
  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await postsReference
        .doc(widget.userProfileId)
        .collection("usersPosts")
        .orderBy("timestamp", descending: true)
        .get();

    setState(() {
      loading = false;
      countPost = querySnapshot.docs.length;
      postsList = querySnapshot.docs
          .map((documentSnapshot) => Post.fromDocument(documentSnapshot))
          .toList();
    });
  }

  getAllProfilePets() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await petRefrence
        .doc(widget.userProfileId)
        .collection("usersPets")
        .get();

    setState(() {
      loading = false;
      petsList = querySnapshot.docs
          .map((documentSnapshot) => Petwidget.fromDocument(documentSnapshot))
          .toList();
    });
  }

  Widget post() {
    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    } else if (postsList.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('no data found'),
          ],
        ),
      );
    }
    List<GridTile> gridTileList = [];
    postsList.forEach((eachPost) {
      gridTileList.add(GridTile(child: PostTile(eachPost)));
    });
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTileList);
  }

  @override
  Widget build(BuildContext context) {
    bool ownProfile = currentUser.id == widget.userProfileId;

    Size size = MediaQuery.of(context).size;
    createProfileTop() {
      return StreamBuilder(
          stream: usersReference.doc(widget.userProfileId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: CircularProgressIndicator()),
                ],
              );
            }
            Users user = Users.fromDocument(dataSnapshot.data);
            userName = user.userName;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 200,
                        //  MediaQuery.of(context).size.height * 1 / 3.5,
                        // color: Colors.grey,
                        width: double.infinity,
                        child: user.image == ""
                            ? Center(
                                child: Text(
                                'no image yet',
                                style:
                                    TextStyle(fontSize: 30, color: Colors.grey),
                              ))
                            : Image.network(
                                user.image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: createButton(),
                    )
                  ],
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
                      Text(user.bio),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$countPost',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'posts',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$countTotalFollowings',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Followings',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$countTotalFollowers',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 15,
                ),
              ],
            );
          });
    }

    void back(BuildContext ctx) {
      Navigator.of(ctx).pop();
    }

    createHeader() {
      return StreamBuilder(
          stream: usersReference.doc(widget.userProfileId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return CircularProgressIndicator();
            }
            Users user = Users.fromDocument(dataSnapshot.data);
            bool ownProfile = currentUser.id == widget.userProfileId;
            return Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
              height: MediaQuery.of(context).size.height * 1 / 14,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ], color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onDoubleTap: () => getAllProfilePosts(),
                    child: Container(
                      child: Text(
                        // user.userName,
                        user.userName,
                        style: TextStyle(
                            fontFamily: 'acme',
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  ownProfile
                      ? IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            MaterialCommunityIcons.logout,
                            color: Color.fromRGBO(237, 171, 172, 5),
                          ),
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((res) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mainmain()),
                              );
                            });
                          },
                        )
                      : IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            MaterialIcons.arrow_back,
                            color: Color.fromRGBO(237, 171, 172, 5),
                            size: 25,
                            // size: 30,
                          ),
                          onPressed: () => back(context),
                        ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createHeader(),
                SizedBox(
                  height: 1,
                ),
                createProfileTop(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            !ownProfile
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      tabView(tabList[0], 0),
                                      // SizedBox(width: 80,)
                                      tabView(tabList[1], 1),
                                    ],
                                  )
                                : GestureDetector(
                                    onDoubleTap: () => getAllProfilePosts(),
                                    child: Container(
                                      height: size.height * 1 / 14,
                                      decoration: BoxDecoration(
                                        // color: Colors.blue,
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  237, 171, 172, 5)),
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
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 250,
                              child: selectedIndex == 0 ? post() : pet(),
                            ),
                          ],
                        ),
                      )
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
