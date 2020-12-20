import 'package:Pet_Bound/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Createpost extends StatelessWidget {
  void post(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed('/socialmedia/post');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Post',
          style: TextStyle(fontFamily: 'acme', fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesome.floppy_o,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => post(context),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: MediaQuery.of(context).size.height * 1 / 3,
              child: Center(
                child: Text('input images'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              // enabled: false,
              decoration: InputDecoration(
                // labelText: '',
                hintText: 'Write Your Caption',
                hintStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              // enabled: false,
              decoration: InputDecoration(
                // labelText: '',
                hintText: 'Tag Your Location',
                hintStyle: TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
