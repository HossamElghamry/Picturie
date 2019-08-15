import 'package:flutter/material.dart';

class EmailFormField extends StatefulWidget {
  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: " E-mail",
        ),
      ),
    );
  }
}
