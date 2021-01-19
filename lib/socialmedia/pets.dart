import 'package:Pet_Bound/Widget/pet_widget.dart';
import 'package:Pet_Bound/socialmedia/create_pets.dart';
import 'package:Pet_Bound/socialmedia/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Pets extends StatefulWidget {
  final String userPetId;

  Pets({this.userPetId});
  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  List<Petwidget> petList = [];
  bool loading = false;
  // @override
  void initState() {
    super.initState();
    getAllPet();
  }

  getAllPet() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot =
        await petRefrence.doc(widget.userPetId).collection("usersPets").get();
    if (mounted) {
      setState(() {
        loading = false;
        petList = querySnapshot.docs
            .map((eachPost) => Petwidget.fromDocument(eachPost))
            .toList();
        // querySnapshot.docs.map(doc) => Petwidget.fromDocument(doc)).toList();
      });
    }
  }

  void createpets(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => Createpets(
          currentUser: currentUser.id,
        ),
      ),
    );
  }

  // int _currentState = 0;
  Widget pet() {
    // return Text(contestList.toString());
    return Column(
      children: petList,
    );
  }

  createPetList() {
    return Container(
      // color: Colors.blue,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  "Your pet",
                  style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 5, bottom: 30),
                child: Text(
                  'List',
                  style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 30,
                  ),
                ),
              ),
              CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 1 / 1.75,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    reverse: true,
                  ),
                  items: petList),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: CircularProgressIndicator()),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          'Pets',
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              AntDesign.pluscircleo,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => createpets(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        child: createPetList(),
        onRefresh: () => getAllPet(),
      ),
    );
  }
}
