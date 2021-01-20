import 'package:Pet_Bound/Widget/place_widget.dart';
import 'package:Pet_Bound/socialmedia/CommentPage.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class EventPlaceScreenPage extends StatefulWidget {
  final String contestId;

  EventPlaceScreenPage({this.contestId});

  @override
  _EventPlaceScreenPageState createState() => _EventPlaceScreenPageState();
}

class _EventPlaceScreenPageState extends State<EventPlaceScreenPage> {
  final String currentOnlineUserId = currentUser?.id;
  int likeCount;
  bool isLiked;
  List<String> category = [];

  void back(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: eventRefrence
          .doc("place")
          .collection("placeitem")
          .doc(widget.contestId)
          .get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator()),
            ],
          );
        }

        Eventplacewidget contest =
            Eventplacewidget.fromDocument(dataSnapshot.data);

        contest.category.values.forEach((eachValue) {
          category.add(eachValue);
        });
        isLiked = (contest.likes[currentOnlineUserId] == true);

        int getTotalNumberOfLikes(likes) {
          if (likes == null) {
            return 0;
          }
          int counter = 0;
          likes.values.forEach((eachValue) {
            if (eachValue == true) {
              counter = counter + 1;
            }
          });
          return counter;
        }

        int likeCount = getTotalNumberOfLikes(contest.likes);

        displayComment(BuildContext context,
            {String postId, String ownerId, String url}) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CommentPage(postId: contest.contestId);
          }));
        }

        controlUserLikePost() {
          bool _liked = contest.likes[currentOnlineUserId] == true;

          if (_liked) {
            eventRefrence
                .doc("place")
                .collection("placeitem")
                .doc(contest.contestId)
                .update({"likes.$currentOnlineUserId": false});

            setState(() {
              likeCount = likeCount - 1;
              print(likeCount);
              isLiked = false;
              contest.likes[currentOnlineUserId] = false;
            });
          } else if (!_liked) {
            eventRefrence
                .doc("place")
                .collection("placeitem")
                .doc(contest.contestId)
                .update({"likes.$currentOnlineUserId": true});

            setState(() {
              likeCount = likeCount + 1;
              print(likeCount);

              isLiked = true;

              contest.likes[currentUser.id] = true;
            });
          }
        }

        return Center(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
              title: Text(
                contest.storename,
                style: TextStyle(
                    fontFamily: 'acme', fontSize: 25, color: Colors.black),
              ),
              leading: IconButton(
                icon: Icon(
                  MaterialIcons.arrow_back,
                  color: Colors.black,
                  // size: 30,
                ),
                onPressed: () => back(context),
              ),
            ),
            body: Container(
              child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    // padding: EdgeInsets.only(),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        // color: Colors.grey,
                        width: double.infinity,
                        child: Image.network(
                          contest.url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                contest.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Spacer(),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                // padding: EdgeInsets.only(left: 250),
                                icon: Icon(
                                  isLiked
                                      ? MaterialIcons.favorite
                                      : MaterialIcons.favorite_border,
                                  size: 20,
                                  color: Colors.pink,
                                ),
                                onPressed: () => controlUserLikePost(),
                              ),
                              Text("$likeCount likes"),
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
                                onPressed: () => displayComment(context,
                                    postId: contest.contestId),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'About This Contest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  contest.description1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'About This Contest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  contest.description2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Event Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  // color: Colors.blue,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: contest.category.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Card(
                                            elevation: 4,
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundImage: NetworkImage(
                                                category[index],
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
