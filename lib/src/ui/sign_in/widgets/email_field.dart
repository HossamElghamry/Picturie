import 'package:flutter/material.dart';
import 'package:picturie/src/common/sign_in_data.dart';

class EmailFormField extends StatefulWidget {
  final SignInData _signInData;

  EmailFormField({Key key, signInData}) : _signInData = signInData;

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
        validator: _validateEmail,
        onSaved: (String acceptedEmail) {
          widget._signInData.email = acceptedEmail;
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
