import 'package:flutter/material.dart';
import 'package:picturie/src/common/sign_up_data.dart';

class SignUpUsernameField extends StatefulWidget {
  final SignUpData _data;
  SignUpUsernameField({Key key, data}) : _data = data;

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
        validator: _validateUsername,
        onSaved: (String acceptedUsername) {
          widget._data.username = acceptedUsername;
        },
      ),
    );
  }

  String _validateUsername(String username) {
    if (username.length < 4) {
      return "Username must at least contain 4 characters";
    }
    return null;
  }
}
