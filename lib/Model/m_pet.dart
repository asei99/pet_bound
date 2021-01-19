import 'package:cloud_firestore/cloud_firestore.dart';

class Pets {
  final String borndate;
  final String breed;
  final String height;
  final String gender;
  final String weight;
  final String about;
  final String ownerId;
  final String petId;
  final String url;
  final String petname;
  final String category;
  final String categoryurl;
  final String categoryid;

  Pets({
    this.categoryid,
    this.category,
    this.categoryurl,
    this.about,
    this.borndate,
    this.breed,
    this.gender,
    this.height,
    this.ownerId,
    this.petId,
    this.petname,
    this.url,
    this.weight,
  });

  factory Pets.fromDocument(DocumentSnapshot doc) {
    return Pets(
        categoryid: doc.data()["categoryid"],
        about: doc.data()["about"],
        breed: doc.data()["breed"],
        gender: doc.data()["petgender"],
        height: doc.data()["height"],
        borndate: doc.data()["borndate"],
        petId: doc.id,
        petname: doc.data()["petname"],
        weight: doc.data()["weight"],
        ownerId: doc.data()["ownerId"],
        url: doc.data()["url"],
        category: doc.data()["category"],
        categoryurl: doc.data()["categoryurl"]);
  }
}
