import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import './newsfeed.dart';
import '../Event/event.dart';
import 'pets.dart';

class Socialmedia extends StatefulWidget {
  @override
  _SocialmediaState createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  final List<Widget> _pages = [Newsfeed(), Pets(), Event()];

  int _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MaterialIcons.pets,
                color: Colors.white,
              ),
              title: Text(
                'Pets',
                style: TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  MaterialIcons.event,
                  color: Colors.white,
                ),
                title: Text('Event', style: TextStyle(color: Colors.white))),
          ]),
    );
  }
}
