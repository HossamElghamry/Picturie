import 'package:flutter/material.dart';

class SignUpEmailField extends StatefulWidget {
  @override
  _SignUpEmailFieldState createState() => _SignUpEmailFieldState();
}

class _SignUpEmailFieldState extends State<SignUpEmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: "Enter your e-mail",
        ),
      ),
    );
  }
}
