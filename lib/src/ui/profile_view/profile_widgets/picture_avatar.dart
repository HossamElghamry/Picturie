import 'package:flutter/material.dart';

class PictureAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: CircleAvatar(
        radius: 50,
        child: Icon(
          Icons.person,
          size: 50,
        ),
        backgroundColor: Color(0xFF64FFDA),
      ),
    );
  }
}
