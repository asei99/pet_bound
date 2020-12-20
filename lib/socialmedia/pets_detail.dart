import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Detailpet extends StatefulWidget {
  @override
  _DetailpetState createState() => _DetailpetState();
}

void back(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/pets');
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

class _DetailpetState extends State<Detailpet> {
  // PageController _myPage = PageController(initialPage: 0);
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 1.7,
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(15.0),
                            ),
                            border: new Border.all(color: Colors.transparent
                                // color: Colors.black,
                                // width: 3.0,
                                ),
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(
                              'Assets/Images/pets/cat.png',
                            ),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cat',
                        style: TextStyle(
                          fontFamily: 'acme',
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Miao Miao',
                        style: TextStyle(fontFamily: 'acme', fontSize: 33),
                      ),
                      IconButton(
                          icon: Icon(
                            MaterialIcons.edit,
                            size: 33,
                          ),
                          onPressed: null)
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
                              color: Colors.grey,
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
                                  '15 desc 2020',
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
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 170,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 170,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 170,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    height: size.height * 1 / 5.4,
                    color: Colors.grey,
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
                        Text('asdjfklsajdflkdsjlfdjslksjdlkfsjaljsadfljlfksd'),
                        Text('asdjfklsajdflkdsjlfdjslksjdlkfsjaljsadfljlfksd'),
                        Text('asdjfklsajdflkdsjlfdjslksjdlkfsjaljsadfljlfksd'),
                        Text('asdjfklsajdflkdsjlfdjslksjdlkfsjaljsadfljlfksd'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 14),
            child: IconButton(
              icon: Icon(
                MaterialIcons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => back(context),
            ),
          ),
        ],
      ),
    );
  }
}
