import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.teal,
        child: Text(
          "Sign In",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
