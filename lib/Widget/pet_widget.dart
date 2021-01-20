import 'package:Pet_Bound/socialmedia/pets_detail.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Petwidget extends StatefulWidget {
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

  Petwidget({
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
    this.category,
    this.categoryurl,
    this.categoryid,
  });

  factory Petwidget.fromDocument(DocumentSnapshot doc) {
    return Petwidget(
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
      categoryurl: doc.data()["categoryurl"],
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
  _PetwidgetState createState() => _PetwidgetState(
      about: this.about,
      breed: this.breed,
      gender: this.gender,
      height: this.height,
      borndate: this.borndate,
      petId: this.petId,
      petname: this.petname,
      weight: this.weight,
      ownerId: this.ownerId,
      url: this.url,
      category: this.category,
      categoryurl: this.categoryurl,
      categoryid: this.categoryid);
}

class _PetwidgetState extends State<Petwidget> {
  final String categoryid;
  final String category;
  final String categoryurl;
  final String ownerId;
  final String breed;
  final String height;
  final String gender;
  final String weight;
  final String about;
  final String borndate;
  final String petId;
  final String url;
  final String petname;
  int likeCount;
  int commentCount;
  bool isLiked;
  bool showHeart = false;

  _PetwidgetState({
    this.categoryid,
    this.category,
    this.categoryurl,
    this.borndate,
    this.about,
    this.breed,
    this.gender,
    this.height,
    this.ownerId,
    this.petId,
    this.petname,
    this.url,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width * 1 / 1.5,
              // color: Colors.grey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  createPetPicture(),
                  SizedBox(
                    height: 15,
                  ),
                  createPetInfo(),
                  SizedBox(
                    height: 15,
                  ),
                  createPostFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  createPetPicture() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(17),
          bottomRight: Radius.circular(17),
        ),
        color: Color.fromRGBO(255, 239, 226, 1),
      ),
      height: MediaQuery.of(context).size.height * 1 / 3.4,
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  createPetInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(60.0),
                  ),
                  border: new Border.all(color: Colors.transparent
                      // color: Colors.black,
                      // width: 3.0,
                      ),
                ),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(categoryurl),
                  backgroundColor: Colors.grey[300],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                category,
                // "HI",
                style: TextStyle(
                  fontFamily: 'acme',
                  fontSize: 20,
                ),
              ),
              // Spacer(),
              // IconButton(
              //   icon: Icon(
              //     Feather.edit,
              //     size: 20,
              //     color: Color.fromRGBO(
              //         237, 171, 172, 5),
              //   ),
              //   onPressed: () => editpet(context),
              // ),
            ],
          ),
          Text(
            petname,
            style: TextStyle(fontFamily: 'acme', fontSize: 35),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            // "hi",
            borndate,
            style: TextStyle(
                fontSize: 20, fontFamily: 'acme', color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  createPostFooter() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: InkWell(
        onTap: () => displayFullPet(context),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 1 / 4.5,
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 171, 172, 5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Detail",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  displayFullPet(context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detailpet(
                  userProfileid: ownerId,
                  petId: petId,
                )));
  }
}
