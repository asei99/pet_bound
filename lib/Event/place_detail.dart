import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

void newsfeed(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/Home');
}

void back(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/event/place');
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

class Placedetail extends StatefulWidget {
  @override
  _PlacedetailState createState() => _PlacedetailState();
}

class _PlacedetailState extends State<Placedetail> {
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
          'Place',
          style:
              TextStyle(fontFamily: 'acme', fontSize: 25, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            MaterialIcons.arrow_back,
            color: Colors.black,
            // size: 30,
          ),
          onPressed: () => back(context),
        ),
      ),
      body: Container(
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              // padding: EdgeInsets.only(),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  // color: Colors.grey,
                  width: double.infinity,
                  child: Image.network(
                    "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          ",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Like my new selfie!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          // padding: EdgeInsets.only(left: 250),
                          icon: Icon(
                            MaterialIcons.favorite_border,
                            size: 20,
                          ),
                          onPressed: () => {},
                        ),
                        IconButton(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          constraints: BoxConstraints(),
                          // padding: EdgeInsets.only(left: 250),
                          icon: Icon(
                            Icons.comment,
                            size: 20,
                          ),
                          onPressed: () => {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About This Contest',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Lorem ipsum bla bla bal balb alba bla lbal asdfsaf asdf ashnfkhsakfhsdalhfsdhksadfsafdjksajfsjlfjsalfdjsalfsdjkdhfskahfdkshksahfaskl'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About This Contest',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Lorem ipsum bla bla bal balb alba bla lbal asdfsaf asdf ashnfkhsakfhsdalhfsdhk'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Event Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                  'Assets/Images/pets/cat.png',
                                ),
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(
                                    'Assets/Images/pets/dog.png',
                                  ),
                                  backgroundColor: Colors.white),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
