import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String userName;
  String userEmail;
  String bio;
  String image;
  String profileurl;
  String queryUserName;

  Users({
    this.id,
    this.userName,
    this.userEmail,
    this.bio,
    this.image,
    this.profileurl,
    this.queryUserName,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
        id: doc.id,
        userName: doc.data()['username'],
        userEmail: doc.data()['email'],
        bio: doc.data()['bio'],
        image: doc.data()['image'],
        profileurl: doc.data()['profileurl'],
        queryUserName: doc.data()['queryusername']);
  }
}
