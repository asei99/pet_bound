import 'package:Pet_Bound/socialmedia/home_page%20copy.dart';
import 'package:Pet_Bound/socialmedia/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../Model/m_user.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

void userprofile(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/user_profile');
}

class _SearchscreenState extends State<Searchscreen>
    with AutomaticKeepAliveClientMixin<Searchscreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;
  final userReference = FirebaseFirestore.instance.collection('users');

  emptyTextField() {
    searchTextEditingController.clear();
    FocusScope.of(context).unfocus();
  }

  controlSearching(String str) {
    Future<QuerySnapshot> allUser =
        userReference.where('username', isGreaterThanOrEqualTo: str).get();
    setState(() {
      futureSearchResults = allUser;
    });
  }

  displayUserWidget() {
    List<UserResult> searchUserResult = [];
    return FutureBuilder(
        future: futureSearchResults,
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: CircularProgressIndicator()),
              ],
            );
          }

          dataSnapshot.data.documents.forEach((document) {
            Users eachUsers = Users.fromDocument(document);
            UserResult userResult = UserResult(eachUsers);

            searchUserResult.add(userResult);
          });
          return ListView(shrinkWrap: true, children: searchUserResult);
        });
  }

  bool get wantKeepAlive => true;
  void back(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: size.width - 80,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                          Feather.search,
                        ),
                      ),
                      onFieldSubmitted: controlSearching,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => emptyTextField(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lato'),
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: futureSearchResults == null
                    ? Padding(
                        padding: EdgeInsets.only(top: size.height * 1 / 3),
                        child: Center(
                          child: Text(
                            'no user found',
                            style: TextStyle(fontSize: 30, color: Colors.grey),
                          ),
                        ),
                      )
                    : displayUserWidget(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class UserResult extends StatefulWidget {
  final Users eachUser;
  UserResult(this.eachUser);

  @override
  _UserResultState createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  bool following = false;
  displayUserProfile(BuildContext context, {String userProfileId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(
          userProfileId: userProfileId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => displayUserProfile(context,
                  userProfileId: widget.eachUser.id),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Container(
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.blue,
                          ),
                          child: widget.eachUser.image == null
                              ? Image.network(
                                  'https://png.pngitem.com/pimgs/s/130-1300400_user-hd-png-download.png')
                              : Image.network(widget.eachUser.image),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.eachUser.userName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            following
                                ? Text(
                                    'Followed',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    'Not Follow yet',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'PetList',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
