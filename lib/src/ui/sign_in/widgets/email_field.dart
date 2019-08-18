import 'package:flutter/material.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController _emailController;

  EmailFormField({Key key, controller}) : _emailController = controller;

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        controller: widget._emailController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: " E-mail",
        ),
      ),
    );
  }
}
