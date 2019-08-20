import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.red,
        child: Text(
          "Skip",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void uploadImage() {
    return;
  }
}
