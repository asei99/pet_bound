import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


@override
Widget build(BuildContext context) {
  // final double statusBarHeight = MediaQuery.of(context).padding.top;
  Size size = MediaQuery.of(context).size;
  return Scaffold(
    appBar: GradientAppBar(
      backgroundColorEnd: Color.fromRGBO(0, 64, 225, 1),
      backgroundColorStart: Color.fromRGBO(0, 225, 225, 1),
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(Feather.save, color: Colors.white), onPressed: () => {})
      ],
    ),

    // drawer: MainDrawer(),

    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Container(
        // padding: new EdgeInsets.only(top: statusBarHeight),
        child: Stack(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          const Color.fromRGBO(0, 64, 225, 1),
                          const Color.fromRGBO(0, 225, 225, 1),
                        ],
                      ),
                    ),
                    height: size.height * 0.15,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: statusBarHeight),
                  //   height: size.height * 0.06,
                  //   color: Colors.red,
                  //   child: Row(
                  //     children: <Widget>[
                  //       IconButton(
                  //         icon:
                  //             Icon(MaterialCommunityIcons.account_edit_outline),
                  //         onPressed: () => Scaffold.of(context).openDrawer(),
                  //       ),
                  //     ],
                  // ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Otin bin Otin',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '1k following 10k Followers 200posts',
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.19),
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'otinotin@yahoo.com',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Otin bin Otin',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'OtinSally4ever',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      hintText: 'Pug Lovers',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Birthday',
                      hintText: '24 August',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '081234567890',
                      hintStyle: TextStyle(color: Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.blue),
                        // gapPadding: 10
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
