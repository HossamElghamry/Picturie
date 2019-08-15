import 'package:flutter/material.dart';

class ProfilePictureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: double.infinity,
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 55,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
        onPressed: () {},
      ),
    );
  }
}
