import 'dart:async';

import 'package:Pet_Bound/Model/m_user.dart';
import 'package:Pet_Bound/socialmedia/CommentPage.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:Pet_Bound/socialmedia/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Post extends StatefulWidget {
  final String description;
  final dynamic likes;
  final String ownerId;
  final String postId;
  final String url;
  final String username;

  Post({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.url,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc.id,
      ownerId: doc.data()["ownerId"],
      likes: doc.data()["likes"],
      username: doc.data()["username"],
      description: doc.data()["description"],
      url: doc.data()["url"],
    );
  }

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

  @override
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        likes: this.likes,
        username: this.username,
        description: this.description,
        url: this.url,
        likeCount: getTotalNumberOfLikes(this.likes),
      );
}

class _PostState extends State<Post> {
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('Posts Picture');
  final String postId;
  final String ownerId;
  Map likes;
  final String username;
  final String description;
  final String url;
  int likeCount;
  bool isLiked;
  int commentCount;
  bool showHeart = false;
  final String currentOnlineUserId = currentUser?.id;

  _PostState({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.url,
    this.likeCount,
    this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentOnlineUserId] == true);

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
      future: usersReference.doc(ownerId).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator()),
            ],
          );
        }
        Users user = Users.fromDocument(dataSnapshot.data);
        bool isPostOwner = currentOnlineUserId == ownerId;
        return Container(
          height: MediaQuery.of(context).size.height * 1 / 14,
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(url),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                  onTap: () =>
                      displayUserProfile(context, userProfileId: user.id),
                  child: Text(user.userName)),
              Spacer(),
              isPostOwner
                  ? IconButton(
                      icon: Icon(Feather.trash_2),
                      onPressed: () => controlPostDelete(context),
                    )
                  : Text(""),
            ],
          ),
        );
      },
    );
  }

  controlPostDelete(BuildContext mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Do you want to delete your post?",
              style: TextStyle(color: Colors.black),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  removeUserPost();
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  removeUserPost() async {
    postsReference
        .doc(ownerId)
        .collection("usersPosts")
        .doc(postId)
        .get()
        .then((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });

    storageReference.child("post_$postId.jpg").delete();

    QuerySnapshot querySnapshot = await activityFeedReference
        .doc(ownerId)
        .collection("feedItems")
        .where("postId", isEqualTo: postId)
        .get();

    querySnapshot.docs.forEach((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });

    QuerySnapshot commentsQuerySnapshot =
        await commentsReference.doc(postId).collection("comments").get();

    commentsQuerySnapshot.docs.forEach((document) {
      if (document.exists) {
        document.reference.delete();
      }
    });
  }

  displayUserProfile(BuildContext context, {String userProfileId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(userProfileId: userProfileId)));
  }

  removeLike() {
    bool isNotPostOwner = currentOnlineUserId != ownerId;
    if (isNotPostOwner) {
      activityFeedReference
          .doc(ownerId)
          .collection("feedItems")
          .doc(postId)
          .get()
          .then((document) {
        if (document.exists) {
          document.reference.delete();
        }
      });
    }
  }

  addLike() {
    bool isNotPostId = currentOnlineUserId != ownerId;
    if (isNotPostId) {
      activityFeedReference
          .doc(ownerId)
          .collection("feedItems")
          .doc(postId)
          .set({
        "type": "like",
        "username": currentUser.userName,
        "userId": currentUser.id,
        "timestamp": DateTime.now(),
        "url": url,
        "postId": postId,
        "userProfileImg": currentUser.image,
      });
    }
  }

  controlUserLikePost() {
    bool _liked = likes[currentOnlineUserId] == true;

    if (_liked) {
      postsReference
          .doc(ownerId)
          .collection("usersPosts")
          .doc(postId)
          .update({"likes.$currentOnlineUserId": false});
      removeLike();

      setState(() {
        likeCount = likeCount - 1;
        isLiked = false;
        likes[currentOnlineUserId] = false;
      });
    } else if (!_liked) {
      postsReference
          .doc(ownerId)
          .collection("usersPosts")
          .doc(postId)
          .update({"likes.$currentOnlineUserId": true});
      addLike();
      setState(() {
        likeCount = likeCount + 1;
        isLiked = true;

        likes[currentOnlineUserId] = true;

        showHeart = true;
      });
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  createPostPicture() {
    return GestureDetector(
      onDoubleTap: () => controlUserLikePost,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 1 / 4,
            width: double.infinity,
            child: DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          showHeart
              ? Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height * 1 / 4,
                  width: double.infinity,
                  child: Icon(
                    Icons.favorite,
                    size: 140.0,
                    color: Colors.pink,
                  ))
              : Text(""),
        ],
      ),
    );
  }

  createPostFooter() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 10,
        right: 10,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(description),
          Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            // padding: EdgeInsets.only(left: 250),
            icon: Icon(
              isLiked ? MaterialIcons.favorite : MaterialIcons.favorite_border,
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
                postId: postId, ownerId: ownerId, url: url),
          ),
        ],
      ),
    );
  }

  displayComment(BuildContext context,
      {String postId, String ownerId, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CommentPage(
          postId: postId, postOwnerId: ownerId, postImageUrl: url);
    }));
  }
}
