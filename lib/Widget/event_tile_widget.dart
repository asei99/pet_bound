import 'package:Pet_Bound/Widget/event_widget.dart';
import 'package:Pet_Bound/socialmedia/event_screen.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Eventwidget event;

  EventTile(this.event);
  displayFullPost(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventScreenPage(contestId: event.contestId)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => displayFullPost(context),
      child: Image.network(event.url),
    );
  }
}
