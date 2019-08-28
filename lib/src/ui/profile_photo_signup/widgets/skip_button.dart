import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      height: 45,
      child: RaisedButton(
        elevation: 0,
        shape: StadiumBorder(),
        color: Colors.red[700],
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Icon(
                Icons.arrow_forward,
                size: 34,
              ),
            ),
            Text(
              "  SKIP",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
