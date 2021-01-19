import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String id;
  String category;
  String categoryurl;

  Categories({
    this.id,
    this.category,
    this.categoryurl,
  });

  factory Categories.fromDocument(DocumentSnapshot doc) {
    return Categories(
      id: doc.id,
      category: doc.data()["categorie"],
      categoryurl: doc.data()["url"],
    );
  }
}
