import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:Pet_Bound/socialmedia/profile.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  void back(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          "Notification",
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
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
        child: FutureBuilder(
          future: retrieveNotifications(),
          builder: (context, dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: CircularProgressIndicator()),
                ],
              );
            }
            return ListView(
              children: dataSnapshot.data,
            );
          },
        ),
      ),
    );
  }

  retrieveNotifications() async {
    QuerySnapshot querySnappsht = await activityFeedReference
        .doc(currentUser.id)
        .collection("feedItems")
        .orderBy("timestamp", descending: true)
        .limit(50)
        .get();

    List<NotificationItem> notificationsItems = [];
    querySnappsht.docs.forEach((document) {
      notificationsItems.add(NotificationItem.fromDocument(document));
    });
    return notificationsItems;
  }
}

String notificationItemText;
Widget mediaPreview;

class NotificationItem extends StatelessWidget {
  final String username;
  final String type;
  final String commentData;
  final String postId;
  final String userId;
  final String userProfileImg;
  final String url;
  final Timestamp timestamp;

  NotificationItem(
      {this.username,
      this.type,
      this.commentData,
      this.postId,
      this.userId,
      this.userProfileImg,
      this.url,
      this.timestamp});

  factory NotificationItem.fromDocument(DocumentSnapshot doc) {
    return NotificationItem(
      username: doc.data()["username"],
      type: doc.data()["type"],
      commentData: doc.data()["commentData"],
      postId: doc.data()["postId"],
      userId: doc.data()["userId"],
      userProfileImg: doc.data()["userProfileImg"],
      url: doc.data()["url"],
      timestamp: doc.data()["timestamp"],
    );
  }
  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: GestureDetector(
            onTap: () => displayUserProfile(context, userProfileId: userId),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " $notificationItemText"),
                ],
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userProfileImg),
          ),
          subtitle: Text(
            tAgo.format(timestamp.toDate()),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
      ),
    );
  }

  configureMediaPreview(context) {
    if (type == "comment" || type == "like") {
      mediaPreview = GestureDetector(
        onTap: () => displayOwnProfile(context, userProfileId: currentUser.id),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: CachedNetworkImageProvider(url)),
              ),
            ),
          ),
        ),
      );
    } else {
      mediaPreview = Text("");
    }

    if (type == "like") {
      notificationItemText = "liked your post.";
    } else if (type == "comment") {
      notificationItemText = "replied: $commentData";
    } else if (type == "follow") {
      notificationItemText = "started following you.";
    } else {
      notificationItemText = "Error, Unknown type = $type";
    }
  }

  displayOwnProfile(BuildContext context, {String userProfileId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(userProfileId: currentUser.id)));
  }

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
}
