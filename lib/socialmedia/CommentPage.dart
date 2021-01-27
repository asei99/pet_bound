import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:timeago/timeago.dart' as tAgo;

class CommentPage extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postImageUrl;

  CommentPage({this.postId, this.postOwnerId, this.postImageUrl});
  @override
  _CommentPageState createState() => _CommentPageState(
      postId: postId, postOwnerId: postOwnerId, postImageUrl: postImageUrl);
}

class _CommentPageState extends State<CommentPage> {
  final _formKey = GlobalKey<FormState>();

  final String postId;
  final String postOwnerId;
  final String postImageUrl;
  TextEditingController commentTextEditingController = TextEditingController();

  _CommentPageState({this.postId, this.postOwnerId, this.postImageUrl});

  retrieveComment() {
    print('tapped');
    return StreamBuilder(
      stream: commentsReference
          .doc(postId)
          .collection("comments")
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator()),
            ],
          );
        }
        List<Comment> comments = [];
        dataSnapshot.data.documents.forEach((document) {
          comments.add(Comment.fromDocument((document)));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  saveComment() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      commentsReference.doc(postId).collection("comments").add({
        "username": currentUser.userName,
        "comment": commentTextEditingController.text,
        "timestamp": DateTime.now(),
        "url": currentUser.image,
        "userId": currentUser.id,
        "userurlwhocomment": currentUser.image,
      });
      bool isNotPostOwner = postOwnerId != currentUser.id;
      if (isNotPostOwner) {
        activityFeedReference.doc(postOwnerId).collection("feedItems").add({
          "type": "comment",
          "commentData": commentTextEditingController.text,
          "postId": postId,
          "userId": currentUser.id,
          "username": currentUser.userName,
          "userProfileImg": currentUser.image,
          "url": postImageUrl,
          "timestamp": DateTime.now()
        });
      }
      commentTextEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: GestureDetector(
          onDoubleTap: () => retrieveComment(),
          child: Container(
            // color: Colors.blue,
            child: Text(
              "Comment",
              style: TextStyle(
                  fontFamily: 'acme', fontSize: 25, color: Colors.black),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            MaterialIcons.arrow_back,
            color: Colors.black,
            // size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: retrieveComment(),
          ),
          Divider(),
          Form(
            key: _formKey,
            child: ListTile(
              title: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input Comment';
                  }
                  return null;
                },
                controller: commentTextEditingController,
                decoration: InputDecoration(
                  labelText: "Write Comment Here",
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              trailing: OutlineButton(
                onPressed: saveComment,
                borderSide: BorderSide.none,
                child: Text(
                  "send",
                  style: TextStyle(
                      color: Color.fromRGBO(237, 171, 172, 5),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String url;
  final String comment;
  final Timestamp timestamp;
  final String userurlwhocomment;

  Comment(
      {this.username,
      this.userId,
      this.url,
      this.comment,
      this.timestamp,
      this.userurlwhocomment});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc.data()["username"],
      userId: doc.data()["userId"],
      url: doc.data()["url"],
      comment: doc.data()["comment"],
      timestamp: doc.data()["timestamp"],
      userurlwhocomment: doc.data()["userurlwhocomment"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: Card(
        elevation: 3,
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  username + ":  " + comment,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(userurlwhocomment),
                ),
                subtitle: Text(
                  tAgo.format(timestamp.toDate()),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
