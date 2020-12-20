import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Createpets extends StatefulWidget {
  static List<String> lst = ['Male', 'Female'];
  // static List dropdownlist = [
  //   {'image': 'Assets/Images/pets/cat.png', 'category': 'Cat'},
  //   {'image': 'Assets/Images/pets/dog.png', 'category': 'Dog'},
  // ];
  static List dropdownlist = ['Cat', 'Dog'];
  @override
  _CreatepetsState createState() => _CreatepetsState();
}

class _CreatepetsState extends State<Createpets> {
  void back(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets');
  }

  int selectedIndex = 0;

  Widget genderRadio(String txt, int index) {
    return InkWell(
      onTap: () => changeIndex(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index
              ? Color.fromRGBO(237, 171, 172, 5)
              : Colors.grey,
        ),
        width: 140,
        height: 40,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontFamily: 'acme',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int value = 1;
  String valcategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,
        title: Text(
          'Create Pets',
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
            onPressed: () => {},
          ),
        ],
        leading: IconButton(
          icon: Icon(
            MaterialIcons.arrow_back,
            color: Color.fromRGBO(237, 171, 172, 5),
          ),
          onPressed: () => back(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tell us about',
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 30,
                    color: Color.fromRGBO(237, 171, 172, 5),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'your pet',
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 30,
                    color: Color.fromRGBO(237, 171, 172, 5),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 1 / 6,
                child: Center(
                  child: Text('input images'),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Name'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(237, 171, 172, 5),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Gender'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        genderRadio(Createpets.lst[0], 0),
                        SizedBox(
                          width: 10,
                        ),
                        genderRadio(Createpets.lst[1], 1),
                      ],
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Born Date'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        genderRadio(Createpets.lst[0], 0),
                        SizedBox(
                          width: 10,
                        ),
                        genderRadio(Createpets.lst[1], 1),
                      ],
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Weight'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          // color: Colors.grey,
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(237, 171, 172, 5),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text('KG'),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Height'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          // color: Colors.grey,
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(237, 171, 172, 5),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text('CM'),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Category'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      // color: Colors.grey,
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButton(
                        value: valcategory,
                        items: Createpets.dropdownlist.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            valcategory = value;
                          });
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Breed'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(237, 171, 172, 5),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('About'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.grey,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(237, 171, 172, 5),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
