import 'package:flutter/material.dart';
import 'package:picturie/src/common/sign_in_data.dart';

class PasswordFormField extends StatefulWidget {
  final SignInData _signInData;

  PasswordFormField({Key key, signInData}) : _signInData = signInData;

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
          hintText: "Password",
        ),
        validator: _validatePassword,
        onSaved: (String acceptedPassword) {
          widget._signInData.password = acceptedPassword;
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
