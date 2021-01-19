import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Eventcategory extends StatefulWidget {
  final String categorie;
  final String url;

  Eventcategory({this.categorie, this.url});

  factory Eventcategory.fromDocument(DocumentSnapshot doc) {
    return Eventcategory(
      categorie: doc.data()["categorie"],
      url: doc.data()["url"],
    );
  }
  @override
  _EventcategoryState createState() => _EventcategoryState(
        categorie: this.categorie,
        url: this.url,
      );
}

class _EventcategoryState extends State<Eventcategory> {
  final String categorie;
  final String url;

  _EventcategoryState({this.categorie, this.url});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(
            url,
          ),
          backgroundColor: Colors.white,
        )
      ],
    );
  }
}
