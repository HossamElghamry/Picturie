import 'package:flutter/material.dart';
import 'package:picturie/src/common/sign_up_data.dart';

class SignUpPasswordField extends StatefulWidget {
  final SignUpData _data;
  SignUpPasswordField({Key key, data}) : _data = data;

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
        validator: _validatePassword,
        onSaved: (String acceptedPassword) {
          widget._data.password = acceptedPassword;
        },
      ),
    );
  }

  String _validatePassword(String password) {
    if (password.length < 4) {
      return "Password must at least contain 8 characters";
    }
    return null;
  }
}
