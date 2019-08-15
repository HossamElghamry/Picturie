import 'package:flutter/material.dart';

class SignUpUsernameField extends StatefulWidget {
  @override
  _SignUpUsernameFieldState createState() => _SignUpUsernameFieldState();
}

class _SignUpUsernameFieldState extends State<SignUpUsernameField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: "Enter your username",
        ),
      ),
    );
  }
}
