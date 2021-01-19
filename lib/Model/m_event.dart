import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String id;
  String storeName;
  String title;
  String url;
  String description1;
  String description2;

  Events({
    this.id,
    this.storeName,
    this.title,
    this.description1,
    this.description2,
    this.url,
  });

  factory Events.fromDocument(DocumentSnapshot doc) {
    return Events(
      id: doc.id,
      storeName: doc.data()['storename'],
      title: doc.data()['title'],
      url: doc.data()['image'],
      description1: doc.data()['description1'],
      description2: doc.data()['description2'],
    );
  }
}
