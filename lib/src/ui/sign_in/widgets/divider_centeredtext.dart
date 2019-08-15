import 'package:flutter/material.dart';

class DividerCentereText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Color(0xFF66FFDA),
          ),
        ),
        Container(
          width: 50,
          child: Center(
            child: Text("OR"),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFF66FFDA),
          ),
        ),
      ],
    );
  }
}
