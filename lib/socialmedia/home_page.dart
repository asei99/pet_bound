import 'package:Pet_Bound/auth_form.dart';

import 'package:Pet_Bound/socialmedia/profile.dart';
import 'package:Pet_Bound/socialmedia/upload_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'newsfeed.dart';
import '../Event/event.dart';
import 'package:Pet_Bound/socialmedia/pets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/m_user.dart';

Users currentUser;
final usersReference = FirebaseFirestore.instance.collection("users");
final postsReference = FirebaseFirestore.instance.collection("posts");
final activityFeedReference = FirebaseFirestore.instance.collection("feed");
final commentsReference = FirebaseFirestore.instance.collection("comments");
final followersReference = FirebaseFirestore.instance.collection("followers");
final followingReference = FirebaseFirestore.instance.collection("following");
final timelineRefrence = FirebaseFirestore.instance.collection("timeline");
final eventRefrence = FirebaseFirestore.instance.collection("events");
final petRefrence = FirebaseFirestore.instance.collection("pets");
final _scaffoldKey = GlobalKey<ScaffoldState>();
PageController pageController;
final DateTime timestamp = DateTime.now();

class Mainmain extends StatefulWidget {
  @override
  _MainmainState createState() => _MainmainState();
}

class _MainmainState extends State<Mainmain> {
  int getPageIndex = 0;
  bool isSignedIn = false;

  final auth = FirebaseAuth.instance;
  var isLoading = false;

  void initState() {
    super.initState();

    pageController = PageController();
  }

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        DocumentSnapshot documentSnapshot = await usersReference
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get();

        currentUser = Users.fromDocument(documentSnapshot);
        setState(() {
          isSignedIn = true;
        });
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'bio': '',
          'id': authResult.user.uid,
          'image': '',
        });
        DocumentSnapshot documentSnapshot = await usersReference
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get();

        currentUser = Users.fromDocument(documentSnapshot);

        setState(() {
          isSignedIn = true;
        });
      }

      print(currentUser.userName);
      print('hi');
      print(currentUser.id);
    } on PlatformException catch (err) {
      var message = 'please check your email or password';
      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      var message = 'please check your email or password';
      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
    // await followersReference
    //     .doc(currentUser.id)
    //     .collection("userFollowers")
    //     .doc(currentUser.id)
    //     .set({});

    // currentUser = User.
  }

  goUpload() {
    setState(() {
      onTapChangePage(2);
    });
  }

  goNewsFeed() {
    setState(() {
      onTapChangePage(0);
    });
  }

  goPet() {
    setState(() {
      onTapChangePage(1);
    });
  }

  goProfile() {
    onTapChangePage(4);
    // setState(() {
    //   currentIndex = 4;
    // });
  }

  goEvent() {
    setState(() {
      onTapChangePage(3);
    });
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    );
  }

  Scaffold buildHomeScreen() {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          Newsfeed(
            currentUser: currentUser,
          ),
          Pets(userPetId: currentUser.id),
          UploadPage(),
          Event(),
          Profile(
            userProfileId: currentUser?.id,
          ),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: keyboardIsOpened
          ? null
          : Container(
              padding: EdgeInsets.all(3),
              height: 65.0,
              width: 65.0,
              child: FittedBox(
                child: FloatingActionButton(
                  // backgroundColor: Color.fromRGBO(237, 171, 172, 5),
                  heroTag: null,
                  onPressed: () => goUpload(),
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
                color: getPageIndex == 0
                    ? Color.fromRGBO(237, 171, 172, 5)
                    //  Colors.blue
                    : Colors.black,
                icon: Icon(Icons.home),
                onPressed: () => goNewsFeed(),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(
                  MaterialIcons.pets,
                  size: 25,
                  color: getPageIndex == 1
                      ? Color.fromRGBO(237, 171, 172, 5)
                      //  Colors.blue
                      : Colors.black,
                ),
                onPressed: () => goPet(),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                color: getPageIndex == 3
                    ? Color.fromRGBO(237, 171, 172, 5)
                    //  Colors.blue
                    : Colors.black,
                icon: Icon(
                  MaterialIcons.event,
                  size: 25,
                ),
                onPressed: () => goEvent(),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(MaterialIcons.person),
                color: getPageIndex == 4
                    ? Color.fromRGBO(237, 171, 172, 5)
                    //  Colors.blue
                    : Colors.black,
                onPressed: () => goProfile(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // resizeToAvoidBottomPadding: false,

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(
          _submitAuthForm,
          isLoading,
        ),
      );
    }
  }
}
