import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController _passwordController;

  PasswordFormField({Key key, controller}) : _passwordController = controller;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        controller: widget._passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: " Password",
        ),
      ),
    );
  }
}
