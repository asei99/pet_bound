import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../main_drawer.dart';

void login(BuildContext ctx) {
  Navigator.of(ctx).pushNamed('/login');
}

void createpost(BuildContext ctx) {
  Navigator.of(ctx).pushReplacementNamed('/socialmedia/post/create_post');
}

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Post',
          style: TextStyle(fontFamily: 'acme', fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MaterialIcons.add_circle_outline,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => createpost(context),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
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
                            IconButton(
                              padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Entypo.dots_three_vertical,
                                color: Colors.black,
                              ),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          height: 195,
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
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'You',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Like my new selfie!'),
                            Spacer(),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Icons.comment,
                              ),
                              onPressed: () => {},
                            ),
                            IconButton(
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(MaterialIcons.favorite_border),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
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
                            IconButton(
                              padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Entypo.dots_three_vertical,
                                color: Colors.white,
                              ),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          height: 195,
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
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'You',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Like my new selfie!'),
                            SizedBox(
                              width: 170,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Icons.comment,
                              ),
                              onPressed: () => {},
                            ),
                            IconButton(
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(MaterialIcons.favorite_border),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    // color: Colors.grey,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Row(
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
                            IconButton(
                              padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Entypo.dots_three_vertical,
                                color: Colors.white,
                              ),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black,
                          height: 195,
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
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'You',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Like my new selfie!'),
                            SizedBox(
                              width: 170,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(
                                Icons.comment,
                              ),
                              onPressed: () => {},
                            ),
                            IconButton(
                              // padding: EdgeInsets.only(left: 250),
                              icon: Icon(MaterialIcons.favorite_border),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
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
