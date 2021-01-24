import 'package:Pet_Bound/Widget/pet_widget.dart';
import 'package:Pet_Bound/socialmedia/edit_pet.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Detailpet extends StatefulWidget {
  final String userProfileid;
  final String petId;

  Detailpet({this.userProfileid, this.petId});
  @override
  _DetailpetState createState() => _DetailpetState();
}

void back(BuildContext ctx) {
  Navigator.pop(ctx);
}

class _DetailpetState extends State<Detailpet> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentGender = 0;
  String gender;

  editPetProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Editpet(
                  currentPet: widget.petId,
                  userProfileId: widget.userProfileid,
                  currentGender: currentGender,
                )));
  }

  // PageController _myPage = PageContr
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: petRefrence
          .doc(widget.userProfileid)
          .collection("usersPets")
          .doc(widget.petId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator()),
            ],
          );
        }
        if (dataSnapshot == null) {
          Text("null bro");
        }
        Petwidget pet = Petwidget.fromDocument(dataSnapshot.data);
        String weight = pet.weight;
        String height = pet.height;
        String borndate = pet.borndate;
        pet.gender == "Male" ? currentGender = 0 : currentGender = 1;
        pet.gender == "Male" ? gender = "Male" : gender = "Female";

        bool ownProfile = currentUser.id == pet.ownerId;

        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1 / 1.7,
                width: double.infinity,
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(pet.url),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1 / 2,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 1 / 2.18,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      // color: Colors.black,
                      padding: EdgeInsets.only(top: 15),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0),
                                  ),
                                  border:
                                      new Border.all(color: Colors.transparent
                                          // color: Colors.black,
                                          // width: 3.0,
                                          ),
                                ),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage:
                                      NetworkImage(pet.categoryurl),
                                  backgroundColor: Colors.grey[300],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              pet.category,
                              style: TextStyle(
                                fontFamily: 'acme',
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10),
                      // color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            pet.petname,
                            style: TextStyle(fontFamily: 'acme', fontSize: 33),
                          ),
                          ownProfile
                              ? IconButton(
                                  icon: Icon(
                                    MaterialIcons.edit,
                                    size: 33,
                                  ),
                                  onPressed: () => editPetProfile())
                              : Text(""),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: size.height * 1 / 10,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 170,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(237, 171, 172, 80),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Born Date',
                                    style: TextStyle(
                                        fontFamily: 'acme', fontSize: 25),
                                  ),
                                  Text(
                                    borndate,
                                    style: TextStyle(
                                        fontFamily: 'acme', fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 171, 172, 80),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 25),
                                    ),
                                    Text(
                                      gender,
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 17),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 171, 172, 80),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Breed',
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 25),
                                    ),
                                    Text(
                                      pet.breed,
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 17),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 171, 172, 80),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Weight',
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 25),
                                    ),
                                    Text(
                                      "$weight KG ",
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 17),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 171, 172, 80),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Height',
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 25),
                                    ),
                                    Text(
                                      '$height CM',
                                      style: TextStyle(
                                          fontFamily: 'acme', fontSize: 17),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: double.infinity,
                        height: size.height * 1 / 5.4,
                        color: Color.fromRGBO(237, 171, 172, 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'About',
                              style: TextStyle(
                                  fontFamily: 'lato',
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(pet.about),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 14, left: size.width * 0.85),
                child: IconButton(
                  icon: Icon(
                    MaterialIcons.arrow_back,
                    color: Color.fromRGBO(237, 171, 172, 5),
                    size: 30,
                  ),
                  onPressed: () => back(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
