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

List postList = [
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/originals/c5/99/0e/c5990e4548a963af7f3cab348353abb7.jpg',
  'https://i.pinimg.com/736x/9c/fe/3c/9cfe3c71158e7c45606398a1046f13c6.jpg',
  'https://i.pinimg.com/736x/d3/13/73/d313731071519493f17588681179fc5d.jpg',
];
List petList = [
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
  'https://i.pinimg.com/736x/c1/ae/6f/c1ae6f1ebb02b1473dfe6f9c2ff40bee.jpg',
];

class Userprofile extends StatefulWidget {
  @override
  _UserprofileState createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  static List<String> tabList = ['Post', 'Pet'];
  int selectedIndex = 0;
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
                : Border(
                    bottom: BorderSide(width: 2, color: Colors.grey),
                  )),
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 25,

            // color: Colors.blue,
            fontFamily: 'lato',
          ),
        ),
      ),
    );
  }

  Widget post() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8),
      itemCount: postList.length,
      itemBuilder: (context, index) => Card(
        elevation: 4,
        child: Container(
          // height: size.height,
          color: Colors.grey,
          child: Image.network(postList[index]),
        ),
      ),
    );
  }

  Widget pet() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8),
      itemCount: petList.length,
      itemBuilder: (context, index) => Card(
        elevation: 4,
        child: Container(
          // height: size.height,
          color: Colors.grey,
          child: Image.network(petList[index]),
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
        centerTitle: false,
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 14,

        title: Text(
          'Otin bin otin',
          // textAlign: TextAlign.left,
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
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            constraints: BoxConstraints(),
            icon: Icon(
              Entypo.circle_with_cross,
              color: Color.fromRGBO(237, 171, 172, 5),
            ),
            onPressed: () => newsfeed(context),
          ),
        ],
      ),
      // bottomNavigationBar: Navigationbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1 / 3.5,
                        // color: Colors.grey,
                        width: double.infinity,
                        child: Image.network(
                          "https://awsimages.detik.net.id/community/media/visual/2020/01/16/6ce92f53-c1e5-4f94-ab17-95e4d30537e0.jpeg?w=750&q=90                                          ",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 1 / 3.9),
                        // alignment: Alignment.bottomRight,
                        width: size.width * 1 / 4,
                        height: size.height * 1 / 17,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text('Following'),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'asdgfjkhsadkfhskahfksdlhfksadhkflhsakfhskjdahfkjdsahkfldhsajkldfhjkshfkldsahfksadhfkdshkflashfhdasjklhlk'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                )),
                              ),
                              child: Center(
                                child: Text(
                                  ' 120\nPosts',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                )),
                              ),
                              child: Center(
                                child: Text(
                                  '       120\nFollowers',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 1 / 14,
                              child: Center(
                                child: Text(
                                  '      120\nFollowing',
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          tabView(tabList[0], 0),
                          // SizedBox(width: 80,)
                          tabView(tabList[1], 1),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 250,
                        child: selectedIndex == 0 ? post() : pet(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
