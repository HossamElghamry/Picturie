import 'package:flutter/material.dart';

class PostStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Picturies",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "12",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 40,
              width: 1,
              color: Color(0xFF64FFDA),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Likes",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "205",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
