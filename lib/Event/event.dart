
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

void contestdetail(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('event/contest_detail');
}

void placedetail(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('event/place_detail');
}

int selectedIndex = 0;

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  static List<String> tabList = ['Contest', 'Place'];

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget tabView(String txt, int index) {
    return GestureDetector(
      onTap: () => changeIndex(index),
      child: Container(
        decoration: BoxDecoration(
          border: selectedIndex == index
              ? Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(237, 171, 172, 5),
                  ),
                )
              : Border.all(color: Colors.grey),
        ),
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // color: Colors.blue,
            fontFamily: 'acme',
          ),
        ),
      ),
    );
  }

  Widget isiContest() {
    return InkWell(
      onTap: () => contestdetail(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 1 / 2.6,
          // color: Colors.grey,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 14,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Otin bin otin'),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 1 / 4,
                width: double.infinity,
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(
                          "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          "),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 12,
                  right: 10,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'New Store is open on Central Park!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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

  Widget isiPlace() {
    return InkWell(
      onTap: () => placedetail(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 1 / 2.6,
          // color: Colors.grey,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 14,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/ef/78/0c/ef780c022fccf00447404064c8d4c28c.jpg"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Bahagia Pet Shop'),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 1 / 4,
                width: double.infinity,
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(
                          "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          "),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 12,
                  right: 10,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'New Store is open on Central Park!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        toolbarHeight: size.height * 1 / 14,
        title: Text(
          'Events',
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                tabView(tabList[0], 0),
                // SizedBox(width: 80,)
                tabView(tabList[1], 1),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                selectedIndex == 0 ? isiContest() : isiPlace(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
