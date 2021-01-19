import 'package:Pet_Bound/Widget/pet_widget.dart';
import 'package:Pet_Bound/socialmedia/pets.dart';

import 'package:flutter/material.dart';

class PetTile extends StatelessWidget {
  final Petwidget pet;
  final String userName;

  PetTile({this.pet, this.userName});
  displayFullPost(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Pets(
                  userPetId: pet.ownerId,
                  userName: userName,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => displayFullPost(context),
      child: Image.network(pet.url),
    );
  }
}
