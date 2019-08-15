import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: " Password",
        ),
      ),
    );
  }
}
