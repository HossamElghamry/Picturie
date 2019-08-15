import 'package:flutter/material.dart';

class SignUpPasswordField extends StatefulWidget {
  @override
  _SignUpPasswordFieldState createState() => _SignUpPasswordFieldState();
}

class _SignUpPasswordFieldState extends State<SignUpPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: "Enter the desired password",
        ),
      ),
    );
  }
}
