import 'package:flutter/material.dart';

class PicturieLogo extends StatelessWidget {
  final double _radius;

  PicturieLogo({Key key, @required radius}) : _radius = radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: CircleAvatar(
        radius: _radius,
        child: Image.asset("assets/icons/picturie_logo.png"),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
