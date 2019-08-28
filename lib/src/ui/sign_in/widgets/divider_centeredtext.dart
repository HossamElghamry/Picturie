import 'package:flutter/material.dart';

class DividerCenterText extends StatelessWidget {
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
          width: 120,
          child: Center(
            child: Text("Or Sign Up With"),
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
