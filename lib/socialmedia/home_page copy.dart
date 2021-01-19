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
var userEmail = '';
var userName = '';
var userPassword = '';
final DateTime timestamp = DateTime.now();

class Mainmain extends StatefulWidget {
  @override
  _MainmainState createState() => _MainmainState();
}

class _MainmainState extends State<Mainmain> {
  final _formKey = GlobalKey<FormState>();
  int getPageIndex = 0;
  bool isSignedIn = false;
  int currentIndex = 4;
  final auth = FirebaseAuth.instance;
  var isLoading = false;
  String email;
  String password;
  String username;
  UserCredential authResult;
  var isLogin = true;
  void initState() {
    super.initState();

    pageController = PageController();
  }

  void trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      submitButton();
    }
  }

  submitButton() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
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
        setState(() {
          buildHomeScreen();
        });
      }
      DocumentSnapshot documentSnapshot =
          await usersReference.doc(FirebaseAuth.instance.currentUser.uid).get();

      currentUser = Users.fromDocument(documentSnapshot);
      print(currentUser.userName);
      print('hi');
      print(currentUser.id);
    } on PlatformException catch (err) {
      var message = 'please check your email or password';
      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(context).showSnackBar(
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

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
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
                icon: Icon(Icons.home),
                onPressed: () => goNewsFeed(),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(
                  MaterialIcons.pets,
                  size: 25,
                ),
                onPressed: () => goPet(),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
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
    Scaffold buildLoginScreen() {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        // backgroundColor: Color.fromRGBO(235, 171, 171, 1),
        backgroundColor: Color.fromRGBO(255, 239, 226, 1),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 9,
                  child: Center(
                    child: Text(
                      'Pet Bound',
                      style: TextStyle(fontFamily: 'acme', fontSize: 50),
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        // height: MediaQuery.of(context).size.height * 1 / 1.4,
                        // color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 25),
                              height:
                                  MediaQuery.of(context).size.height * 1 / 5,
                              // color: Colors.grey,
                              child: !isLogin
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Create New',
                                          style: TextStyle(
                                              fontFamily: 'lato', fontSize: 28),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Account.',
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                fontSize: 28)),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Sign in',
                                          style: TextStyle(
                                              fontFamily: 'lato', fontSize: 28),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('to continue',
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                fontSize: 28)),
                                      ],
                                    ),
                            ),
                            //list text field

                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  if (!isLogin)
                                    TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'username is empty';
                                        } else if (value.length < 5) {
                                          return 'username must more than 5 word';
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      // style: TextStyle(color: Colors.pink),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),

                                        prefixIcon: Icon(
                                          FontAwesome.user,
                                        ),
                                        labelText: 'User Name',

                                        // labelStyle: TextStyle(
                                        //   color: Colors.pink,
                                        // ),
                                      ),
                                      onSaved: (value) {
                                        userName = value;
                                      },
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Email is empty';
                                      } else if (value.length < 5) {
                                        return 'Email must more than 5 word';
                                      } else if (!value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    // style: TextStyle(color: Colors.pink),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),

                                      prefixIcon: Icon(
                                        FontAwesome.envelope,
                                      ),
                                      labelText: 'Email',

                                      // labelStyle: TextStyle(
                                      //   color: Colors.pink,
                                      // ),
                                    ),
                                    onSaved: (value) {
                                      userEmail = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is empty';
                                      } else if (value.length < 5) {
                                        return 'Password must more than 5 word';
                                      }
                                      return null;
                                    },
                                    autofocus: false,
                                    obscureText: true,
                                    // style: TextStyle(color: Colors.pink),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      prefixIcon: Icon(
                                        FontAwesome.lock,
                                      ),
                                      labelText: 'Password',
                                    ),
                                    onSaved: (value) {
                                      userPassword = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (!isLogin)
                                    TextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'password is empty';
                                        } else if (value != userPassword) {
                                          return 'password didnt match';
                                        }
                                        return null;
                                      },
                                      autofocus: false,
                                      // style: TextStyle(color: Colors.pink),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        prefixIcon: Icon(
                                          FontAwesome.lock,
                                        ),
                                        labelText: 'Re-Enter Password',

                                        // labelStyle: TextStyle(
                                        //   color: Colors.pink,
                                        // ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            if (isLoading)
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            if (!isLoading)
                              InkWell(
                                onTap: () => submitButton(),
                                child: Container(
                                  width: 280,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    !isLogin ? 'Sign Up' : 'Login',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isLoading) CircularProgressIndicator(),
                    if (!isLoading)
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        child: Container(
                          height: size.height * 1 / 15,
                          child: !isLogin
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'I already have an account? ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLogin = !isLogin;
                                        });
                                      },
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Dont’t have account? ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'lato',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLogin = !isLogin;
                                        });
                                      },
                                      child: Text(
                                        'Create new account',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontFamily: 'lato',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                  ],
                )),
              ],
            ),
          ),
        ),
      );
    }

    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildLoginScreen();
    }
  }
}
