import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final String category;
  final String categoryurl;

  Categories({
    this.category,
    this.categoryurl,
  });

  factory Categories.fromDocument(DocumentSnapshot doc) {
    return Categories(
      category: doc.data()["category"],
      categoryurl: doc.data()["categoryurl"],
    );
  }
  @override
  _CategoriesState createState() =>
      _CategoriesState(category: this.category, categoryurl: this.categoryurl);
}

class _CategoriesState extends State<Categories> {
  final String category;
  final String categoryurl;

  _CategoriesState({
    this.category,
    this.categoryurl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.network(categoryurl),
        Text(category),
      ],
    );
  }
}
