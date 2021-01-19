import 'package:Pet_Bound/Widget/post_widget.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:flutter/material.dart';

class PostScreenPage extends StatelessWidget {
  final String postId;
  final String userId;

  PostScreenPage({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          postsReference.doc(userId).collection("usersPosts").doc(postId).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator()),
            ],
          );
        }

        Post post = Post.fromDocument(dataSnapshot.data);
        return Center(
          child: Scaffold(
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}