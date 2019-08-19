import 'package:flutter/material.dart';
import 'package:picturie/src/common/sign_up_data.dart';

class SignUpEmailField extends StatefulWidget {
  final SignUpData _data;
  SignUpEmailField({Key key, data}) : _data = data;

  @override
  _SignUpEmailFieldState createState() => _SignUpEmailFieldState();
}

class _SignUpEmailFieldState extends State<SignUpEmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Enter your e-mail",
        ),
        validator: _validateEmail,
        onSaved: (String acceptedEmail) {
          widget._data.email = acceptedEmail;
        },
      ),
    );
  }

  String _validateEmail(String email) {
    //TODO: Validate
    if (!email.contains('@')) {
      return "The e-mail address entered must be a valid one.";
    }
    return null;
  }
}
