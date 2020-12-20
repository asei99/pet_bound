import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Pets extends StatefulWidget {
  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  void createpets(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets/create_pets');
  }

  void detailpets(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/socialmedia/pets/detail_pets');
  }

  void newsfeed(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/Home');
  }

  void pets(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets');
  }

  void event(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/event/place');
  }

  void profile(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/profile');
  }

  void editpet(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets/edit_pets');
  }

  // int _currentState = 0;
  List imgList = [
    {
      'image':
          'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
      'name': 'Chloe',
      'birthday': 'December 03,2015',
      'weight': '12kg',
      'height': '10 cm',
      'gender': 'female',
    },
    {
      'image':
          'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
      'name': 'Foxy',
      'birthday': 'Februari 03,2015',
      'weight': '40kg',
      'height': '50 cm',
      'gender': 'male',
    },
    {
      'image':
          'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
      'name': 'sans',
      'birthday': 'December 20,2015',
      'weight': '12kg',
      'height': '100 cm',
      'gender': 'female',
    },
    {
      'image':
          'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
      'name': 'milo',
      'birthday': 'July 03,2013',
      'weight': '20kg',
      'height': '60 cm',
      'gender': 'male',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.all(3),
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () => newsfeed(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(
                  MaterialIcons.pets,
                  size: 25,
                ),
                onPressed: () => pets(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(
                  MaterialIcons.event,
                  size: 25,
                ),
                onPressed: () => event(context),
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(MaterialIcons.person),
                onPressed: () => profile(context),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          'Pets',
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Entypo.camera,
        //     color: Color.fromRGBO(237, 171, 172, 5),
        //   ),
        //   onPressed: () => {},
        // ),
        actions: <Widget>[
          // IconButton(
          //   padding: EdgeInsets.zero,
          //   constraints: BoxConstraints(),
          //   icon: Icon(
          //     Feather.heart,
          //     color: Color.fromRGBO(237, 171, 172, 5),
          //   ),
          //   onPressed: () => login(context),
          // ),
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
      body: Container(
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
                    'Your Pet',
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
                  items: imgList.map((imgList) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1 / 1.4,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(17),
                                        bottomRight: Radius.circular(17),
                                      ),
                                      color: Color.fromRGBO(255, 239, 226, 1),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        3.4,
                                    child: Image.network(
                                      imgList['image'],

                                      // fit: BoxFit.fill,
                                    ),
                                  ), //contaner gambar
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                  new Radius.circular(60.0),
                                                ),
                                                border: new Border.all(
                                                    color: Colors.transparent
                                                    // color: Colors.black,
                                                    // width: 3.0,
                                                    ),
                                              ),
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage: AssetImage(
                                                    'Assets/Images/pets/dog.png'),
                                                backgroundColor:
                                                    Colors.grey[300],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Dog',
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
                                          imgList['name'],
                                          style: TextStyle(
                                              fontFamily: 'acme', fontSize: 35),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          imgList['birthday'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'acme',
                                              color: Colors.grey[600]),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () => detailpets(context),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1 /
                                                4.5,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text('Detail'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
