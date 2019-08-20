import 'package:flutter/material.dart';

class PicturieTextLogo extends StatelessWidget {
  final double _textSize;

  PicturieTextLogo({Key key, textSize}) : _textSize = textSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Text(
        "PICTURIE",
        style: TextStyle(fontSize: _textSize),
      ),
    );
  }
}
